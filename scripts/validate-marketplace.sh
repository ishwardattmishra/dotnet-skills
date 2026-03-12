#!/bin/bash
# Validates that the Cursor skills repository structure is consistent

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
SKILLS_DIR="$REPO_ROOT/skills"
RULES_DIR="$REPO_ROOT/.cursor/rules"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

errors=0
warnings=0

echo "Validating Cursor skills repository structure..."
echo ""

# Check skills directory exists
if [ ! -d "$SKILLS_DIR" ]; then
    echo -e "${RED}ERROR: Skills directory not found: $SKILLS_DIR${NC}"
    exit 1
fi

# Check skills
echo "Checking skills..."
skill_count=0
while IFS= read -r skill_file; do
    if [ ! -f "$skill_file" ]; then
        continue
    fi
    
    # Check YAML frontmatter
    if ! head -1 "$skill_file" | grep -q "^---$"; then
        echo -e "${RED}ERROR: Missing YAML frontmatter in $skill_file${NC}"
        ((++errors))
        continue
    fi
    
    # Check for required fields
    if ! grep -q "^name:" "$skill_file"; then
        echo -e "${RED}ERROR: Missing 'name' field in $skill_file${NC}"
        ((++errors))
        continue
    fi
    
    if ! grep -q "^description:" "$skill_file"; then
        echo -e "${RED}ERROR: Missing 'description' field in $skill_file${NC}"
        ((++errors))
        continue
    fi
    
    # Extract skill name
    skill_name=$(grep -m1 "^name:" "$skill_file" | sed 's/^name:[[:space:]]*//')
    echo -e "${GREEN}OK: $skill_name${NC}"
    ((++skill_count))
done < <(find "$SKILLS_DIR" -name "SKILL.md" 2>/dev/null)

# Check rules if directory exists
echo ""
echo "Checking Cursor rules..."
rule_count=0
if [ -d "$RULES_DIR" ]; then
    while IFS= read -r rule_file; do
        if [ ! -f "$rule_file" ]; then
            continue
        fi
        
        # Check YAML frontmatter
        if ! head -1 "$rule_file" | grep -q "^---$"; then
            echo -e "${RED}ERROR: Missing YAML frontmatter in $rule_file${NC}"
            ((++errors))
            continue
        fi
        
        # Check for required fields
        if ! grep -q "^description:" "$rule_file"; then
            echo -e "${RED}ERROR: Missing 'description' field in $rule_file${NC}"
            ((++errors))
            continue
        fi
        
        if ! grep -q "^alwaysApply:" "$rule_file"; then
            echo -e "${RED}ERROR: Missing 'alwaysApply' field in $rule_file${NC}"
            ((++errors))
            continue
        fi
        
        # Extract rule name from filename
        rule_name=$(basename "$rule_file" .mdc)
        echo -e "${GREEN}OK: $rule_name${NC}"
        ((++rule_count))
    done < <(find "$RULES_DIR" -name "*.mdc" 2>/dev/null)
else
    echo -e "${YELLOW}WARNING: No .cursor/rules/ directory found${NC}"
    ((++warnings))
fi

# Summary
echo ""
echo "=== Summary ==="
echo "Skills found: $skill_count"
echo "Rules found: $rule_count"

if [ $errors -gt 0 ]; then
    echo -e "${RED}Errors: $errors${NC}"
    exit 1
fi

if [ $warnings -gt 0 ]; then
    echo -e "${YELLOW}Warnings: $warnings${NC}"
fi

echo -e "${GREEN}Validation passed!${NC}"
