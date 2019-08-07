#! /bin/bash
echo '开始验证'
pod spec lint MDAspects.podspec --use-libraries --allow-warnings --verbose
echo '开始推送'
pod trunk push MDAspects.podspec --allow-warnings --use-libraries --verbose
