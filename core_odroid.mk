# Inherit from those products. Most specific first.
# Get some sounds
$(call inherit-product-if-exists, frameworks/base/data/sounds/AllAudio.mk)

# Get the TTS language packs
$(call inherit-product-if-exists, external/svox/pico/lang/all_pico_languages.mk)

# Get a list of languages.
#$(call inherit-product, build/target/product/locales_full.mk)

# Define the host tools and libs that are parts of the SDK.
ifneq ($(filter sdk win_sdk sdk_addon,$(MAKECMDGOALS)),)
-include sdk/build/product_sdk.mk
-include development/build/product_sdk.mk

PRODUCT_PACKAGES += \
    EmulatorSmokeTests
endif

# Additional settings used in all AOSP builds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.config.ringtone=Ring_Synth_04.ogg \
    ro.config.notification_sound=pixiedust.ogg

# Put en_US first in the list, so make it default.
PRODUCT_LOCALES := en_US

AMLOGIC_PRODUCT := true

ALLOW_MISSING_DEPENDENCIES := true

# Include drawables for all densities
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi xxhdpi

PRODUCT_PACKAGES += \
    libWnnEngDic \
    libWnnJpnDic \
    libwnndict \
    WAPPushManager

#PRODUCT_PACKAGES += \
#    Galaxy4 \
#    HoloSpiralWallpaper \
#    MagicSmokeWallpapers \
#    NoiseField \
#    PhaseBeam \
#    VisualizationWallpapers

ifneq ($(TARGET_BUILD_GOOGLE_ATV), true)
PRODUCT_PACKAGES += \
    PhotoTable

PRODUCT_PACKAGES += \
    LiveWallpapers \
    LiveWallpapersPicker
endif

PRODUCT_PACKAGES += \
    Gallery2 \
    OneTimeInitializer \
    SystemUI \
    WallpaperCropper

PRODUCT_PACKAGES += \
    clatd \
    clatd.conf \
    pppd \
    screenrecord

PRODUCT_PACKAGES += \
    librs_jni \
    libvideoeditor_jni \
    libvideoeditor_core \
    libvideoeditor_osal \
    libvideoeditor_videofilters \
    libvideoeditorplayer \

PRODUCT_PACKAGES += \
    audio.primary.default \
    audio_policy.default \
    audio.dia_remote.default \
    local_time.default \
    vibrator.default \
    power.default

PRODUCT_PACKAGES += \
    local_time.default

PRODUCT_COPY_FILES += \
        frameworks/av/media/libeffects/data/audio_effects.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.conf

PRODUCT_PROPERTY_OVERRIDES += \
    ro.carrier=unknown \
    debug.sf.disable_backpressure=1 \
    debug.sf.latch_unsignaled=1 \
    net.tethering.noprovisioning=true

PRODUCT_PACKAGES += \
    BasicDreams \
    CalendarProvider \
    CaptivePortalLogin \
    CertInstaller \
    ExternalStorageProvider \
    FusedLocation \
    InputDevices \
    KeyChain \
    Keyguard \
    PacProcessor \
    libpac \
    ProxyHandler \
    SharedStorageBackup \
    VpnDialogs

$(call inherit-product-if-exists, frameworks/base/data/fonts/fonts.mk)
$(call inherit-product-if-exists, external/google-fonts/dancing-script/fonts.mk)
$(call inherit-product-if-exists, external/google-fonts/carrois-gothic-sc/fonts.mk)
$(call inherit-product-if-exists, external/google-fonts/coming-soon/fonts.mk)
$(call inherit-product-if-exists, external/google-fonts/cutive-mono/fonts.mk)
$(call inherit-product-if-exists, external/noto-fonts/fonts.mk)
$(call inherit-product-if-exists, external/naver-fonts/fonts.mk)
$(call inherit-product-if-exists, external/roboto-fonts/fonts.mk)
$(call inherit-product-if-exists, frameworks/base/data/keyboards/keyboards.mk)
$(call inherit-product-if-exists, frameworks/webview/chromium/chromium.mk)
ifneq ($(TARGET_BUILD_GOOGLE_ATV), true)
  $(call inherit-product, build/target/product/core_base.mk)
else
  $(call inherit-product, device/google/atv/products/atv_base.mk)
endif
#default hardware composer version is 2.0
TARGET_USES_HWC2 := true

ifneq ($(wildcard $(BOARD_AML_VENDOR_PATH)/frameworks/av/LibPlayer),)
    WITH_LIBPLAYER_MODULE := true
else
    WITH_LIBPLAYER_MODULE := false
endif

# set soft stagefright extractor&decoder as defaults
WITH_SOFT_AM_EXTRACTOR_DECODER := true

PRODUCT_PROPERTY_OVERRIDES += \
    debug.hwui.render_dirty_regions=false \
    ro.hwui.texture_cache_size=64.0f \
    camera.disable_zsl_mode=1 \
    debug.hwui.use_buffer_age=false

# USB camera default face
PRODUCT_PROPERTY_OVERRIDES += \
    rw.camera.usb.faceback=true

