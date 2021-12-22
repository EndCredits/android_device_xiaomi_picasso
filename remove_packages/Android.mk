LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := RemovePkgs
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_TAGS := optional
LOCAL_OVERRIDES_PACKAGES := AmbientSensePrebuilt Drive FM2 MyVerizonServices OBDM_Permissions OemDmTrigger PrebuiltGmail Showcase SprintDM SprintHM YouTube YouTubeMusicPrebuilt VZWAPNLib VzwOmaTrigger libqcomfm_jni obdm_stub qcom.fmradio NfcNci TipsPrebuilt MicropaperPrebuilt NgaResources RecorderPrebuilt SafetyHubPrebuilt WallpapersBReel2020 SoundAmplifierPrebuilt AppDirectedSMSService ConnMO DCMO USCCDM arcore talkback DevicePolicyPrebuilt AndroidAutoStubPrebuilt Via PlayGames GooglePlayServicesforAR ARCore KeepNotes Keep PixelLiveWallpaper PixelBuds
LOCAL_UNINSTALLABLE_MODULE := true
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_SRC_FILES := /dev/null
include $(BUILD_PREBUILT)
