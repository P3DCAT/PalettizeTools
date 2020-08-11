@echo off

cd input/

egg-texture-cards -f rgba -o ../output/example_texcard.egg *.png
echo egg-texture-cards complete

egg-palettize -egg -noabs -redo -g example -nodb -opt -af ../textures.txa -dm ../output/ -o ../output/example_pal.egg ../output/example_texcard.egg
echo egg-palettize complete

pause