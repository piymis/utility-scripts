#!/bin/bash
# youtube-dl-script : A script to make downloading videos wasy using youtube-dl
# ----- Usage -----
# <script> refers to this script's executable name, eg: ./youtube-dl-script.bash
# 
# => Download playlist:
#    <script> --playlist <playlist_key> [<file_dest>]
#       where
#               <playlist_key> : youtube playlist unique identfier, usually present at the end of the playlist url.
#               <file_dest> : destination path where to save the playlist.

shell_command="youtube-dl -o"
if ! [ -x "$(command -v youtube-dl)" ]; then
    echo 'Error! youtube-dl not installed.'
    exit 1
fi

download_playlist()
{
    playlist_key=$1
    if [ "$2" = "" ]; then
        dest="/home/${USER}"
    else
        dest="$2"
    fi

    playlist_options="'${dest}/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s'"
    playlist_url_prefix="https://www.youtube.com/playlist?list="
    cmd="${shell_command} ${playlist_options} ${playlist_url_prefix}${playlist_key} ${dest}"
    #echo $cmd
    eval $cmd
}

while [ "$1" != "" ]; do
    case $1 in
        --playlist ) 
            shift;
            key=$1;
            shift;
            dest=$1;
        download_playlist $key $dest;;
        * )
            exit 1
    esac
done


