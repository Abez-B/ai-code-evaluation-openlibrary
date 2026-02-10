#!/bin/bash
#
# Repository Setup Script for SWE-bench Evaluation
# This script sets up the OpenLibrary repository for testing
#

set -e  # Exit on error

echo "=== Starting Repository Setup ==="

# Variables
REPO_URL="https://github.com/internetarchive/openlibrary.git"
TARGET_DIR="/testbed"
BASE_COMMIT="84cc4ed5697b83a849e9106a09bfed501169cc20"
TEST_COMMIT="c4eebe6677acc4629cb541a98d5e91311444f5d4"
TEST_FILE="openlibrary/tests/core/test_imports.py"

# Clean up any existing repository
echo "Cleaning up existing repository..."
sudo rm -rf "$TARGET_DIR"

# Clone the repository
echo "Cloning OpenLibrary repository..."
sudo git clone "$REPO_URL" "$TARGET_DIR"

# Fix permissions
echo "Setting permissions..."
sudo chown -R $USER:$USER "$TARGET_DIR"

# Navigate to repository
cd "$TARGET_DIR"

# Configure git
echo "Configuring git..."
git config --global --add safe.directory "$TARGET_DIR"

# Reset to base commit
echo "Resetting to base commit: $BASE_COMMIT"
git reset --hard "$BASE_COMMIT"

# Clean untracked files
echo "Cleaning untracked files..."
git clean -fd

# Checkout to the base commit
echo "Checking out base commit..."
git checkout "$BASE_COMMIT"

# Checkout the test file from the test commit
echo "Checking out test file from commit: $TEST_COMMIT"
git checkout "$TEST_COMMIT" -- "$TEST_FILE"

echo "=== Repository Setup Complete ==="
echo "Repository location: $TARGET_DIR"
echo "Ready for testing!"
