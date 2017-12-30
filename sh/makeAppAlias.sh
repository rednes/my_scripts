#! /bin/sh -x

echo alias $(basename "$1" .app | tr '[ A-Z]' '[_a-z]' | sed -e "s/[()]//g")=\"open -a $(echo "$1"|sed -e "s/[ ]/\\\\ /g"|sed -e "s/[']/\\\\'/g")\"
