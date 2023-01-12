rm -rf env-vars.sh
printf "
export G_DEV_CLIENT_ID='$1'
export G_DEV_API_KEY='$2'
export G_DEV_REVERSED_CLIENT_ID='$3'
export G_DEV_GCM_SENDER_ID='$4'
export G_DEV_GOOGLE_APP_ID='$5'

export LICENSE_PLIST_GITHUB_TOKEN='$6'
" >> env-vars.sh
