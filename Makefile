FINALPACKAGE=1
TARGET := iphone:clang:latest
THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

SUBPROJECTS += SAEEnablerSpringBoard
SUBPROJECTS += SAEEnablerPreferences

include $(THEOS_MAKE_PATH)/aggregate.mk