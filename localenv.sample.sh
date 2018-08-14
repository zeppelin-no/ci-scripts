# make copy as "localenv.sh" to test locally using  `circleci build --job test`
# Once this file is copied to "localenv.sh", replace the values below with correct values.
# The remove all comments in "localenv.sh" but leave the comment below:
# THIS FILE CONTAINS SECRETS: DO NOT ADD THIS FILE TO GIT!
#
echo 'DEBUG: Getting credentials from localenv.sh'
#
K8S_ENDPOINT="https://api.sites.zeppelincloud.com"
K8S_USERNAME="admin"
K8S_PASSWORD="ADMIN PASSWORD HERE"
K8S_DEV_ENDPOINT="DEV ENDPOINT"
K8S_DEV_USERNAME="devadmin"
K8S_DEV_PASSWORD="DEV ADMIN PASSWORD HERE"
