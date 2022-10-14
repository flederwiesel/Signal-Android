#!/bin/bash

[[ $1 == --help ]] &&
{
	sed -r $'s/\\\\(033|e)/\033/g' <<-EOF
		\033[1;37m$(basename "${BASH_SOURCE[0]}")\033[m

		Make backup of apk file locally and deploy it to a nextcloud shared dir.

		No command line parameters.
		Set the folowing variables to define destinations:

		    SIGNAL_APK_LOCAL_STORE  - path where apk file is to be backed up locally
		    SIGNAL_APK_STORE        - url to the deploy destination
		    SIGNAL_APK_STORE_PASSWD - password to be used for the former

EOF
	exit
}

if [[ $SIGNAL_APK_LOCAL_STORE ]]; then
	cp app/build/outputs/apk/websiteProd/release/*-arm64-v8a-*.apk "$SIGNAL_APK_LOCAL_STORE"
else
	echo -e "\033[1;33mWARNING: No SIGNAL_APK_STORE defined.\033[m" >&2
	echo -e "\033[33mIf you want to keep this build, remember to backup manually...\033[m" >&2
fi

[[ $SIGNAL_APK_STORE ]] ||
{
	echo "SIGNAL_APK_STORE must be defined." >&2
	exit 1
}

scriptdir=$(dirname "${BASH_SOURCE[0]}")

bindir="$scriptdir/app/build/outputs/apk/websiteProd/release"
apkglob="Signal-Android-website-prod-arm64-v8a-release-*.apk"

apk=$(find "$bindir/" -name "$apkglob" -printf '%P\n' | sort -Vr | head -n 1)

curl -# \
	--http1.1 \
	--header 'X-Requested-With: XMLHttpRequest' \
	--user "${SIGNAL_APK_STORE##*/}:$SIGNAL_APK_STORE_PASSWD" \
	--upload-file "$bindir/$apk" \
	"${SIGNAL_APK_STORE%/index.php*}/public.php/webdav/${apk// /%20}"
