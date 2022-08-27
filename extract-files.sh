#!/bin/bash
#
# Copyright (C) 2018-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=picasso
VENDOR=xiaomi

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

ANDROID_ROOT="$MY_DIR"/../../..

HELPER="$ANDROID_ROOT"/tools/extract-utils/extract_utils.sh
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
. "$HELPER"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=false

while [ "$1" != "" ]; do
    case $1 in
        -n | --no-cleanup )     CLEAN_VENDOR=false
                                ;;
        -s | --section )        shift
                                SECTION=$1
                                CLEAN_VENDOR=false
                                ;;
        * )                     SRC=$1
                                ;;
    esac
    shift
done

if [ -z "$SRC" ]; then
    SRC=adb
fi

function blob_fixup() {
    case "${1}" in
        vendor/lib64/vendor.qti.hardware.camera.postproc@1.0-service-impl.so)
            hexdump -ve '1/1 "%.2X"' "${2}" | sed "s/210080521F0A0094/210080521F2003D5/g" | xxd -r -p > "${TMPDIR}/${1##*/}"
            mv "${TMPDIR}/${1##*/}" "${2}"
            ;;
        vendor/lib64/vendor.qti.hardware.camera.postproc@1.0-service-impl.so)
            sed -i 's|\x21\x00\x80\x52\x9A\x0A\x00\x94|\x21\x00\x80\x52\x1F\x20\x03\xD5|g' "${2}"
            ;;
        vendor/lib64/camera/components/com.mi.node.watermark.so)
            patchelf --add-needed "lib-watermarkshim.so" "${2}"
            ;;
    esac
}

# Initialize the helper for common device
setup_vendor "$DEVICE" "$VENDOR" "$ANDROID_ROOT" true "$CLEAN_VENDOR"

extract "$MY_DIR"/proprietary-files.txt "$SRC" "$SECTION"

"$MY_DIR"/setup-makefiles.sh
