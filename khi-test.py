#!/usr/bin/env python3
import json
import pandas as pd
import os

# gathering the content of the res*.json files

# assign directory
#directory = 'res'
 
directory = 'samples/sokoban_sokoban_image-20000-global-global-2-train_20000_CubeSpaceAE_AMA4Conv_kltune2/gridAll/logs'

final_table = []

# iterate over files in
# that directory
for dire in os.listdir(directory):


    # 
    curre_dir = directory+"/"+dire

    #if filename == "new.json":
    # open the new.json file

    f = os.path.join(curre_dir, "new.json")
    print(f)

    # checking if it is a file
    if os.path.isfile(f):
        #print(f)
        print("la")
        with open(f, "r") as file:
            data = json.load(file)
            #print(data)
            #del data['opt_sols']
            final_table.append(data)

# N beta_d
dataf = pd.DataFrame(final_table)


print(dataf.head(29))


from sklearn.feature_selection import chi2

X = dataf.drop('nb_opt_sols',axis=1)
y = dataf['nb_opt_sols']
chi_scores = chi2(X,y)

print(chi_scores)