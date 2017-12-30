#! /bin/sh -x

# rmコマンドの代わりにゴミ箱へmvするようにする。
# rm -fみたいな感じでいちいち警告を出さない。
# 使えるオプションは-frvのみ。
# rmコマンド使うときfオプション使う事が多いからエラーでないよう入れておく。
# fオプションをつけると、本来の/bin/rmで実行する。

# ここにはゴミ箱とするディレクトリのフルパスを入れといてね。
trash="$HOME/.Trash"
info="${trash}""/.info"
rFlag=0
fFlag=0
vOption=

if [ "$#" -eq 0 ];
then
    echo "Usage: "`basename $0`" [-frv] file ..."
    exit 2
fi

while getopts 'frv' OPTION
do
    case $OPTION in
        f) fFlag=1
           ;;
        r) rFlag=1
           ;;
        v) vOption="-v"
           ;;
        ?) echo "Usage: "`basename $0`" [-frv] file ..."
        exit 2
        ;;
    esac
done

if [ "${fFlag}" -eq 0 ];
then
    # オプション部分を切り捨てる。
    shift `expr $OPTIND - 1`

    for i in "$@"
    do
        # ファイルかシンボリックリンクが存在しなかったらスルー
        if ! ([ -e "${i}" ] || [ -L "${i}" ]);
        then
            echo `basename "$0"`": ""${i}"": No such file or directory"
            continue 1
        fi

        # オプションrを付けていないのにディレクトリだったらスルー
        if [ "${rFlag}" -eq 0 ] && [ -d "${i}" ];
        then
            echo `basename "$0"`": ""${i}"": is a directory"
            continue 1
        fi

        # ゴミ箱へmvする
        if [ -e "${trash}""/""$(basename "${i}")" ];
        then
            /bin/rm -r "${trash}""/""$(basename "${i}")"
        fi
        echo "{"$(basename "${i}")"} <- "[$(cd "$(dirname "${i}")" && pwd)"/"$(basename "${i}")"]" >> ${info}
        mv ${vOption} "${i}" "${trash}""/"
    done
else
    /bin/rm "$@"
fi
