#!/usr/bin/env bash
set -euo pipefail

rm -rf build

patrol build ios --target integration_test/example_test.dart --release

pushd build/ios_integ/Build/Products
zip -r ios_tests.zip Release-iphoneos Runner_iphoneos18.5-arm64.xctestrun
popd

# use `gcloud firebase test ios models list` to see available models & versions
gcloud firebase test ios run \
	--test build/ios_integ/Build/Products/ios_tests.zip \
	--device model=ipad10,version=16.6,locale=en_US,orientation=portrait \
	--results-bucket="patrol-runs"