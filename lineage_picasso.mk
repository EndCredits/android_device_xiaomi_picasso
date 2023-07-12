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

# Inherit some common LineageOS stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Device identifier. This must come after all inclusions.
PRODUCT_NAME := lineage_picasso
PRODUCT_DEVICE := picasso
PRODUCT_MODEL := Redmi K30 5G
PRODUCT_BRAND := Redmi
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_SYSTEM_NAME := Redmi K30 5G
PRODUCT_SYSTEM_DEVICE := Redmi K30 5G

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="picasso-user 12 SKQ1.211006.001 V13.0.5.0.SGICNXM release-keys" \
    TARGET_DEVICE="picasso" \
    TARGET_PRODUCT="picasso"

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := Redmi/picasso/picasso:12/SKQ1.211006.001/V13.0.5.0.SGICNXM:user/release-keys

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)

TARGET_BOOT_ANIMATION_RES := 1080

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi
