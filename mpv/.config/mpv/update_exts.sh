#!/usr/bin/env zsh

EXTS=( 3GP ASF AVI FLV M4V MKV MOV MP4 MPEG MPG MPG2 MPG4 RMVB WMV MTS WEBM )

for ext in ${EXTS[@]}
do
    duti -vs io.mpv $ext all
    duti -vs io.mpv $(echo $ext | tr "[:upper:]" "[:lower:]") all
done
