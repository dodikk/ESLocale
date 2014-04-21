#!/bin/bash

LAUNCH_DIR=$PWD

APPLEDOC_EXE=$(which appledoc)
if [ -z "$APPLEDOC_EXE" ]; then
	APPLEDOC_EXE=/usr/local/bin/appledoc
fi



PROJECT_ROOT=$PWD

DEPLOYMENT_DIR=${PROJECT_ROOT}/deployment
SDK_LIBRARIES_ROOT=${PROJECT_ROOT}/ESLocale


if [ -d "$DEPLOYMENT_DIR" ]; then
	rm -rf "$DEPLOYMENT_DIR" 
fi
mkdir -p "$DEPLOYMENT_DIR" 


cd "$DEPLOYMENT_DIR"
	which appledoc

	${APPLEDOC_EXE}                                     \
	 	--project-name "ESLocale"                       \
		--project-company "dodikk"                      \
		--company-id org.dodikk                         \
        --no-repeat-first-par                           \
        --exclude $SDK_LIBRARIES_ROOT/Calendar/Details  \
 		--output .                                      \
		"$SDK_LIBRARIES_ROOT"                           \
        | tee appledoc-log.txt


	DOCUMENTATION_PATH=$( cat docset-installed.txt | grep Path: | awk 'BEGIN { FS = " " } ; { print $2 }' )
	echo DOCUMENTATION_PATH - $DOCUMENTATION_PATH
	
	cp -R "${DOCUMENTATION_PATH}" .
	find . -name "*.docset" -exec zip -r ESLocale-doc.zip {} \;  -print 
cd "$LAUNCH_DIR"