ifneq ($(TARGET_BUILD_GOOGLE_ATV), true)
PRODUCT_PACKAGES += \
    DocumentsUI \
    DeskClock \
    MusicFX \
    LatinIME \
    Camera2 \
    Music
endif

ifeq ($(TARGET_BUILD_LIVETV), true)
PRODUCT_PACKAGES += \
    libjnidtvepgscanner \
    LiveTv \
    libtunertvinput_jni
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.picture_in_picture.xml:vendor/etc/permissions/android.software.picture_in_picture.xml
endif

PRODUCT_PACKAGES += \
    droidlogic \
    droidlogic-res \
    droidlogic.software.core.xml \
    systemcontrol \
    systemcontrol_static \
    libsystemcontrolservice \
    vendor.amlogic.hardware.systemcontrol@1.0_vendor

PRODUCT_PACKAGES += \
    libdig \
    BluetoothRemote

PRODUCT_PACKAGES += \
    hostapd \
    wpa_supplicant \
    wpa_supplicant.conf \
    dhcpcd.conf \
    libds_jni \
    libsrec_jni \
    system_key_server \
    libwifi-hal \
    libwpa_client \
    libGLES_mali \
    network \
    sdptool \
    e2fsck \
    mkfs.exfat \
    mount.exfat \
    fsck.exfat \
    ntfs-3g \
    ntfsfix \
    mkntfs \
    libxml2 \
    libamgralloc_ext \
    gralloc.$(TARGET_PRODUCT) \
    power.$(TARGET_PRODUCT) \
    hwcomposer.$(TARGET_PRODUCT) \
    memtrack.$(TARGET_PRODUCT) \
    screen_source.$(TARGET_PRODUCT) \
    thermal.$(TARGET_PRODUCT)

#glscaler and 3d format api
PRODUCT_PACKAGES += \
    libdisplaysetting

#native image player surface overlay so
PRODUCT_PACKAGES += \
    libsurfaceoverlay_jni

#native gif decode so
PRODUCT_PACKAGES += \
    libgifdecode_jni

#native bluetooth rc control
PRODUCT_PACKAGES += \
    libamlaudiorc \
    libremotecontrol_jni \
    libremotecontrolserver \
    vendor.amlogic.hardware.remotecontrol@1.0 \
    vendor.amlogic.hardware.remotecontrol@1.0_vendor

PRODUCT_PACKAGES += libomx_av_core_alt \
    libOmxCore \
    libOmxVideo \
    libOmxAudio \
    libHwAudio_dcvdec \
    libthreadworker_alt \
    libdatachunkqueue_alt \
    libOmxBase \
    libomx_framework_alt \
    libomx_worker_peer_alt \
    libfpscalculator_alt \
    libomx_clock_utils_alt \
    libomx_timed_task_queue_alt \
    libstagefrighthw \
    libsecmem \
    secmem \
    2c1a33c0-44cc-11e5-bc3b0002a5d5c51b

# Dm-verity
ifeq ($(BUILD_WITH_DM_VERITY), true)
PRODUCT_SYSTEM_VERITY_PARTITION = /dev/block/system
PRODUCT_VENDOR_VERITY_PARTITION = /dev/block/vendor
# Provides dependencies necessary for verified boot
PRODUCT_SUPPORTS_BOOT_SIGNER := true
PRODUCT_SUPPORTS_VERITY := true
PRODUCT_SUPPORTS_VERITY_FEC := true
# The dev key is used to sign boot and recovery images, and the verity
# metadata table. Actual product deliverables will be re-signed by hand.
# We expect this file to exist with the suffixes ".x509.pem" and ".pk8".
PRODUCT_VERITY_SIGNING_KEY := device/hardkernel/common/security/verity
ifneq ($(TARGET_USE_SECURITY_DM_VERITY_MODE_WITH_TOOL),true)
PRODUCT_PACKAGES += \
        verity_key.amlogic
endif
endif

#########################################################################
#
#                                                App optimization
#
#########################################################################
#ifeq ($(BUILD_WITH_APP_OPTIMIZATION),true)

PRODUCT_COPY_FILES += \
    device/hardkernel/common/optimization/liboptimization_32.so:$(TARGET_COPY_OUT_VENDOR)/lib/liboptimization.so \
    device/hardkernel/common/optimization/config:$(TARGET_COPY_OUT_VENDOR)/package_config/config

PRODUCT_PROPERTY_OVERRIDES += \
    ro.app.optimization=true

ifeq ($(ANDROID_BUILD_TYPE), 64)
PRODUCT_COPY_FILES += \
    device/hardkernel/common/optimization/liboptimization_64.so:$(TARGET_COPY_OUT_VENDOR)/lib64/liboptimization.so
endif
#endif


#########################################################################
#
#                                                Secure OS
#
#########################################################################
ifeq ($(TARGET_USE_OPTEEOS),true)
ifeq ($(TARGET_KERNEL_BUILT_FROM_SOURCE), true)
PRODUCT_PACKAGES += \
	optee_armtz \
	optee
endif

