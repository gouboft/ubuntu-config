# covert the $1 video file to h.265 format
# $2 is mkv or mp4 package
# audio track is vordis(ogg) by default
ffmpeg -i $1 -c:v libx265 $2
# aac audio format
#ffmpeg -i $1 -c:v libx265 -c:a libfdk_aac $2
