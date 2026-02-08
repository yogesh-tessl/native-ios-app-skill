#!/bin/bash
# Ralph OG - iOS Environment Setup
# Run this at the start of each iteration to verify the environment

set -e

echo "=== iOS Development Environment Check ==="

# Check Xcode
echo "Checking Xcode..."
if ! command -v xcodebuild &> /dev/null; then
    echo "ERROR: Xcode command line tools not found"
    exit 1
fi
XCODE_VERSION=$(xcodebuild -version | head -n1)
echo "  $XCODE_VERSION"

# Check Swift
echo "Checking Swift..."
if ! command -v swift &> /dev/null; then
    echo "ERROR: Swift not found"
    exit 1
fi
SWIFT_VERSION=$(swift --version 2>&1 | head -n1)
echo "  $SWIFT_VERSION"

# Check for .xcodeproj or .xcworkspace
echo "Checking project..."
if ls *.xcworkspace 1> /dev/null 2>&1; then
    WORKSPACE=$(ls *.xcworkspace | head -n1)
    echo "  Found workspace: $WORKSPACE"
elif ls *.xcodeproj 1> /dev/null 2>&1; then
    PROJECT=$(ls *.xcodeproj | head -n1)
    echo "  Found project: $PROJECT"
else
    echo "  WARNING: No Xcode project or workspace found"
fi

# Check available schemes
echo "Available schemes:"
xcodebuild -list 2>/dev/null | grep -A 100 "Schemes:" | tail -n +2 | head -10 || echo "  (none found)"

# Check simulator availability
echo "Checking simulators..."
SIMULATOR_COUNT=$(xcrun simctl list devices available | grep -c "iPhone" || echo "0")
echo "  $SIMULATOR_COUNT iPhone simulators available"

# Check git status
echo "Git status..."
if git rev-parse --is-inside-work-tree &> /dev/null; then
    BRANCH=$(git branch --show-current)
    COMMITS=$(git rev-list --count HEAD 2>/dev/null || echo "0")
    echo "  Branch: $BRANCH ($COMMITS commits)"
else
    echo "  WARNING: Not a git repository"
fi

# Check design system
echo "Design system..."
if [ -d ".design-system" ]; then
    echo "  Found .design-system/"
    if [ -f ".design-system/tokens.swift" ]; then
        echo "  Design tokens: OK"
    else
        echo "  WARNING: tokens.swift not found"
    fi
else
    echo "  No design system configured"
fi

echo "=== Environment Ready ==="
