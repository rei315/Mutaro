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
        basePath="${CI_WORKSPACE}/MutaroApp/MutaroApp/Resources/GoogleServicePlists"
        if [[ $CI_XCODE_SCHEME == *"Development"* ]]; then
            googleInfoPlistPath="$basePath/GoogleService-Info-dev.plist"
        else
            googleInfoPlistPath="$basePath/GoogleService-Info-prod.plist"
        fi

        echo "Mutaro: - Check app/google plist file"
        
        ${CI_WORKSPACE}/Scripts/upload-symbols -gsp ${googleInfoPlistPath} -p ios "$CI_ARCHIVE_PATH/dSYMs"
    fi
}

get_pr_number() {
    CI_BRANCH=$1 GITHUB_TOKEN=$2 python3 -c $'
import sys, json, os, requests

def get(url, token):
    headers = {
        "Accept": "application/vnd.github+json",
        "Authorization": "Bearer {}".format(token),
        "X-GitHub-Api-Version": "2022-11-28"
    }
    response = requests.get(url, headers=headers)
    return response

CI_BRANCH=os.environ["CI_BRANCH"]
GITHUB_TOKEN=os.environ["GITHUB_TOKEN"]

prInfoResponse=get("https://api.github.com/repos/rei315/Mutaro/pulls", GITHUB_TOKEN)
if prInfoResponse.status_code != 200:
    print(-2)
    exit()
prInfoResponseJson = prInfoResponse.json()
targetResponse = [x for x in prInfoResponseJson if x["head"]["ref"] == CI_BRANCH]
if (len(targetResponse) != 0):
    print(targetResponse[0]["number"])
else:
   print(-1)
'
}

get_app_version() {
    PATH=/usr/libexec:$PATH
    mainInfoPlist="${CI_WORKSPACE}/MutaroApp/MutaroApp/Resources/Info.plist"
    PlistBuddy -c "print CFBundleShortVersionString" "${mainInfoPlist}"
}

version_pr_comment() {
    PR_NUMBER=$(get_pr_number ${CI_BRANCH} ${GITHUB_TOKEN})
    if [ $PR_NUMBER -eq -1 ]; then
        return 0
    elif [ $PR_NUMBER -eq -2 ]; then
        echo "Github Tokenを更新してください"
        exit 1
    fi
        
    APP_VERSION=$(get_app_version)
    
    curl -X POST \
    -H "Accept: application/vnd.github.v3+json" \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    "https://api.github.com/repos/rei315/Mutaro/issues/$PR_NUMBER/comments" \
    -d '{"body":"ビルドが成功し、下記のバージョンで配信中です。\nApp Version: '${APP_VERSION}'\nBuild Number: '${CI_BUILD_NUMBER}'"}'
}

if [[ $CI_WORKFLOW = "Test-CI" ]]; then
    if [[ $CI_XCODEBUILD_ACTION -eq "build-for-testing" ]]; then
        git diff --exit-code
    fi
elif [[ $CI_WORKFLOW = "Archive-For-Testflight-Develop" ]]; then
    upload_dsym
    version_pr_comment
elif [[ $CI_WORKFLOW = "Archive-For-Release" ]]; then
    upload_dsym
fi
