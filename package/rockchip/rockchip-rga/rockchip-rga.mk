################################################################################
#
# rockchip-rga
#
################################################################################

ROCKCHIP_RGA_SITE = $(TOPDIR)/package/rockchip/rockchip-rga/src
ROCKCHIP_RGA_VERSION = master
ROCKCHIP_RGA_SITE_METHOD = local

ROCKCHIP_RGA_LICENSE = Apache-2.0
ROCKCHIP_RGA_LICENSE_FILES = COPYING

ROCKCHIP_RGA_INSTALL_STAGING = YES
ROCKCHIP_RGA_INSTALL_TARGET = YES


ifeq ($(BR2_PACKAGE_LIBDRM),y)
ROCKCHIP_RGA_DEPENDENCIES += libdrm
ROCKCHIP_RGA_CONF_OPTS += -Dlibdrm=true
endif

$(eval $(meson-package))

