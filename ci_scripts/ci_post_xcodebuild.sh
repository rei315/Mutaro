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
        basePath="${CI_PRIMARY_REPOSITORY_PATH}/App/${CI_PRODUCT}/${CI_PRODUCT}/Resources"
        googleInfoPlistPath="$basePath/GoogleService-Info.plist"

        echo "Mutaro: - Check app/google plist file"
        
        ${CI_PRIMARY_REPOSITORY_PATH}/Scripts/upload-symbols -gsp ${googleInfoPlistPath} -p ios "$CI_ARCHIVE_PATH/dSYMs"
    fi
}

get_app_version() {
    PATH=/usr/libexec:$PATH
    mainInfoPlist="${CI_PRIMARY_REPOSITORY_PATH}/App/${CI_PRODUCT}/${CI_PRODUCT}/Resources/Info.plist"
    PlistBuddy -c "print CFBundleShortVersionString" "${mainInfoPlist}"
}

get_pull_request_id() {
    url="https://api.github.com/repos/rei315/Mutaro/pulls?state=open&sort=created&direction=asc&per_page=100"

    response=$(curl -s -L \
        -H "Accept: application/vnd.github+json" \
        -H "Authorization: Bearer ${GITHUB_TOKEN}" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        "$url")

    if [ $? -eq 0 ]; then
        echo "$response" | tr -d '[:cntrl:]' | sed -E 's/\\([][])/\\\\\1/g' | jq -r ".[] | select(.head.ref == \"$CI_BRANCH\") | .number"
    else
        echo ""
    fi
}

version_pr_comment() {
    PR_NUMBER=$1
    if [ ! -n $PR_NUMBER ]; then
        return 0
    fi
        
    APP_VERSION=$(get_app_version)
    
    response=$(curl -X POST \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    "https://api.github.com/repos/rei315/Mutaro/issues/$PR_NUMBER/comments" \
    -d '{"body":"ビルドが成功し、下記のバージョンで配信中です。\nApp Version: '${APP_VERSION}'\nBuild Number: '${CI_BUILD_NUMBER}'"}')
    
    if [ $? -ne 0 ]; then
        return 0
    fi
}

if [[ $CI_WORKFLOW = "Archive-For-Testflight-Develop" ]]; then
    if [ -n "$CI_PULL_REQUEST_NUMBER" ]; then
        PR_NUMBER="$CI_PULL_REQUEST_NUMBER"
    else
        PR_NUMBER=$(get_pull_request_id)
    fi
    if [ -n "$PR_NUMBER" ]; then
        version_pr_comment $PR_NUMBER
    else
        echo "Mutaro: failed to comment build info"
    fi
elif [[ $CI_WORKFLOW = "Archive-For-Release" ]]; then
    upload_dsym
fi
