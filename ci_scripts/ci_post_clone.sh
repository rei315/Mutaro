#!/bin/sh

#  ci_post_clone.sh
#  Mutaro
#
#  Created by minguk-kim on 2022/09/27.
#  Copyright © 2022 MGHouse, Inc. All rights reserved.

git branch -r
exit 1

if [[ $CI_WORKFLOW = "Test-CI" || $CI_WORKFLOW = "Archive-For-Testflight-Develop" ]]; then
    SOURCE_BRANCH=$CI_BRANCH
    RELEASE_BRANCH='release/'
    MASTER_BRANCH='main/'
    HOTFIX_BRANCH='hotfix/'

    if [[ $SOURCE_BRANCH != *"$RELEASE_BRANCH"* ]] && [[ $SOURCE_BRANCH != $MASTER_BRANCH ]] && [[ $SOURCE_BRANCH != *"$HOTFIX_BRANCH"* ]]; then
        git fetch origin develop
        echo "--------------"
        git branch -a
        echo "--------------"
        git branch -r
        lines=$(git diff remotes/origin/develop..$CI_BRANCH -G ".*[0-9]+\.[0-9]+[0-9]+.*" ${CI_WORKSPACE}/MutaroApp/MutaroApp/Resources/Info.plist | wc -l)
        if [ $lines -gt 0 ]; then
            echo "Mutaro: Version is not updated"
            exit 1
        fi
    fi
fi

pip3 install requests
brew install licenseplist
defaults write com.apple.dt.Xcode IDESkipPackagePluginFingerprintValidatation -bool YES
