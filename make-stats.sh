#!/bin/bash

pwdd=$(pwd)




##################
#  BLOCKSWORLD   #
##################

exec 1>myblocks_MAKESTATS.out 2>myblocks_MAKESTATS.err

task="blocks"
type="cylinders-4-flat"
width_height=""
nb_examples="20000"
suffix="without" # = without author's weight, no noisy test init/goal
baselabel="blocks_"$suffix
after_sample="blocks_cylinders-4-flat_20000_CubeSpaceAE_AMA4Conv_kltune2"
pb_subdir="prob-cylinders-4"
conf_folder="05-06T11:28:54.877"
label="blocks_877"

domains_dirs=samples/$after_sample/gridAll/logs
probs_subdir="prob-cylinders-4"


# ##################
# #     SOKOBAN    #
# ##################

# exec 1>mysokoban_MAKESTATS.out 2>mysokoban_MAKESTATS.err


# task="sokoban"
# type="sokoban_image-20000-global-global-2-train"
# width_height=""
# nb_examples="20000"
# suffix="without"
# baselabel="sokoban"
# after_sample="sokoban_sokoban_image-20000-global-global-2-train_20000_CubeSpaceAE_AMA4Conv_kltune2"
# probs_subdir="sokoban-2-False"

# domains_dirs=samples/$after_sample/grid2/logs





# # 1) Put all the probs to already filled subdirectories (the ones where you have the domain.pddl)
# for dir in $domains_dirs/*/
# do
#     #echo $(basename $dir)
#     #if [[ "$(basename $dir)" == "05-10T23:39:44.020" ]]; then
#     current_dir=$(basename $dir)
#     echo $dir

#     # echo problem-generators/backup-propositional/vanilla/$probs_subdir
#     # cp -r problem-generators/backup-propositional/vanilla/$probs_subdir $dir
#     # echo $dir/$probs_subdir
#     # cd $dir/$probs_subdir
#     # find . -type f -not -name '*.png' -delete
#     # find . -type f -name 'ama3*' -delete
#     # cd $pwdd

#     #fi
# done


# # 2) Now loop over the configuration folders (in samples/soko.../grid1/logs/), but this time generate the domain.pddl
# for dir in $domains_dirs/*/
# do
#     #if [[ "$(basename $dir)" == "05-10T07:04:12.868" ]]; then
#     current_dir=$(basename $dir)
#     ./train_kltune.py dump $task $type $width_height $nb_examples CubeSpaceAE_AMA4Conv kltune2 --hash $current_dir
#     ./pddl-ama3.sh $dir
#     #fi
# done





# # 3) finally again same loop but this time : use the domain.pddl 
# #    and go over the problems #   
# for dir in $domains_dirs/*/
# do
#     #if [[ "$(basename $dir)" == "05-10T23:31:56.595" ]]; then
#     echo ${dir}domain.pddl
#     echo $probs_subdir
    
#     ./ama3-planner-all.py $dir/domain.pddl $dir/$probs_subdir blind 1
#     #fi
# done


# 3BIS) generate the plans
for dir in $domains_dirs/*/
do

    domainfile="$dir/domain.pddl"

    for pb in $dir$probs_subdir/*/
    do
        cd $pb
        problemfile=$pb$(ls | grep -v "time" | grep problem.pddl)
        planfile=$pb/the.plan
        echo "icii "
        echo $planfile
        echo $domainfile 
        echo $problemfile
        ouut=$(/workspace/latplan/latplanClonedAfter/pypy3.8-v7.3.11-linux64/bin/pypy /workspace/latplan/latplanClonedAfter/downward/fast-downward.py --alias lama-first --plan-file $planfile $domainfile $problemfile --translate-options --invariant-generation-max-candidates 0)
        echo $ouut
        #/workspace/latplan/latplanClonedAfter/small-launch.sh $planfile $domainfile $problemfile
        cd ..
    done
    ## START PLANNING AND GENERATE (or not) the .PLAN file
    #
    #self.bar.update(epoch+1, status = "[finished planning] "+"\n")

done


# AND take the number of found solutions AND write them in a fresh json
# THEN produce the last json (combination with the latter)
# FINALLY  a script that will go through all the jsons and make the stats
#cp -r problem-generators/backup-propositional/vanilla/$probs_subdir domains_dirs

# # loop over the configs
# for dir in $domains_dirs/*/
# do
#     nb_sols=$(find $dir -mindepth 1 -type f -name "*.plan" -exec printf x \; | wc -c)
#     echo $nb_sols > nb_sols.txt
#     # 
#     ./new-json-and-test-xhi.py $dir
# done


# # 5) generate the sols.txt
# for dir in $domains_dirs/*/
# do
#     nbsolSeven=0
#     nbsolSevenOtp=0
#     nbsolFourteen=0
#     nbsolFourteenOpt=0

#     #
#     for pb in $dir$probs_subdir/*/
#     do
#         echo $pb
#         # check if there is a plan file (echo it)
#         is_sol=$(find $pb -mindepth 0 -type f -name "*.plan" -exec printf x \; | wc -c)
#         # echo 

#         # 
#         if [ $is_sol -eq "1" ];then

#             fileoutput=$(cat $pb/*.plan)
#             # check if there is an optimal plan
#             # if current Pb dir is of type 007-
#             if [[ "$pb" == *"007-"* ]]; then
#                 nbsolSeven=$((nbsolSeven+1))
#                 if [[ "$fileoutput" == *"cost = 7"* ]]; then
#                     nbsolSevenOtp=$((nbsolSevenOtp+1))
#                     echo "Optimal solution for 7 steps prob"
#                 fi
#             fi

#             if [[ "$pb" == *"014-"* ]]; then
#                 nbsolFourteen=$((nbsolFourteen+1))
#                 if [[ "$fileoutput" == *"cost = 14"* ]]; then
#                     nbsolFourteenOpt=$((nbsolFourteenOpt+1))
#                     echo "Optimal solution for 14 steps prob"
#                 fi
#             fi
#         fi
#     done

#     # write a file containing line after line
#     # nb
#     echo $nbsolSeven > $dir/sols.txt
#     echo $nbsolSevenOtp >> $dir/sols.txt
#     echo $nbsolFourteen >> $dir/sols.txt
#     echo $nbsolFourteenOpt >> $dir/sols.txt

# done



# create the new.json fileS
# # generate the sols.txt
# for dir in $domains_dirs/*/
# do
#     #echo $dir
#     ./create-jsons.py $dir
# done