#!/bin/sh

#  ci_pre_xcodebuild.sh
#  Mutaro
#
#  Created by minguk-kim on 2022/09/29.
#  Copyright © 2022 MGHouse, Inc. All rights reserved.

if [[ $CI_WORKFLOW = "Archive-For-Testflight-Develop" ]]; then
    PATH=/usr/libexec:$PATH
    mainInfoPlist="${CI_WORKSPACE}/MutaroApp/MutaroApp/Resources/Info.plist"
    
    nextBuildNumber=$CI_BUILD_NUMBER
    originalVersion=$(PlistBuddy -c "print CFBundleShortVersionString" "${mainInfoPlist}")
    nextVersion=$(echo ${originalVersion} | awk -F. -v OFS=. '{$NF += 1 ; print}')
    
    echo "Mutaro: - versionNumber is ${nextBuildNumber}"
    echo "Mutaro: - version is ${nextVersion}"
    
    PlistBuddy -c "Set :CFBundleVersion $nextBuildNumber" "${mainInfoPlist}"
    PlistBuddy -c "Set :CFBundleShortVersionString $nextVersion" "${mainInfoPlist}"
elif [[ $CI_WORKFLOW = "Archive-For-Release" ]]; then
    PATH=/usr/libexec:$PATH
    nextBuildNumber=$CI_BUILD_NUMBER
    mainInfoPlist="${CI_WORKSPACE}/MutaroApp/MutaroApp/Resources/Info.plist"
    
    echo "Mutaro: - versionNumber is ${nextBuildNumber}"
    
    PlistBuddy -c "Set :CFBundleVersion $nextBuildNumber" "${mainInfoPlist}"
fi

sed -i "" "s/gitHubToken: \"\"/gitHubToken: \"$GITHUB_TOKEN\"/" ${CI_WORKSPACE}/MutaroApp/license_plist.yml
