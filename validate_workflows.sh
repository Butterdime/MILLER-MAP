#!/usr/bin/env bash

# validate_workflows.sh
# Pre-flight validation script for Miller Maps workflows and deployment
# Run this before committing workflow or code changes

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}⚔️  Miller Maps Validation Script${NC}"
echo -e "${BLUE}===============================${NC}"
echo ""

# Check if we're in the right directory
if [ ! -f "main.py" ] || [ ! -f "Dockerfile" ]; then
    echo -e "${RED}❌ Error: Not in Miller Maps project root${NC}"
    echo "Please run from the MILLER-MAP directory"
    exit 1
fi

echo -e "${GREEN}✅ Project directory validated${NC}"

# Validate Python script
echo -e "\n${BLUE}🔍 Validating main.py...${NC}"
if python3 -m py_compile main.py; then
    echo -e "${GREEN}✅ main.py syntax is valid${NC}"
else
    echo -e "${RED}❌ main.py has syntax errors${NC}"
    exit 1
fi

# Test build process
echo -e "\n${BLUE}🏗️ Testing build process...${NC}"
if python3 main.py; then
    echo -e "${GREEN}✅ Build process completed successfully${NC}"
else
    echo -e "${RED}❌ Build process failed${NC}"
    exit 1
fi

# Check for required files
echo -e "\n${BLUE}📄 Validating generated files...${NC}"
required_files=("index.html" "docs/index.html" "public/index.html" "build_info.json")

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo -e "${GREEN}✅ $file exists${NC}"
    else
        echo -e "${YELLOW}⚠️  $file missing (will be generated during deployment)${NC}"
    fi
done

# Validate Docker build
echo -e "\n${BLUE}🐳 Validating Dockerfile...${NC}"
if command -v docker &> /dev/null; then
    if docker build -t miller-maps-test . --quiet; then
        echo -e "${GREEN}✅ Docker build successful${NC}"
        # Cleanup test image
        docker rmi miller-maps-test --quiet || true
    else
        echo -e "${RED}❌ Docker build failed${NC}"
        exit 1
    fi
else
    echo -e "${YELLOW}⚠️  Docker not available - skipping container validation${NC}"
fi

# Validate workflow files
echo -e "\n${BLUE}⚙️ Validating GitHub workflows...${NC}"
workflow_files=(".github/workflows/ci.yml" ".github/workflows/deploy.yml" ".github/workflows/cloud-run.yml")

for workflow in "${workflow_files[@]}"; do
    if [ -f "$workflow" ]; then
        echo -e "${GREEN}✅ $workflow exists${NC}"
        # Basic YAML validation (if yq is available)
        if command -v yq &> /dev/null; then
            if yq eval . "$workflow" > /dev/null 2>&1; then
                echo -e "${GREEN}   ✓ Valid YAML syntax${NC}"
            else
                echo -e "${RED}   ❌ Invalid YAML syntax${NC}"
                exit 1
            fi
        fi
    else
        echo -e "${RED}❌ $workflow missing${NC}"
        exit 1
    fi
done

# Final validation summary
echo -e "\n${GREEN}✨ All validations passed!${NC}"
echo -e "${BLUE}Ready for deployment:\n${NC}"
echo -e "  • GitHub Pages: Will deploy automatically on push"
echo -e "  • Cloud Run: Requires GCP secrets in repository"
echo -e "  • Logs: Use ./download_logs.sh -r <RUN_ID> for troubleshooting"
echo ""
echo -e "${GREEN}🚀 Safe to commit and push!${NC}"