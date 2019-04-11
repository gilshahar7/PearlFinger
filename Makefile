ARCHS = armv7 arm64
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PearlFinger
PearlFinger_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

BUNDLE_NAME = PearlFingerBundle
PearlFingerBundle_INSTALL_PATH = /Library/Application Support
include $(THEOS)/makefiles/bundle.mk

after-install::
	install.exec "killall -9 SpringBoard"
