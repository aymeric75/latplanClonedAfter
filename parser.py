#!/usr/bin/env python3

import glob

# 1) loop over the dirs and print the name of the dir

# import required module
import os
# assign directory
directory = 'samples/sokoban_sokoban_image-20000-global-global-2-train_20000_CubeSpaceAE_AMA4Conv_kltune2/gridAll/logs/'

# iterate over files in
# that directory
for subdir in os.listdir(directory):


    if os.path.isdir(os.path.join(directory, subdir)):


        subdir_path = os.path.join(directory, subdir)


        for probs_dir in os.listdir(subdir_path):


            if probs_dir == "sokoban-2-False":
               
                for pb_dir in os.listdir(os.path.join(subdir_path, probs_dir)):
                    #print(pb_dir)
                    #file_read.readlines()


                    # One line
                    oneline = ""
                    oneline += subdir
                    
                    log_file = glob.glob(directory+subdir+"/"+probs_dir+"/"+pb_dir+"/*.log")


                    with open(log_file[0], "r") as f:
                        lines = f.readlines()
                        for line in lines:
                            if "Translator variables:" in line:
                                oneline += " " + line
                            if "Translator mutex groups:" in line:
                                oneline += " " + line

                    # repertoire | 

                    print(oneline)
    #exit()
