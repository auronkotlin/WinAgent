#!/bin/bash
set -e

echo "Building OpenClaw Docker image..."
docker build -t openclaw .

echo "Build complete"
