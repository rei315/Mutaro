#!/bin/sh

#  ci_post_clone.sh
#  Mutaro
#
#  Created by minguk-kim on 2022/09/27.
#  Copyright © 2022 MGHouse, Inc. All rights reserved.

brew install needle
brew install jq
defaults write com.apple.dt.Xcode IDESkipPackagePluginFingerprintValidatation -bool YES
