#!/bin/bash


#Image sizes are FHD: 540x405px | HD: 290x218px | SD: 214x144px
convert image.png -resize 540x540 channel-poster_fhd.png
convert image.png -resize 290x218 channel-poster_hd.png
convert image.png -resize 214x144 channel-poster_sd.png

# Image sizes are FHD: 1920x1080px | HD: 1280x720px | SD: 720x480px
convert image.png -resize 1920x1080 splash-screen_fhd.jpg
convert image.png -resize 1280x720 splash-screen_hd.jpg
convert image.png -resize 720x480 splash-screen_sd.jpg



