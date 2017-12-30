#! /bin/sh

BINPATH=$HOME/bin
SCRIPTPATH=$(pwd)/my_scripts

echo "\$SCRIPTPATH : $SCRIPTPATH"
cd $SCRIPTPATH
echo "Created symbolic links for shell-scripts."

for d in sh
do
    cd $d
    for f in *
    do
        ln -sf "$SCRIPTPATH/$d/$f" "$BINPATH/$(echo $f|rev|cut -c 4-|rev)"
        if [ $? -eq 0 ]; then
            printf "   %-25s -> %s\n" "\$SCRIPTPATH/$d/$f" "$BINPATH/$(echo $f|rev|cut -c 4-|rev)"
        fi
    done
    cd ..
done
cd ..
