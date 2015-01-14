TARGET = :clang
ARCHS = armv7 arm64
PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)
TWEAK_NAME = OpenOther
OpenOther_FILES = Tweak.xm
OpenOther_LIBRARIES = applist
OpenOther_FRAMEWORKS = UIKit
OpenOther_CFLAGS = -fobjc-arc

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += openotherprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
