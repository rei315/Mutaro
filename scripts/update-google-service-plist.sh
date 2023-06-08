IS_CI=$1
IS_DEV=$2
CI_WORKSPACE=$3

CLIENT_ID=$4
API_KEY=$5
REVERSED_CLIENT_ID=$6
GCM_SENDER_ID=$7
GOOGLE_APP_ID=$8

PATH=/usr/libexec:$PATH
#${CI_WORKSPACE}/App/${CI_XCODE_PROJECT}/${CI_XCODE_PROJECT}

if "${IS_DEV}"; then
    if "${IS_CI}"; then
        plistPath="${CI_WORKSPACE}/App/MutaroDevApp/MutaroDevApp"
    else
        plistPath="MutaroDevApp"
    fi
	plistFullPath="${plistPath}/Resources/GoogleService-Info.plist"
else
    if "${IS_CI}"; then
        plistPath="${CI_WORKSPACE}/App/Mutaro/Mutaro"
    else
        plistPath="Mutaro"
    fi
	plistFullPath="${plistPath}/Resources/GoogleService-Info.plist"
fi

PlistBuddy -c "Set :CLIENT_ID $CLIENT_ID" "${plistFullPath}"
PlistBuddy -c "Set :API_KEY $API_KEY" "${plistFullPath}"
PlistBuddy -c "Set :REVERSED_CLIENT_ID $REVERSED_CLIENT_ID" "${plistFullPath}"
PlistBuddy -c "Set :GCM_SENDER_ID $GCM_SENDER_ID" "${plistFullPath}"
PlistBuddy -c "Set :GOOGLE_APP_ID $GOOGLE_APP_ID" "${plistFullPath}"
