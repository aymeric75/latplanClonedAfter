#!/bin/bash


after_sample="sokoban_sokoban_image-20000-global-global-2-train_20000_CubeSpaceAE_AMA4Conv_kltune2"
domains_dirs_grid1=samples/$after_sample/grid1/logs
domains_dirs_grid2=samples/$after_sample/grid2/logs


for dir in $domains_dirs_grid1/*/
do
    #echo $dir
    output1=$(./display-jsons.py $dir)
    echo "grid1 / $output1"
done



for dir in $domains_dirs_grid2/*/
do
    output=$(./display-jsons.py $dir)
    echo "grid2 / $output"
done