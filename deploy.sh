#!/bin/bash

# find public -type f -exec curl -u $FTP_USER:$FTP_PASSWORD --ftp-create-dirs -T {} ftp://ftp.webprofessor.it/web/{} ";"
#find public -type f -exec curl -v -u $FTP_USER:$FTP_PASSWORD --use-ascii --ftp-create-dirs -T {} ftp://ftp.webprofessor.it/web/{} \;

set -e

#sudo apt-get install -y lftp

#sudo apt-get install zip


NOW=`date -u +"%Y-%m-%dT%H:%M:%SZ"`

LOCALPATH='./public/'
#REMOTEPATH='site/wwwroot'

ZIP_FILE="wp-with-hugo_$NOW.zip"
zip -r $ZIP_FILE $LOCALPATH

echo "zip file to upload:$ZIP_FILE"

echo "FTP_USER:$FTP_USER"

# not working - returning curl: (25) Failed FTP upload: 553
# curl -u $FTP_USER:$FTP_PASSWORD --ftp-create-dirs -T $ZIP_FILE ftp://ftp.webprofessor.it/tmp
#find $ZIP_FILE -exec curl -u $FTP_USER:$FTP_PASSWORD --ftp-pasv --ftp-create-dirs -T {} ftp://ftp.webprofessor.it/tmp/{} ";"

upload_response=$(curl -H "X-API-KEY: $API_KEY" -F "FILE=@$ZIP_FILE" http://www.webprofessor.it/receive.php)
echo "upload response:$upload_response"

deploy_response=$(curl -X GET "http://www.webprofessor.it/unzip.php?zip_file_name=$ZIP_FILE")
echo "deploy result:$deploy_response"

# set ssl:verify-certificate no
# set ftp:ssl-allow no
# set ftp:ssl-allow no
# set net:max-retries 3
# set ftp:ssl-allow no

# lftp -f "
# open ftp://$FTP_HOST_2
# user $FTP_USER_2 $FTP_PASSWORD_2
# mirror --continue --reverse --delete --verbose $LOCALPATH $REMOTEPATH
# bye
# "
#lftp -e "set ftp:ssl-allow no; set net:max-retries 3; set net:persist-retries 3; mirror -v -R ./public/ web/" -u $FTP_USER,$FTP_PASSWORD ftp://ftp.webprofessor.it

