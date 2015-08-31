ARCHS = arm64 armv7

include theos/makefiles/common.mk

TWEAK_NAME = CancelPassBlock
CancelPassBlock_FILES = Tweak.xm
CancelPassBlock_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
