LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := $(call all-java-files-under, src)

LOCAL_PACKAGE_NAME := XiaomiParts
LOCAL_PRIVATE_PLATFORM_APIS := true
LOCAL_SYSTEM_EXT_MODULE := true
LOCAL_CERTIFICATE := platform
LOCAL_PRIVILEGED_MODULE := true

LOCAL_USE_AAPT2 := true

LOCAL_STATIC_ANDROID_LIBRARIES := \
    SettingsLib

LOCAL_STATIC_JAVA_LIBRARIES := \
    vendor.xiaomi.hardware.displayfeature-V1.0-java \
    vendor.xiaomi.hardware.touchfeature-V1.0-java

LOCAL_PROGUARD_FLAG_FILES := proguard.flags

LOCAL_STATIC_JAVA_LIBRARIES := \
    vendor.xiaomi.hardware.touchfeature-V1.0-java

LOCAL_RESOURCE_DIR := \
    $(LOCAL_PATH)/res \
    $(TOP)/packages/resources/devicesettings/res

ifneq ($(INCREMENTAL_BUILDS),)
    LOCAL_PROGUARD_ENABLED := disabled
    LOCAL_JACK_ENABLED := incremental
endif

include $(BUILD_PACKAGE)
