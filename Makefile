FIREBASE_VERSION := 10.22.0

.DEFAULT_GOAL := help

DEVELOP_NAME := MutaroDev
PRODUCTION_NAME := Mutaro
WORKSPACE_NAME := Mutaro.xcworkspace

TEST_SCHEME := MutaroDev
TEST_SDK := iphonesimulator
TEST_CONFIGURATION := Debug(Development)
TEST_PLATFORM := iOS Simulator
TEST_DEVICE ?= iPhone 14 Pro
TEST_OS ?= 16.1
TEST_DESTINATION := 'platform=${TEST_PLATFORM},name=${TEST_DEVICE},OS=${TEST_OS}'

.PHONY: download-firebase-sdk
download-firebase-sdk:
	./scripts/download-firebase-sdk.sh $(FIREBASE_VERSION)

.PHONY: clean
clean: # Clear Cache
	rm -rf ~/Library/Developer/Xcode/DerivedData/*;
	xcodebuild clean --alltargets

.PHONY: build-debug-development-without-build
build-debug-development-without-build:
	$(MAKE) build-debug-without-test PROJECT_NAME=${DEVELOP_NAME}

.PHONY: build-debug-production-without-build
build-debug-production-without-build:
	$(MAKE) build-debug-without-test PROJECT_NAME=${PRODUCTION_NAME}

.PHONY: build-debug-development
build-debug-development:
	$(MAKE) build-debug PROJECT_NAME=${DEVELOP_NAME}

.PHONY: build-debug-production
build-debug-production:
	$(MAKE) build-debug PROJECT_NAME=${PRODUCTION_NAME}

.PHONY: build-debug
build-debug:
	set -o pipefail \
&& xcodebuild \
-sdk '${TEST_SDK}' \
-configuration '${TEST_CONFIGURATION}' \
-workspace '${WORKSPACE_NAME}' \
-scheme '${TEST_SCHEME}' \
-destination ${TEST_DESTINATION} \
-clonedSourcePackagesDirPath './SourcePackages' \
-skipPackagePluginValidation \
clean build

.PHONY: build-debug-without-test
build-debug-without-test:
	set -o pipefail \
&& xcodebuild test-without-building \
-sdk '${TEST_SDK}' \
-configuration '${TEST_CONFIGURATION}' \
-workspace '${WORKSPACE_NAME}' \
-scheme '${TEST_SCHEME}' \
-destination ${TEST_DESTINATION} \
-clonedSourcePackagesDirPath './SourcePackages' \
-skipPackagePluginValidation \
clean build

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":[^#]*? #| #"}; {printf "%-42s%s\n", $$1 $$3, $$2}'
