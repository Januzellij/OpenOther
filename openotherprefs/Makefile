TARGET = :clang
ARCHS = armv7 arm64
BUNDLE_NAME = OpenOtherPrefs
OpenOtherPrefs_FILES = OpenOtherPrefs.mm
OpenOtherPrefs_LIBRARIES = applist
OpenOtherPrefs_INSTALL_PATH = /Library/PreferenceBundles
OpenOtherPrefs_FRAMEWORKS = UIKit
OpenOtherPrefs_PRIVATE_FRAMEWORKS = Preferences


include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/OpenOtherPrefs.plist$(ECHO_END)
