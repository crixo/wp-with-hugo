#!/bin/bash

# find public -type f -exec curl -u $FTP_USER:$FTP_PASSWORD --ftp-create-dirs -T {} ftp://ftp.webprofessor.it/web/{} ";"
#find public -type f -exec curl -v -u $FTP_USER:$FTP_PASSWORD --use-ascii --ftp-create-dirs -T {} ftp://ftp.webprofessor.it/web/{} \;

set -e

sudo apt-get install -y lftp

LOCALPATH='./public/'
REMOTEPATH='site/wwwroot/'

# set ssl:verify-certificate no
# set ftp:ssl-allow no

lftp -f "
set ftp:ssl-allow no
set net:max-retries 3
set ftp:ssl-allow no
open ftp://$FTP_HOST_2
user $FTP_USER_2 $FTP_PASSWORD_2
mirror --continue --reverse --delete --verbose $LOCALPATH $REMOTEPATH
bye
"
#lftp -e "set ftp:ssl-allow no; set net:max-retries 3; set net:persist-retries 3; mirror -v -R ./public/ web/" -u $FTP_USER,$FTP_PASSWORD ftp://ftp.webprofessor.it

