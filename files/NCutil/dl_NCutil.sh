#!/bin/bash
# Download and extract most recent version of jacobsalmela/NCutil for install via puppet
version=$(curl -s https://api.github.com/repos/jacobsalmela/NCutil/releases | python -c 'import json,sys;obj=json.load(sys.stdin); print obj[0]["tag_name"]')
mkdir $version
cd $version
curl -sL -o ./NCutil.py --connect-timeout 30 $(curl -s https://api.github.com/repos/jacobsalmela/NCutil/releases | python -c 'import json,sys;obj=json.load(sys.stdin); print obj[0]["assets"][0]["browser_download_url"]')
chmod 755 ./NCutil.py