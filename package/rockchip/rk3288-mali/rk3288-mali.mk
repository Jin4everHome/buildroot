################################################################################
#
# rk3288-mali
#
################################################################################

RK3288_MALI_VERSION = master
RK3288_MALI_SITE = $(TOPDIR)/package/rockchip/rk3288-mali/prebuilt
RK3288_MALI_SITE_METHOD = local
RK3288_MALI_LICENSE = ARM
RK3288_MALI_LICENSE_FILES = END_USER_LICENCE_AGREEMENT.txt
RK3288_MALI_DEPENDENCIES = libffi libdrm wayland wayland-protocols
RK3288_MALI_INSTALL_STAGING = YES


#
#	Wayland DRM
#
ifeq ($(BR2_ARM_EABIHF),y)
ifeq ($(BR2_PACKAGE_RK3288_MALI_DRM),y)
LIBMALI = $(@D)/lib/arm-linux-gnueabihf/libmali-midgard-t76x-r18p0-r1p0-wayland.so
LIBGBM = $(@D)/lib/arm-linux-gnueabihf/libgbm.so
endif

ifeq ($(BR2_PACKAGE_RK3288_MALI_FBDEV),y)
LIBMALI = $(@D)/lib/arm-linux-gnueabihf/libmali-midgard-t76x-r18p0-r1p0-gbm.so
LIBGBM = $(@D)/lib/arm-linux-gnueabihf/libgbm.so
endif
endif

ifeq ($(BR2_PACKAGE_XORG7),y)
PLATFORM_EGL_HEADER = eglplatform.h
else
PLATFORM_EGL_HEADER = eglplatform_noX11.h
endif

