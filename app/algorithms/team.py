#!/usr/local/bin/python3
import numpy as np
from numpyencoder import NumpyEncoder
import json
import sys
import copy
#Get number of teams by args 
nb_teams = int(sys.argv[1]) # Recupere le nombre d'équipes en input
nb_matchs = int( nb_teams / 2  ) #Divise le nombre d'équipe par 2

def generate_matchs(number_of_teams,rounds,first_team_array,second_team_array): # Fonction permettant de générer les matchs
  global copy_tab  # initialise globalement un tableau
  copy_tab = False # Attribue la valeur false
  current_round = 0 # initialise le premier round à 0
  first_round = [] # tableau contenant le premier round
  matchs = [] # tableau contenant tous les matchs
  first_round_array = [] # tableau contenant tout le premier round
  #Si multiple de 4
  if (number_of_teams % 4 == 0): # Vérifie si le nombre d'equipe est un multiple de 4
    while current_round < rounds : # Tant que le dernier round n'est pas atteint
      if(current_round < 1): # S'il s'agit du premier round (index 0)
        team_index = 0
        temp_first_round = [] # Tableau temporaire pour stocker les matchs du round
        while team_index < len(first_team_array): # Tant que chaque equipe n'est pas attribué
          tempArray = [first_team_array[team_index],second_team_array[team_index]] # Match les index des deux tablaux , ex : Equipe1 vs Equipe7, Equipe2 vs Equipe8 etc...
          temp_first_round.append(tempArray) # Insere le round temporaire à l'intérieur du tableau contenant les matchs du premier round
          team_index +=1 # incremente l'index
        team_index=0
        first_round_array = copy.deepcopy(temp_first_round) # Realise un shallow copying du tableau temporaire du premier round
        current_round_array = copy.deepcopy(temp_first_round) #Copy current round
        current_round+=1 # incremente le round courant
        matchs.insert(current_round,[f"R{current_round}",current_round_array]) # Insere le round courant dans le tableau contenant tous les rounds
      else:
        #Generation de la suite du tableau
        for index_i in range(len(temp_first_round)):
          if (index_i % 2 == 0): # Si l'index est chiffre pair
            if (temp_first_round[index_i][0] % 2 == 0):
              temp_first_round[index_i][0],temp_first_round[index_i-1][0] = temp_first_round[index_i-1][0],temp_first_round[index_i][0]
            else:
              temp_first_round[index_i][0],temp_first_round[index_i+1][0] = temp_first_round[index_i+1][0],temp_first_round[index_i][0]
        for index_k in range(len(temp_first_round)):
          if current_round < (rounds / 2 ):
            if (index_k % 2 == 0): # Si l'index est chiffre pair
              if (temp_first_round[index_k][1] % 2 == 0):
                temp_first_round[index_k][1],temp_first_round[index_k+1][1] = temp_first_round[index_k+1][1],temp_first_round[index_k][1]
              else:
                temp_first_round[index_k][1],temp_first_round[index_k-1][1] = temp_first_round[index_k-1][1],temp_first_round[index_k][1]
          elif(current_round == (rounds / 2)):
            j = 0
            if (copy_tab == False):
              while j < len(temp_first_round):
                temp_first_round[j][1] = first_round_array[j][1]
                j+=1
              copy_tab=True
            if (first_round_array[index_k][1] % 2 == 0):
              temp_first_round[index_k][1],temp_first_round[index_k-1][1] = temp_first_round[index_k-1][1],temp_first_round[index_k][1]
          else:
            if (index_k % 2 == 0):
              if (temp_first_round[index_k][1] % 2 == 0):
                temp_first_round[index_k][1],temp_first_round[index_k-1][1] = temp_first_round[index_k-1][1],temp_first_round[index_k][1]
              else:
                temp_first_round[index_k][1],temp_first_round[index_k+1][1] = temp_first_round[index_k+1][1],temp_first_round[index_k][1]     
        current_round+=1
        current_round_array = copy.deepcopy(temp_first_round) #Copy current round
        matchs.insert(current_round,[f"R{current_round}",current_round_array])
      # print(f"R{current_round}",temp_first_round)
    return matchs
  else: # Si le nombre n'est pas un multiple de 4
    while current_round < rounds:
      for index_i in range(len(first_team_array)):
        if (current_round < 1):
          team_index = 0
          temp_first_round = []
          while team_index < len(first_team_array):
            temp_first_round.append([first_team_array[team_index],second_team_array[team_index]])
            team_index +=1
          current_round_array = copy.deepcopy(temp_first_round) #Copy current round
          team_index=0
        else:
          #Tant que index_i n'atteint pas la limite du tableau
          if (index_i < len(first_team_array) - 1):
            temp_first_round[index_i][0],temp_first_round[index_i - 1][0] = temp_first_round[index_i - 1][0],temp_first_round[index_i][0]
          temp_first_round[index_i][1],temp_first_round[index_i + 1 if index_i + 1 < (index_i == len(first_team_array) - 1) else 0][1] = temp_first_round[index_i + 1 if index_i + 1 < (index_i == len(first_team_array) - 1) else 0][1],temp_first_round[index_i][1]
          current_round_array = copy.deepcopy(temp_first_round) #Copy current round
      current_round+=1
      matchs.insert(current_round,[f"R{current_round}",current_round_array])
    return matchs # renvoie tous les matchs dans un tableau
  
def teams_def(nbre_equipes,nbre_matchs, team_array_1, team_array_2):
  team_array_index = 0
  current_match = 0
  tab = generate_matchs(nbre_equipes,nb_rounds,team_array_1,team_array_2) # execution de la fonction qui genere les matchs 
  print(json.dumps(tab, cls=NumpyEncoder))
  return tab # retourne le tableau avec les rounds et matchs

if ((nb_teams > 0) and ((nb_teams % 2) == 0)): # Si nombre équipes > 0 et pair
    nb_rounds = nb_matchs
    nb_matchs = int(nb_teams / 2)
    first_team_array = np.arange(1, nb_matchs+1)
    second_team_array = np.arange(nb_matchs+1, nb_teams+1)
    teams_def(nb_teams,nb_matchs, first_team_array, second_team_array)
else : 
  print('Il est nécessaire d avoir un nombre d equipes >= 10 équipes et/ou strictement pair !') # Renvoie message d'erreur
  sys.exit() # Quite le programme