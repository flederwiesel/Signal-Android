#!/bin/bash

if [[ -z "$SIGNAL_APK_LOCAL_STORE" ]]; then
	echo -e "\033[1;33mWARNING: No SIGNAL_APK_STORE defined.\033[m" >&2
	echo -e "\033[33mIf you want to keep this build, rembember to backup manually...\033[m" >&2
else
	cp app/build/outputs/apk/websiteProd/release/*-arm64-v8a-*.apk "$SIGNAL_APK_LOCAL_STORE"
fi

filename=app/build/outputs/apk/websiteProd/release/Signal-Android-website-prod-arm64-v8a-release-*.apk
#url="$SIGNAL_APK_STORE"
#passwd="$SIGNAL_APK_STORE_PASSWD"

urlencode()
{
	echo ${1// /%20}
}

scriptdir=$(dirname "$0")

dirname=$(dirname "$filename")
basename=$(basename "$filename")
filename=$(find "$dirname/" -name "$basename" -printf '%P\n' | sort -Vr | head -n 1)
remotename=$(urlencode "$filename")
filename="$dirname/$filename"

name="${SIGNAL_APK_STORE##*/}"

curl -sS -# \
	--header 'X-Requested-With: XMLHttpRequest' \
	--user "$name:$SIGNAL_APK_STORE_PASSWD" \
	--upload-file "$scriptdir/$filename" \
	"${SIGNAL_APK_STORE%/index.php*}/public.php/webdav/$remotename"
