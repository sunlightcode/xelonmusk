#!/bin/bash
# create multiresolution windows icon
ICON_SRC=../../src/qt/res/icons/xelonmusk.png
ICON_DST=../../src/qt/res/icons/xelonmusk.ico
convert ${ICON_SRC} -resize 16x16 xelonmusk-16.png
convert ${ICON_SRC} -resize 32x32 xelonmusk-32.png
convert ${ICON_SRC} -resize 48x48 xelonmusk-48.png
convert xelonmusk-16.png xelonmusk-32.png xelonmusk-48.png ${ICON_DST}

