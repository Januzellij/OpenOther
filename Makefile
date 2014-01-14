TARGET = :clang
ARCHS = armv7 arm64
TWEAK_NAME = OpenOther
OpenOther_FILES = Tweak.xm
OpenOther_CFLAGS = -fobjc-arc

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += openotherprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
