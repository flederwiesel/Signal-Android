#!/bin/sh

keystore=$(cygpath --windows --folder 40)/apk-keystore.jks
scriptdir=$(dirname "${BASH_SOURCE[0]}")
builddir="$scriptdir/app/build/outputs/apk/websiteProd/release"
builddirWin=$(cygpath --windows "$builddir")

for f in "$builddir"/Signal-Android-website-prod-arm64-v8a-release-unsigned-*.apk
do
(
	d="${f%/*}"
	f="${f##*/}"

	cd "$d" &&
	jarsigner \
		-verbose -keystore "$keystore" "$f" Signal-Android &&
		mv "$f" "${f//unsigned-/}"
)
done
