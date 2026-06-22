#!/bin/bash
# badprog.com
set -e

# Prevent ccache to see if date and time have changed 
# export CCACHE_COMPILERCHECK=content
# export CCACHE_SLOPPINESS=time_macros,file_macro,include_file_mtime,include_file_ctime
# export CCACHE_BASEDIR=/workspaces/embedded-linux

# Global directories configuration
BUILDROOT_DIR=/opt/buildroot
OUTPUT_DIR=/workspaces/embedded-linux/output
# OUTPUT_EXT_CONFIG=${OUTPUT_DIR}/br2-external/configs/badprog_config_defconfig
# Point to the shared mutualized directory
DL_DIR=/workspaces/common/dl
WORKSPACE_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OVERLAY_DIR=${WORKSPACE_DIR}/buildroot-config/overlay

echo "[badprog] Starting minimal build..."

# Capture the start time in seconds
START_TIME=$SECONDS

# Compile using the existing .config inside the output directory
# Wrap the build with the 'time' utility to print raw execution stats
# time make -C "${BUILDROOT_DIR}" O="${OUTPUT_DIR}" BR2_DL_DIR="${DL_DIR}" BR2_DEFCONFIG="${OUTPUT_EXT_CONFIG}" defconfig

time make -C "${BUILDROOT_DIR}" -j$(nproc) O="${OUTPUT_DIR}" BR2_DL_DIR="${DL_DIR}" BR2_ROOTFS_OVERLAY="${OVERLAY_DIR}"

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
