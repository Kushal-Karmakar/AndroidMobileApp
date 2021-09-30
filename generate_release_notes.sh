#!/bin/sh
echo "============================================================================================"
echo "|                              Release Note is being Generated                             |"
echo "============================================================================================"
CURRENT_BUILD_DATE=$(date '+%Y-%d-%m')
# LAST_SUCCESSFULL_BUILD_NUMBER = "wget -qO- http://134.209.155.34:8080/job/AndroidMobileAppCI/job/DEV%20and%20SIT/lastSuccessfulBuild/buildNumber"
LAST_SUCCESSFULL_BUILD_DATE=$1
LAST_SUCCESSFULL_BUILD_NUMBER=$2
SCM_BRANCH_NAME=$4
CURRENT_BUILD_NUMBER=$3
LAST_SUCCESSFUL_BUILD_PREVIOUS_DATE=$( date -d "${LAST_SUCCESSFULL_BUILD_DATE} -1 days" +'%Y-%d-%m' )
GIT_LOG_COMMAND=$(git log --since=${LAST_SUCCESSFUL_BUILD_PREVIOUS_DATE} --pretty=format:" * Message: %C(bold green)%s, %CresetCommiter Name: %C(yellow)%cn, %CresetCommiter Email: %C(blue)%ce, %CresetCommiter Date: %C(yellow)%cd\n" --date=relative)
COMMIT_COUNT=$(git rev-list --count "${SCM_BRANCH_NAME}")
echo "# RELEASE NOTE (Build No: ${CURRENT_BUILD_NUMBER}) #" >> RELEASE_NOTE.md
echo "## Summary of Current Release ##" >> RELEASE_NOTE.md
echo "* Current Release Number: ${CURRENT_BUILD_NUMBER}" >> RELEASE_NOTE.md
echo "* Current Release Date: ${CURRENT_BUILD_DATE}" >> RELEASE_NOTE.md
echo "* Development Start Date: ${LAST_SUCCESSFULL_BUILD_DATE}" >> RELEASE_NOTE.md
echo "* No. of Commit: ${COMMIT_COUNT}" >> RELEASE_NOTE.md
echo "## Below are the new features and bug fixed which take place:  ##" >> RELEASE_NOTE.md
echo $GIT_LOG_COMMAND >> RELEASE_NOTE.md