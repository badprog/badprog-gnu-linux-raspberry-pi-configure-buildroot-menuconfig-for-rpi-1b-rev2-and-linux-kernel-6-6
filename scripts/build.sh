#!/bin/bash
# badprog.com
set -euo pipefail

# Global directories configuration
BUILDROOT_DIR=/opt/buildroot
PROJ_DIR=/workspaces/embedded-linux
OUTPUT_DIR=${PROJ_DIR}/output
OVERLAY_DIR=${PROJ_DIR}/buildroot-config/overlay

echo "[badprog] Starting minimal build..."

# Capture the start time in seconds
START_TIME=$SECONDS

# Wrap the build with the 'time' utility to print raw execution stats
time make -C "${BUILDROOT_DIR}" -j$(nproc) O="${OUTPUT_DIR}" BR2_ROOTFS_OVERLAY="${OVERLAY_DIR}"

# Calculate total elapsed time
END_TIME=$SECONDS
ELAPSED_TIME=$((END_TIME - START_TIME))

# Format the time into minutes and seconds
MINUTES=$((ELAPSED_TIME / 60))
SECONDS_LEFT=$((ELAPSED_TIME % 60))

echo "--------------------------------------------------"
echo "[badprog] Build complete."
echo "[badprog] Total build time: ${MINUTES}m ${SECONDS_LEFT}s"
echo "[badprog] Output images: ${OUTPUT_DIR}/images/"
ls -lh "${OUTPUT_DIR}/images/"
