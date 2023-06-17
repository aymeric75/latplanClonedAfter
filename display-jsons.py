#!/usr/bin/env python3


# "samples/sokoban_sokoban_image-20000-global-global-2-train_20000_CubeSpaceAE_AMA4Conv_kltune2/grid1/logs/05-10T07:04:12.868"

# samples/sokoban_sokoban_image-20000-global-global-2-train_20000_CubeSpaceAE_AMA4Conv_kltune2/grid1/logs/05-10T07:11:24.761

def main(thearg):

    final_dict = {}

    # ONCE IN A CONF FOLDER


    name_dir = thearg[0].split("/")[-2]


    import json

    # open le aux.json, récup: N, beta_d, beta_z, "sols": 0, "opt_sols": 0
    with open(thearg[0]+"/aux.json", "r") as file:
        data = json.load(file)
        final_dict['N'] = data['parameters']['N']
        final_dict['beta_d'] = data['parameters']['beta_d']
        final_dict['beta_z'] = data['parameters']['beta_z']



    with open(thearg[0]+"/sols.txt", "r") as ff:
        
        lines_tab = ff.readlines()
        #print(lines_tab[1].strip())
        #nb_opt_sols = int(lines_tab[1].strip()) + int(lines_tab[3].strip())
        nb_sols = int(lines_tab[0].strip()) + int(lines_tab[2].strip())

        final_dict['nb_sols'] = nb_sols


    print(name_dir+" "+str(final_dict['N'])+" "+str(final_dict['beta_d'])+" "+str(final_dict['beta_z'])+" "+str(final_dict['nb_sols']))

    # json_object = json.dumps(final_dict, indent=4)
    # with open(thearg[0]+"/new.json", "w") as outfile:
    #     print("hello")
    #     outfile.write(json_object)




import sys

if __name__ == '__main__':
    
    try:
        main(sys.argv[1:])
    except Exception as e:
        print(e)