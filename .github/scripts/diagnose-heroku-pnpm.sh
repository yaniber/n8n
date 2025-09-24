#!/bin/bash
# Diagnostic script to reproduce Heroku pnpm install failure
# This script simulates the Heroku build environment to identify issues

set -e

echo "=========================================="
echo "Heroku pnpm install diagnostics"
echo "=========================================="

echo "Setting up corepack and pnpm..."
corepack enable
corepack prepare pnpm@10.16.0 --activate

echo "Current environment:"
echo "NODE_ENV=$NODE_ENV"
echo "pnpm version: $(pnpm --version)"
echo "node version: $(node --version)"

echo "=========================================="
echo "Running production install (simulating Heroku)..."
echo "NODE_ENV=production pnpm install --frozen-lockfile"
echo "=========================================="

# Create diagnostics directory
mkdir -p diagnostics

# Run the command and capture output
NODE_ENV=production pnpm install --frozen-lockfile 2>&1 | tee diagnostics/heroku-pnpm-install.log

echo "=========================================="
echo "Install completed. Check diagnostics/heroku-pnpm-install.log for details"
echo "=========================================="