#!/bin/sh

#  ci_post_xcodebuild.sh
#  Mutaro
#
#  Created by minguk-kim on 2022/09/29.
#  Copyright © 2022 MGHouse, Inc. All rights reserved.

upload_dsym() {
    set -e
    if [[ -n $CI_ARCHIVE_PATH ]]; then
        echo "Found valid archive path, trying to upload dSYMs."
        echo "Start uploading dSYMs"
        basePath="${CI_WORKSPACE}/App/${CI_PRODUCT}/${CI_PRODUCT}/Resources"
        googleInfoPlistPath="$basePath/GoogleService-Info.plist"

        echo "Mutaro: - Check app/google plist file"
        
        ${CI_WORKSPACE}/Scripts/upload-symbols -gsp ${googleInfoPlistPath} -p ios "$CI_ARCHIVE_PATH/dSYMs"
    fi
}

get_app_version() {
    PATH=/usr/libexec:$PATH
    mainInfoPlist="${CI_WORKSPACE}/App/${CI_PRODUCT}/${CI_PRODUCT}/Resources/Info.plist"
    PlistBuddy -c "print CFBundleShortVersionString" "${mainInfoPlist}"
}

version_pr_comment() {
    PR_NUMBER=$CI_PULL_REQUEST_NUMBER
    if [ ! -n $PR_NUMBER ]; then
        return 0
    fi
        
    APP_VERSION=$(get_app_version)
    
    curl -X POST \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    "https://api.github.com/repos/rei315/Mutaro/issues/$PR_NUMBER/comments" \
    -d '{"body":"ビルドが成功し、下記のバージョンで配信中です。\nApp Version: '${APP_VERSION}'\nBuild Number: '${CI_BUILD_NUMBER}'"}'
}

if [[ $CI_WORKFLOW = "Archive-For-Testflight-Develop" ]]; then
    version_pr_comment
elif [[ $CI_WORKFLOW = "Archive-For-Release" ]]; then
    upload_dsym
fi
