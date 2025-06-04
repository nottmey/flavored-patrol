#!/usr/bin/env bash
set -euo pipefail

rm -rf build

patrol build android --target integration_test/example_test.dart

gcloud firebase test android run \
	--type instrumentation \
	--app build/app/outputs/apk/debug/app-debug.apk \
	--test build/app/outputs/apk/androidTest/debug/app-debug-androidTest.apk \
	--device model=MediumPhone.arm,version=34,locale=en,orientation=portrait \
	--timeout 10m \
	--results-bucket="patrol-runs" \
	--use-orchestrator \
	--environment-variables clearPackageData=true