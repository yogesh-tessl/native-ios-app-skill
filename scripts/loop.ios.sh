#!/bin/bash
# Ralph OG iOS Loop Script
# Autonomous iOS development with fresh context per iteration

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
RALPH_DIR="$PROJECT_DIR/.ralph-og"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
ITERATION=0
START_TIME=$(date +%s)

echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║           Ralph OG iOS - Autonomous Development        ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${YELLOW}Project:${NC} $PROJECT_DIR"
echo -e "${YELLOW}Started:${NC} $(date)"
echo ""

# Check prerequisites
if [ ! -f "$RALPH_DIR/PROMPT.md" ]; then
    echo -e "${RED}ERROR: PROMPT.md not found. Run /native-ios-app ralph first.${NC}"
    exit 1
fi

if [ ! -f "$RALPH_DIR/feature-list.json" ]; then
    echo -e "${RED}ERROR: feature-list.json not found.${NC}"
    exit 1
fi

# Main loop
while true; do
    ITERATION=$((ITERATION + 1))
    ITER_START=$(date +%s)

    echo ""
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}  ITERATION $ITERATION - $(date '+%H:%M:%S')${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

    # Show current feature status
    PASSING=$(grep -c '"status": "passing"' "$RALPH_DIR/feature-list.json" 2>/dev/null || echo "0")
    FAILING=$(grep -c '"status": "failing"' "$RALPH_DIR/feature-list.json" 2>/dev/null || echo "0")
    BLOCKED=$(grep -c '"status": "blocked"' "$RALPH_DIR/feature-list.json" 2>/dev/null || echo "0")

    echo -e "${BLUE}Features:${NC} ${GREEN}$PASSING passing${NC} | ${RED}$FAILING failing${NC} | ${YELLOW}$BLOCKED blocked${NC}"

    # Run Claude with the prompt
    cd "$PROJECT_DIR"
    cat "$RALPH_DIR/PROMPT.md" | claude -p --dangerously-skip-permissions

    # Check for completion signal
    if grep -q "RALPH_COMPLETE" "$RALPH_DIR/progress.txt" 2>/dev/null; then
        echo ""
        echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${NC}"
        echo -e "${GREEN}║              🎉 RALPH OG COMPLETE! 🎉                   ║${NC}"
        echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${NC}"

        END_TIME=$(date +%s)
        TOTAL_TIME=$((END_TIME - START_TIME))
        HOURS=$((TOTAL_TIME / 3600))
        MINUTES=$(((TOTAL_TIME % 3600) / 60))

        echo ""
        echo -e "${BLUE}Summary:${NC}"
        echo "  Iterations: $ITERATION"
        echo "  Duration:   ${HOURS}h ${MINUTES}m"
        echo "  Completed:  $(date)"
        echo ""

        exit 0
    fi

    # Iteration timing
    ITER_END=$(date +%s)
    ITER_DURATION=$((ITER_END - ITER_START))

    echo ""
    echo -e "${YELLOW}Iteration $ITERATION completed in ${ITER_DURATION}s${NC}"

    # Brief pause between iterations
    echo -e "${BLUE}Starting next iteration in 3 seconds...${NC}"
    sleep 3
done
