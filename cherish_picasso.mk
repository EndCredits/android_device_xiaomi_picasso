#
# Copyright (C) 2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from picasso device
$(call inherit-product, device/xiaomi/picasso/device.mk)

# Inherit some common Cherish stuff.
$(call inherit-product, vendor/cherish/config/common_full_phone.mk)
WITH_GMS := true

# Cherishos-specific stuff
CHERISH_BUILD_TYPE := OFFICIAL

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.cherish.maintainer=DinhSan

# Device identifier. This must come after all inclusions.
PRODUCT_NAME := cherish_picasso
PRODUCT_DEVICE := picasso
PRODUCT_MODEL := Redmi K30 5G
PRODUCT_BRAND := Redmi
PRODUCT_MANUFACTURER := Xiaomi

# Build info
BUILD_FINGERPRINT := "Redmi/picasso/picasso:11/RKQ1.200826.002/V12.5.2.0.RGICNXM:user/release-keys"

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
