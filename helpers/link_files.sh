## clear folder content
#
#for f in ./*; do
## if is a directory
#   if [  -f $f ]
#       then
#         rm $f
#       fi
#done


## generate list of ids in /videos or /videofiles
ls . >> folders.txt

#foreach id (folder) from folders.txt
# make link of what you need:q:
while read -r video_id; do
    echo "$video_id"
    ln -s /var/cloud/videos/encoded_video/video.mpd /var/cloud/videofiles/"$video_id"
    #ln -s /videofiles/thevideo.tar.gz /videofiles/"$video_id.tar"
done < /var/cloud/videos/folders.txt


##encode in 2 repr
ffmpeg -i video.mp4 -map 0:v:0 -map 0:a\?:0 -map 0:v:0 -map 0:a\?:0 \
-b:v:0 4300k -maxrate:v:0 4300k -bufsize:v:0 8600k -c:v:0 libx264 -filter:v:0 "scale=-2:1080" -movflags faststart -profile:v:0 main -preset fast -an video1_4300k.mp4 \
-b:v:1 1050k -maxrate:v:1 1050k -bufsize:v:1 8600k -c:v:1 libx264 -filter:v:1 "scale=-2:480" -movflags faststart -profile:v:1 main -preset fast -an video1_1050k.mp4


## dash files
MP4Box -dash 4000 -frag 4000 -profile full -rap -segment-name %s_segment -fps 24 \
        video_1050k.mp4#video:id=480p \
        video_4300k.mp4#video:id=1080p \
        -url-template \
        -out video.mpd
