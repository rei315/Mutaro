RUBY_VERSION = 2.7.2

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

.PHONY: setup-system
setup-system: # Install system tools for setup dependencies	
	$(MAKE) install-rbenv
	$(MAKE) install-ruby

.PHONY: install-rbenv
install-rbenv: # Install rbenv
	brew install rbenv ruby-build
	rbenv inits

.PHONY: install-ruby
install-ruby: # Install Ruby and set version
	RUBY_CFLAGS="-w" rbenv install $(RUBY_VERSION) --skip-existing	
	rbenv local $(RUBY_VERSION)

.PHONY: setup-dependencies
setup-dependencies: # Install dependencies or tools for iOS Build
	$(MAKE) install-bundler-dependencies

.PHONY: install-bundler-dependencies
install-bundler-dependencies: # Install Bundler dependencies
	bundle config path vendor/bundle
	bundle install --without=documentation


.PHONY: clean
clean: # Clear Cache
	rm -rf ./vendor/bundle
	rm -rf ~/Library/Developer/Xcode/DerivedData/*;
	xcodebuild clean --alltargets


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
clean build

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":[^#]*? #| #"}; {printf "%-42s%s\n", $$1 $$3, $$2}'