define RK3288_MALI_INSTALL_STAGING_CMDS
	@cp -f $(LIBMALI) $(STAGING_DIR)/usr/lib/libmali.so.1
	@cp -f $(LIBGBM) $(STAGING_DIR)/usr/lib/libgbm.so
	@cd $(STAGING_DIR)/usr/lib && ln -s -f libgbm.so libgbm.so.1
	@cd $(STAGING_DIR)/usr/lib && ln -s -f libmali.so.1 libmali.so
	@cd $(STAGING_DIR)/usr/lib && ln -s -f libmali.so.1 libGLESv2.so.2.0
	@cd $(STAGING_DIR)/usr/lib && ln -s -f libGLESv2.so.2.0 libGLESv2.so.2
	@cd $(STAGING_DIR)/usr/lib && ln -s -f libGLESv2.so.2 libGLESv2.so
	@cd $(STAGING_DIR)/usr/lib && ln -s -f libmali.so.1 libGLESv1_CM.so.1.1
	@cd $(STAGING_DIR)/usr/lib && ln -s -f libGLESv1_CM.so.1.1 libGLESv1_CM.so.1
	@cd $(STAGING_DIR)/usr/lib && ln -s -f libGLESv1_CM.so.1 libGLESv1_CM.so
	@cd $(STAGING_DIR)/usr/lib && ln -s -f libmali.so.1 libEGL.so.1.4
	@cd $(STAGING_DIR)/usr/lib && ln -s -f libEGL.so.1.4 libEGL.so.1
	@cd $(STAGING_DIR)/usr/lib && ln -s -f libEGL.so.1 libEGL.so
	@cd $(STAGING_DIR)/usr/lib && ln -s -f libmali.so.1 libwayland-egl.so
	@cd $(STAGING_DIR)/usr/lib && ln -s -f libmali.so.1 libwayland-egl.so.1
	@cd $(STAGING_DIR)/usr/lib && ln -s -f libmali.so.1 libwayland-egl.so.1.0.0

	@mkdir -p $(STAGING_DIR)/usr/include
	@cp -rf $(@D)/include/gbm.h $(STAGING_DIR)/usr/include/gbm.h

	@mkdir -p $(STAGING_DIR)/usr/include/EGL
	@cp -rf $(@D)/include/EGL/eglext.h $(STAGING_DIR)/usr/include/EGL/eglext.h
	@cp -rf $(@D)/include/EGL/egl.h $(STAGING_DIR)/usr/include/EGL/egl.h
	cp -rf $(@D)/include/EGL/$(PLATFORM_EGL_HEADER) $(STAGING_DIR)/usr/include/EGL/eglplatform.h

	@mkdir -p $(STAGING_DIR)/usr/include/GLES
	@cp -rf $(@D)/include/GLES/* $(STAGING_DIR)/usr/include/GLES

	@mkdir -p $(STAGING_DIR)/usr/include/GLES2
	@cp -rf $(@D)/include/GLES2/* $(STAGING_DIR)/usr/include/GLES2

	@mkdir -p $(STAGING_DIR)/usr/include/GLES3
	@cp -rf $(@D)/include/GLES3/* $(STAGING_DIR)/usr/include/GLES3

	@mkdir -p $(STAGING_DIR)/usr/include/KHR
	@cp -rf $(@D)/include/KHR/* $(STAGING_DIR)/usr/include/KHR

	$(INSTALL) -D -m 0644 package/rockchip/rk3288-mali/prebuilt/egl.pc \
		$(STAGING_DIR)/usr/lib/pkgconfig/egl.pc

	$(INSTALL) -D -m 0644 package/rockchip/rk3288-mali/prebuilt/glesv2.pc \
		$(STAGING_DIR)/usr/lib/pkgconfig/glesv2.pc

	$(INSTALL) -D -m 0644 package/rockchip/rk3288-mali/prebuilt/gbm.pc \
		$(STAGING_DIR)/usr/lib/pkgconfig/gbm.pc

	$(INSTALL) -D -m 0644 package/rockchip/rk3288-mali/prebuilt/wayland-egl.pc \
		$(STAGING_DIR)/usr/lib/pkgconfig/wayland-egl.pc
endef

define RK3288_MALI_INSTALL_TARGET_CMDS
	@cp -f $(LIBMALI) $(TARGET_DIR)/usr/lib/libmali.so.1
	@cp -f $(LIBGBM) $(TARGET_DIR)/usr/lib/libgbm.so
	@cd $(TARGET_DIR)/usr/lib && ln -s -f libgbm.so libgbm.so.1
	@cd $(TARGET_DIR)/usr/lib && ln -s -f libmali.so.1 libmali.so
	@cd $(TARGET_DIR)/usr/lib && ln -s -f libmali.so.1 libGLESv2.so.2.0
	@cd $(TARGET_DIR)/usr/lib && ln -s -f libGLESv2.so.2.0 libGLESv2.so.2
	@cd $(TARGET_DIR)/usr/lib && ln -s -f libGLESv2.so.2 libGLESv2.so
	@cd $(TARGET_DIR)/usr/lib && ln -s -f libmali.so.1 libGLESv1_CM.so.1.1
	@cd $(TARGET_DIR)/usr/lib && ln -s -f libGLESv1_CM.so.1.1 libGLESv1_CM.so.1
	@cd $(TARGET_DIR)/usr/lib && ln -s -f libGLESv1_CM.so.1 libGLESv1_CM.so
	@cd $(TARGET_DIR)/usr/lib && ln -s -f libmali.so.1 libEGL.so.1.4
	@cd $(TARGET_DIR)/usr/lib && ln -s -f libEGL.so.1.4 libEGL.so.1
	@cd $(TARGET_DIR)/usr/lib && ln -s -f libEGL.so.1 libEGL.so
	@cd $(TARGET_DIR)/usr/lib && ln -s -f libmali.so.1 libwayland-egl.so
	@cd $(TARGET_DIR)/usr/lib && ln -s -f libmali.so.1 libwayland-egl.so.1
	@cd $(TARGET_DIR)/usr/lib && ln -s -f libmali.so.1 libwayland-egl.so.1.0.0
endef

$(eval $(generic-package))
