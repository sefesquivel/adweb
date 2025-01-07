#!/bin/bash
# improved-check-progress.sh

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color
TOTAL_SCORE=0
MAX_SCORE=62  # Total possible points (47 + 15 for routing)

echo -e "${YELLOW}Starting Detailed Conference App Evaluation...${NC}\n"

# Function to check file content
check_content() {
    local file=$1
    local pattern=$2
    if [ -f "$file" ] && grep -q "$pattern" "$file"; then
        return 0
    else
        return 1
    fi
}

# Check Project Structure (12 points)
echo -e "${YELLOW}1. Project Structure Check${NC}"

# Check if components exist and have proper content
components=("home" "about" "partners" "join")
component_score=0

for comp in "${components[@]}"; do
    echo -n "Checking ${comp} component: "
    
    # Check component file existence
    if [ -f "src/app/components/${comp}/${comp}.component.ts" ]; then
        # Check for standalone component
        if check_content "src/app/components/${comp}/${comp}.component.ts" "standalone: true"; then
            echo -e "${GREEN}✓ (Standalone component found)${NC}"
            component_score=$((component_score + 1))
        else
            echo -e "${RED}✗ (Not a standalone component)${NC}"
        fi
    else
        echo -e "${RED}✗ (Component file missing)${NC}"
    fi
done

TOTAL_SCORE=$((TOTAL_SCORE + (component_score * 3)))
echo "Component Score: $component_score/4 (${component_score}*3 points)"

# Check Routing Configuration (15 points)
echo -e "\n${YELLOW}2. Routing Check${NC}"
routing_score=0

# Check app.routes.ts existence and content
echo -n "Checking routes configuration: "
routes_found=0

if [ -f "src/app/app.routes.ts" ]; then
    # Check for empty path (home) route
    if grep -E "path:.*''.*,.*component:.*HomeComponent" "src/app/app.routes.ts" > /dev/null 2>&1; then
        routes_found=$((routes_found + 1))
        echo -e "\n${GREEN}✓ Found home route${NC}"
    else
        echo -e "\n${RED}✗ Home route not found${NC}"
    fi
    
    # Check for about route
    if grep -E "path:.*'about'.*,.*component:.*AboutComponent" "src/app/app.routes.ts" > /dev/null 2>&1; then
        routes_found=$((routes_found + 1))
        echo -e "${GREEN}✓ Found about route${NC}"
    else
        echo -e "${RED}✗ About route not found${NC}"
    fi
    
    # Check for partners route
    if grep -E "path:.*'partners'.*,.*component:.*PartnersComponent" "src/app/app.routes.ts" > /dev/null 2>&1; then
        routes_found=$((routes_found + 1))
        echo -e "${GREEN}✓ Found partners route${NC}"
    else
        echo -e "${RED}✗ Partners route not found${NC}"
    fi
    
    # Check for join route
    if grep -E "path:.*'join'.*,.*component:.*JoinComponent" "src/app/app.routes.ts" > /dev/null 2>&1; then
        routes_found=$((routes_found + 1))
        echo -e "${GREEN}✓ Found join route${NC}"
    else
        echo -e "${RED}✗ Join route not found${NC}"
    fi

    # Display overall route status
    if [ $routes_found -eq 4 ]; then
        echo -e "\n${GREEN}✓ All routes configured successfully${NC}"
        routing_score=$((routing_score + 5))
    else
        echo -e "\n${RED}✗ Found $routes_found/4 routes${NC}"
    fi
else
    echo -e "${RED}✗ Routes file missing${NC}"
fi

# Check router-outlet usage
echo -n "Checking router-outlet: "
if check_content "src/app/app.component.html" "router-outlet"; then
    echo -e "${GREEN}✓${NC}"
    routing_score=$((routing_score + 5))
else
    echo -e "${RED}✗${NC}"
fi

# Check routerLink usage
echo -n "Checking routerLink usage: "
if find src/app -type f -name "*.html" -exec grep -l '\[routerLink\]=".*"\|\[routerLink\]='"'"'.*'"'"'\|routerLink=".*"' {} \; | grep -q .; then
    echo -e "${GREEN}✓${NC}"
    routing_score=$((routing_score + 5))
else
    echo -e "${RED}✗${NC}"
fi

TOTAL_SCORE=$((TOTAL_SCORE + routing_score))
echo "Routing Score: $routing_score/15 points"

# Check Bootstrap Integration (10 points)
echo -e "\n${YELLOW}3. Bootstrap Integration Check${NC}"

bootstrap_score=0
echo -n "Checking Bootstrap CSS: "
if check_content "src/index.html" "bootstrap.min.css"; then
    echo -e "${GREEN}✓ (index.html)${NC}"
    bootstrap_score=$((bootstrap_score + 3))
else
    echo -e "${RED}✗ (Not in index.html)${NC}"
fi

# New check for Bootstrap in angular.json
echo -n "Checking Bootstrap in angular.json: "
if [ -f "angular.json" ] && grep -q '"node_modules/bootstrap/dist/css/bootstrap.min.css"' "angular.json"; then
    echo -e "${GREEN}✓ (Found in styles)${NC}"
    bootstrap_score=$((bootstrap_score + 2))
