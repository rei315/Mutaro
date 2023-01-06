IS_CI=$1
IS_DEV=$2
CI_WORKSPACE=$3

CLIENT_ID=$4
API_KEY=$5
REVERSED_CLIENT_ID=$6
GCM_SENDER_ID=$7
GOOGLE_APP_ID=$8

PATH=/usr/libexec:$PATH

if "${IS_CI}"; then
	plistPath="${CI_WORKSPACE}/MutaroApp/Resources/GoogleServicePlists"
else
	plistPath="MutaroApp/Resources/GoogleServicePlists"
fi

if "${IS_DEV}"; then
	plistFullPath="${plistPath}/GoogleService-Info-dev.plist"
else
	plistFullPath="${plistPath}/GoogleService-Info-prod.plist"
fi

PlistBuddy -c "Set :CLIENT_ID $CLIENT_ID" "${plistFullPath}"
PlistBuddy -c "Set :API_KEY $API_KEY" "${plistFullPath}"
PlistBuddy -c "Set :REVERSED_CLIENT_ID $REVERSED_CLIENT_ID" "${plistFullPath}"
PlistBuddy -c "Set :GCM_SENDER_ID $GCM_SENDER_ID" "${plistFullPath}"
PlistBuddy -c "Set :GOOGLE_APP_ID $GOOGLE_APP_ID" "${plistFullPath}"