PRODUCT_PACKAGES += \
	tee-supplicant \
	libteec \
	tee_helloworld \
	tee_crypto \
	tee_xtest \
	tdk_auto_test \
	tee_helloworld_ta \
	tee_fail_test_ta \
	tee_crypt_ta \
	tee_os_test_ta \
	tee_rpc_test_ta \
	tee_sims_ta \
	tee_storage_ta \
	tee_storage2_ta \
	tee_storage_benchmark_ta \
	tee_aes_perf_ta \
	tee_sha_perf_ta \
	tee_sdp_basic_ta \
	tee_concurrent_ta \
	tee_concurrent_large_ta

ifeq ($(TARGET_USE_HW_KEYMASTER),true)
PRODUCT_PACKAGES += \
        keystore.$(TARGET_PRODUCT)
endif
endif

#########################################################################
#
#                                     OTA PROPERTY
#
#########################################################################
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.firmware=00502001 \
    ro.product.otaupdateurl=http://10.28.11.53:8080/otaupdate/update
#########################################################################
#
#                                     hardware interfaces
#
#########################################################################
PRODUCT_PACKAGES += \
     android.hardware.soundtrigger@2.0-impl \
     android.hardware.wifi@1.0-service \
     android.hardware.usb@1.0-service

#workround because android.hardware.wifi@1.0-service has not permission to insmod ko
PRODUCT_COPY_FILES += \
        hardware/amlogic/wifi/multi_wifi/android.hardware.wifi@1.0-service.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/android.hardware.wifi@1.0-service.rc

PRODUCT_COPY_FILES += \
    device/hardkernel/common/audio/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml

#Audio HAL
PRODUCT_PACKAGES += \
     android.hardware.audio@2.0-impl \
     android.hardware.audio.effect@2.0-impl \
     android.hardware.audio@2.0-service
#Camera HAL
#ifneq ($(TARGET_BUILD_GOOGLE_ATV), true)
PRODUCT_PACKAGES += \
     android.hardware.camera.provider@2.4-impl \
     android.hardware.camera.provider@2.4-service
#endif

#Power HAL
PRODUCT_PACKAGES += \
     android.hardware.power@1.0-impl \
     android.hardware.power@1.0-service

#Memtack HAL
PRODUCT_PACKAGES += \
     android.hardware.memtrack@1.0-impl \
     android.hardware.memtrack@1.0-service

# Gralloc HAL
PRODUCT_PACKAGES += \
    android.hardware.graphics.mapper@2.0-impl \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service

# HW Composer
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.2-impl \
    android.hardware.graphics.composer@2.2-service

# dumpstate binderized
PRODUCT_PACKAGES += \
    android.hardware.dumpstate@1.0-service.droidlogic


# Keymaster HAL
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service

# new gatekeeper HAL
PRODUCT_PACKAGES += \
    gatekeeper.$(TARGET_PRODUCT) \
    android.hardware.gatekeeper@1.0-impl \
    android.hardware.gatekeeper@1.0-service

#DRM HAL
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-impl:32 \
    android.hardware.drm@1.0-service \
    android.hardware.drm@1.1-service.widevine \
    android.hardware.drm@1.1-service.clearkey \
    move_widevine_data.sh

# HDMITX CEC HAL
PRODUCT_PACKAGES += \
    android.hardware.tv.cec@1.0-impl \
    android.hardware.tv.cec@1.0-service \
    hdmicecd \
    libhdmicec \
    libhdmicec_jni \
    vendor.amlogic.hardware.hdmicec@1.0_vendor \
    hdmi_cec.$(TARGET_PRODUCT)

#light hal
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-impl \
    android.hardware.light@2.0-service

#thermal hal
PRODUCT_PACKAGES += \
    android.hardware.thermal@1.0-impl \
    android.hardware.thermal@1.0-service

PRODUCT_PACKAGES += \
    android.hardware.cas@1.0-service

# DroidVold
PRODUCT_PACKAGES += \
    vendor.amlogic.hardware.droidvold@1.0 \
    vendor.amlogic.hardware.droidvold@1.0_vendor \
    vendor.amlogic.hardware.droidvold-V1.0-java

ifeq ($(TARGET_BUILD_GOOGLE_ATV), true)
PRODUCT_IS_ATV := true
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/tutorial-library-google.zip:system/media/tutorial-library-google.zip
PRODUCT_PACKAGES += \
    DroidOverlay \
    BlueOverlay
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.disable_triple_buffer=1

# ro.product.first_api_level indicates the first api level the device has commercially launched on.
PRODUCT_PROPERTY_OVERRIDES += \
    ro.product.first_api_level=26

PRODUCT_PACKAGES += \
    vndk-sp

# VNDK version is specified
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.vndk.version=26.1.0

PRODUCT_PROPERTY_OVERRIDES += \
    ro.treble.enabled=true

#for cts test disable quota
PRODUCT_PROPERTY_OVERRIDES += \
    fw.disable_quota=true

# Override heap growth limit due to high display density on device
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapgrowthlimit=256m


PRODUCT_PROPERTY_OVERRIDES += \
    ro.boot.fake_battery=42

#Set PQ enable
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.PQ.enable=true

#fix android.permission2.cts.ProtectedBroadcastsTest
#PRODUCT_PACKAGES += \
#    TeleService
