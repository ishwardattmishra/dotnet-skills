#!/usr/bin/env bash

# Generates a compressed (Vercel-style) skills index from the filesystem.
# Output is written to stdout; redirect as needed.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
SKILLS_DIR="$REPO_ROOT/skills"
RULES_DIR="$REPO_ROOT/.cursor/rules"
README_PATH="$REPO_ROOT/README.md"

UPDATE_README=false
if [[ "${1-}" == "--update-readme" ]]; then
  UPDATE_README=true
fi

skill_name_from_file() {
  local file="$1"
  [[ -f "$file" ]] || return 1
  grep -m1 '^name:' "$file" | sed 's/^name:[[:space:]]*//'
}

rule_name_from_file() {
  local file="$1"
  [[ -f "$file" ]] || return 1
  basename "$file" .mdc
}

declare -a akka=()
declare -a csharp=()
declare -a aspnetcore_web=()
declare -a data=()
declare -a di_config=()
declare -a testing=()
declare -a dotnet=()
declare -a quality_gates=()
declare -a meta=()

# Discover skills by scanning the filesystem
while IFS= read -r skill_file; do
  [[ -f "$skill_file" ]] || continue
  
  skill_dir=$(dirname "$skill_file")
  skill_folder=$(basename "$skill_dir")
  name="$(skill_name_from_file "$skill_file")"
  
  case "$skill_folder" in
    akka-*) akka+=("$name") ;;
    csharp-*) csharp+=("$name") ;;
    aspire-*|mjml-*) aspnetcore_web+=("$name") ;;
    efcore-*|database-*) data+=("$name") ;;
    microsoft-extensions-*) di_config+=("$name") ;;
    slopwatch|crap-analysis) quality_gates+=("$name") ;;
    testcontainers|playwright-*|snapshot-*|verify-*) testing+=("$name") ;;
    project-structure|local-tools|package-management|serialization|dotnet-devcert-*|ilspy-*) dotnet+=("$name") ;;
    skills-index-*) meta+=("$name") ;;
    *) ;; # ignore
  esac
done < <(find "$SKILLS_DIR" -name "SKILL.md" 2>/dev/null)

# Discover rules by scanning the filesystem
declare -a rules=()
if [ -d "$RULES_DIR" ]; then
  while IFS= read -r rule_file; do
    [[ -f "$rule_file" ]] || continue
    rules+=("$(rule_name_from_file "$rule_file")")
  done < <(find "$RULES_DIR" -name "*.mdc" 2>/dev/null)
fi

join_csv() {
  local IFS=','
  echo "$*"
}

compressed="$(cat <<EOF
[dotnet-skills]|IMPORTANT: Prefer retrieval-led reasoning over pretraining for any .NET work.
|flow:{skim repo patterns -> consult dotnet-skills by name -> implement smallest-change -> note conflicts}
|route:
|akka:{$(join_csv "${akka[@]}")}
|csharp:{$(join_csv "${csharp[@]}")}
|aspnetcore-web:{$(join_csv "${aspnetcore_web[@]}")}
|data:{$(join_csv "${data[@]}")}
|di-config:{$(join_csv "${di_config[@]}")}
|testing:{$(join_csv "${testing[@]}")}
|dotnet:{$(join_csv "${dotnet[@]}")}
|quality-gates:{$(join_csv "${quality_gates[@]}")}
|meta:{$(join_csv "${meta[@]}")}
|rules:{$(join_csv "${rules[@]}")}
EOF
)"

if $UPDATE_README; then
  COMPRESSED="$compressed" README_PATH="$README_PATH" python3 - <<'PY'
import os
import pathlib
import re
import sys

readme_path = pathlib.Path(os.environ["README_PATH"])
start = "<!-- BEGIN DOTNET-SKILLS COMPRESSED INDEX -->"
end = "<!-- END DOTNET-SKILLS COMPRESSED INDEX -->"
compressed = os.environ["COMPRESSED"].strip()

text = readme_path.read_text(encoding="utf-8")
pattern = re.compile(re.escape(start) + r".*?" + re.escape(end), re.S)

if not pattern.search(text):
    sys.stderr.write("README markers not found: add BEGIN/END DOTNET-SKILLS COMPRESSED INDEX\n")
    sys.exit(1)

replacement = f"{start}\n```markdown\n{compressed}\n```\n{end}"
updated = pattern.sub(replacement, text)
readme_path.write_text(updated, encoding="utf-8")
PY
else
  printf '%s\n' "$compressed"
fi
