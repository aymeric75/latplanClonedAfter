#!/bin/bash


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



ouut=$(pypy3.8-v7.3.11-linux64/bin/pypy downward/fast-downward.py --alias lama-first --plan-file $1 $2 $3 --translate-options --invariant-generation-max-candidates 0)

if [[ $ouut == *"] Solution found!"* ]]; then
    counter_solSeven=$((counter_solSeven+1))
fi

echo $ouut


#./ama3plannerNOmodule.py $1 $2 blind 1
#./train_kltune.py dump $task $type $width_height $nb_examples CubeSpaceAE_AMA4Conv kltune2 --hash $conf_folder
# pwdd=$(pwd)
# domain_dir=samples/$after_sample/logs/$conf_folder
# ./pddl-ama3.sh $pwdd/$domain_dir
# then, once you have the domain.pddl, need the problem !
# so, 