else
    echo -e "${RED}✗ (Not in angular.json styles)${NC}"
fi

echo -n "Checking Bootstrap usage in templates: "
if find src/app -type f -name "*.html" -exec grep -l "class=\".*container\|row\|col" {} \; | grep -q .; then
    echo -e "${GREEN}✓${NC}"
    bootstrap_score=$((bootstrap_score + 5))
else
    echo -e "${RED}✗${NC}"
fi

TOTAL_SCORE=$((TOTAL_SCORE + bootstrap_score))
echo "Bootstrap Score: $bootstrap_score/10 points"

# Check Data Binding (15 points)
echo -e "\n${YELLOW}4. Data Binding Check${NC}"

binding_score=0

# Check property binding
echo -n "Checking property binding [property]=: "
if find src/app -type f -name "*.html" -exec grep -l '\[.*\]=".*"' {} \; | grep -q .; then
    echo -e "${GREEN}✓${NC}"
    binding_score=$((binding_score + 5))
else
    echo -e "${RED}✗${NC}"
fi

# Check event binding
echo -n "Checking event binding (event)=: "
if find src/app -type f -name "*.html" -exec grep -l '(click)=' {} \; | grep -q .; then
    echo -e "${GREEN}✓${NC}"
    binding_score=$((binding_score + 5))
else
    echo -e "${RED}✗${NC}"
fi

# Check two-way binding
echo -n "Checking two-way binding [(ngModel)]=: "
if find src/app -type f -name "*.html" -exec grep -l '\[(ngModel)\]=".*"' {} \; | grep -q .; then
    echo -e "${GREEN}✓${NC}"
    binding_score=$((binding_score + 5))
else
    echo -e "${RED}✗${NC}"
fi

TOTAL_SCORE=$((TOTAL_SCORE + binding_score))
echo "Binding Score: $binding_score/15 points"

# Check Directives (10 points)
echo -e "\n${YELLOW}5. Directives Check${NC}"

directive_score=0

# Check *ngIf
echo -n "Checking *ngIf usage: "
if find src/app -type f -name "*.html" -exec grep -l '\*ngIf=".*"' {} \; | grep -q .; then
    echo -e "${GREEN}✓${NC}"
    directive_score=$((directive_score + 5))
else
    echo -e "${RED}✗${NC}"
fi

# Check *ngFor
echo -n "Checking *ngFor usage: "
if find src/app -type f -name "*.html" -exec grep -l '\*ngFor=".*"' {} \; | grep -q .; then
    echo -e "${GREEN}✓${NC}"
    directive_score=$((directive_score + 5))
else
    echo -e "${RED}✗${NC}"
fi

TOTAL_SCORE=$((TOTAL_SCORE + directive_score))
echo "Directive Score: $directive_score/10 points"

# Calculate percentage
PERCENTAGE=$((TOTAL_SCORE * 100 / MAX_SCORE))

# Show final results
echo -e "\n${YELLOW}Final Results:${NC}"
echo -e "Component Structure: ${GREEN}$((component_score * 3))${NC}/12 points"
echo -e "Routing Implementation: ${GREEN}$routing_score${NC}/15 points"
echo -e "Bootstrap Integration: ${GREEN}$bootstrap_score${NC}/10 points"
echo -e "Data Binding: ${GREEN}$binding_score${NC}/15 points"
echo -e "Directives: ${GREEN}$directive_score${NC}/10 points"
echo -e "\nTotal Score: ${GREEN}$TOTAL_SCORE${NC}/$MAX_SCORE"
echo -e "Percentage: ${GREEN}$PERCENTAGE%${NC}"

# Recommendations based on scores
echo -e "\n${YELLOW}Recommendations:${NC}"
if [ $((component_score * 3)) -lt 12 ]; then
    echo "- Add missing standalone components or check component configurations"
fi
if [ $routing_score -lt 15 ]; then
    echo "- Set up proper routing configuration:"
    echo "  * Verify route definitions in app.routes.ts"
    echo "  * Each route should follow the format: { path: 'path', component: Component }"
    echo "  * Add router-outlet to app.component.html"
    echo "  * Use [routerLink] or routerLink in navigation menu"
fi
if [ $bootstrap_score -lt 10 ]; then
    echo "- Ensure Bootstrap is properly integrated:"
    echo "  * Add Bootstrap CSS to index.html"
    echo "  * Include Bootstrap styles in angular.json under 'styles' array"
    echo "  * Use Bootstrap classes in templates"
fi
if [ $binding_score -lt 15 ]; then
    echo "- Implement missing data binding features"
fi
if [ $directive_score -lt 10 ]; then
    echo "- Add structural directives (*ngIf, *ngFor) to your templates"
fi

if [ $PERCENTAGE -ge 70 ]; then
    echo -e "\n${GREEN}✓ Project meets minimum requirements!${NC}"
else
    echo -e "\n${RED}✗ Project needs improvement. Focus on the recommendations above.${NC}"
fi