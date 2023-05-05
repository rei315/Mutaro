FIREBASE_VERSION := 10.3.0
AWS_VERSION := 2.28.5

.DEFAULT_GOAL := help

# Install Environment for build

.PHONY: setup-system
setup-system: # Install system tools for setup dependencies
	$(MAKE) install-homebrew

.PHONY: install-homebrew
install-homebrew: # Install Homebrew
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

.PHONY: download-firebase-sdk
download-firebase-sdk:
	./scripts/download-firebase-sdk.sh $(FIREBASE_VERSION)

.PHONY: download-aws-sdk
download-aws-sdk:
	./scripts/download-aws-sdk.sh $(AWS_VERSION)

# Setup Xcode Custom Template

.PHONY: setup-xcode-template
setup-xcode-template:
	./scripts/copy-xcode-template.sh

.PHONY: clean
clean: # Clear Cache
	rm -rf ~/Library/Developer/Xcode/DerivedData/
	xcodebuild clean -alltargets

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":[^#]*? #| #"}; {printf "%-42s%s\n", $$1 $$3, $$2}'
