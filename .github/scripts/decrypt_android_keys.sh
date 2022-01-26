#!/bin/sh

gpg --quiet --batch --yes --decrypt --passphrase="$ANDROID_KEYS_SECRET_PASSPHRASE" \
--output acta/android/android_keys.zip acta/android/android_keys.zip.gpg && cd acta/android && jar xvf android_keys.zip && cd -