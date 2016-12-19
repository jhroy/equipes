# -*- coding: utf-8 -*-
# ©2016 Jean-Hugues Roy. GNU GPL v3.

import csv
from random import shuffle
import time
import datetime

# On définit d'abord le nom du fichier texte dans lequel on va écrire notre liste d'équipes
session = "Hiver 2017"
s = session.split()
fichier = "equipes4424-{}_{}.txt".format(s[0],s[1])

# On définit ensuite des variables pour contenir nos deux csv source
edm5242 = "equipes5242.csv" # Contient les équipes dans lesquelles les étudiants étaient dans le cours préalable
edm4424 = "inscrits.csv" # Contient les noms des étudiants inscrits au cours cette session-ci

# On lit les fichiers csv et on les met chacun dans une variable
f1 = open(edm4424)
f2 = open(edm5242)
ff1 = csv.reader(f1)
ff2 = csv.reader(f2)

inscrits = [] # Inscrits cette session-ci
equipes = [] # Équipes pour cette session-ci
etudiants = [] # Équipes dans le cours préalable (EDM5242)
pairImpair = ""

# Fonction pour écrire les équipes dans le terminal et dans le fichier
def inscription(numEquipe,prenom1,nom1,e1,prenom2,nom2,e2):
	print("Équipe {}".format(numEquipe))
	print("-"*10)
	print("{} {} ({})".format(prenom1,nom1,e1))
	print("{} {} ({})".format(prenom2,nom2,e2))
	with open(fichier, "a") as f:
		print("Équipe {}".format(numEquipe), file=f)
		print("-"*10, file=f)
		print("{} {} ({})".format(prenom1,nom1,e1), file=f)
		print("{} {} ({})".format(prenom2,nom2,e2), file=f)

# Fonction en cas de blocage (quand il est impossible de faire en sorte que deux étudiants qui étaient ensemble dans le cours préalable ne soient pas dans la même équipe)
def echec():
	print("#"*46)
	print("# ÉCHEC LAMENTABLE!!! IL FAUT RECOMMENCER!!! #")
	print("#"*46)

# On forme des listes à partir des variables crées plus tôt 
for inscrit in ff1:
	inscrits.append(inscrit)

for etudiant in ff2:
	etudiants.append(etudiant)

# On ajoute à chacun des étudiants inscrits le numéro d'équipe qu'il avait dans le cours préalable
for inscrit in inscrits:
	for etudiant in etudiants:
		if inscrit[0] == etudiant[2]:
			inscrit.append(etudiant[3])

# Les étudiants qui n'ont pas suivi le préalable (c'est le cas d'étudiants français en échange) sont placés dans une équipe factice, l'équipe "0"
for inscrit in inscrits:
	if len(inscrit) < 5:
		inscrit.append("0")

# Puisqu'on forme des équipes de deux, on divise le nombre d'inscrits par deux pour connaître le nombre d'équipes
nbEquipes = len(inscrits)/2

# On vérifie si on a un nombre d'inscrits pair ou impair.
# S'ils sont un nombre impair, la dernière équipe sera composée de trois étudiants.
if len(inscrits) % 2 == 0:
	pairImpair = "pair"
else:
	pairImpair = "impair"
	nbEquipes = nbEquipes - 0.5

nbEquipes = int(nbEquipes)

# Impression d'une entête

print("\n")
print("#"*80)
with open(fichier, "a") as f:
	print("\n", file=f)
	print("#"*80, file=f)

print("Session {}".format(session))
print("Nous avons {} étudiants inscrits au cours EDM4424".format(str(len(inscrits))))
print("Nous aurons donc {} équipes".format(str(nbEquipes)))
if pairImpair == "impair":
	print("Puisqu'il s'agit d'un nombre impair, la dernière équipe sera composée de 3 étudiants")

with open(fichier, "a") as f:
	print("Session {}".format(session), file=f)
	print("Nous avons {} étudiants inscrits au cours EDM4424".format(str(len(inscrits))), file=f)
	print("Nous aurons donc {} équipes".format(str(nbEquipes)), file=f)
	if pairImpair == "impair":
		print("Puisqu'il s'agit d'un nombre impair, la dernière équipe sera composée de 3 étudiants", file=f)

print("#"*80)
print("\n")
with open(fichier, "a") as f:
	print("#"*80, file=f)
	print("\n", file=f)

x = nbEquipes

# On commence par choisir au hasard un premier membre dans chacune de nos équipes
shuffle(inscrits)
for inscrit in inscrits:
	if x > 0:
		equipes.append(inscrit)
	x -= 1

# print(equipes,len(equipes))

# On retranche de notre bassin d'inscrits les étudiants qu'on vient de placer comme premier membre de nos équipes
for membre1 in equipes:
	for inscrit in inscrits:
		if membre1[0] == inscrit[0]:
			inscrits.remove(inscrit)

i = 1

# On peut compléter nos équipes
for membre1 in equipes:
	shuffle(inscrits)
	for inscrit in inscrits:
		# On vérifie tout d'abord si les deux étudiants étaient membres de la même équipe dans le cours préalable
		if membre1[4] == inscrit[4]:
			print("   >>>   {} {} et {} {} étaient tous deux dans l'équipe {}\n".format(membre1[2],membre1[1],inscrit[2],inscrit[1],inscrit[4]))
			if i == nbEquipes:
				echec()
		# S'ils ne l'étaient pas, ils peuvent être placés dans la même équipe pour ce cours-ci
		else:
			if i < nbEquipes:
				inscription(str(i),membre1[2],membre1[1],membre1[4],inscrit[2],inscrit[1],inscrit[4])
				inscrits.remove(inscrit)
				print("\n"+"="*40+"\n")
				with open(fichier, "a") as f:
					print("\n"+"="*40+"\n", file=f)
				break
		# Lorsque vient le temps de former la dernière équipe, on vérifie si les deux étudiants qui restent peuvent être placés en semble
			else:
				for dernier in inscrits:
					if membre1[4] == dernier[4]:
						echec()
						print("   >>>   {} {} et {} {} étaient tous deux dans l'équipe {}\n".format(membre1[2],membre1[1],inscrit[2],inscrit[1],inscrit[4]))
						break
					else:
						if pairImpair == "pair":
							inscription(str(i),membre1[2],membre1[1],membre1[4],inscrit[2],inscrit[1],inscrit[4])
							inscrits.remove(inscrit)
							print("\n"+"="*40+"\n")
							with open(fichier, "a") as f:
								print("\n"+"="*40+"\n", file=f)
							break
						else:
							inscription(str(i),membre1[2],membre1[1],membre1[4],inscrit[2],inscrit[1],inscrit[4])
							inscrits.remove(inscrit)
							break
	i += 1
	# print(inscrits)
if pairImpair == "impair":
	inscrit = inscrits[0]
	print("{} {} ({})".format(inscrit[2],inscrit[1],inscrit[4]))
	with open(fichier, "a") as f:
		print("{} {} ({})".format(inscrit[2],inscrit[1],inscrit[4]), file=f)
	inscrits.remove(inscrit)
	print("\n"+"="*40+"\n")
	with open(fichier, "a") as f:
		print("\n"+"="*40+"\n", file=f)

# Message flattant l'égo en cas de réussite
if len(inscrits) == 0:
	print("#"*44)
	print("# SUCCÈS POUR GRANDIOSE NATION KAZAKHSTAN! #")
	print("#"*44)
else:
	print(inscrits)

now = datetime.datetime.now()

jour = now.day
mois = time.strftime("%b")
annee = now.year
heure = time.strftime("%Hh%M")

print("\nListe générée automagiquement par un script\nLe {} {} {} à {}".format(jour,mois,annee,heure))
with open(fichier, "a") as f:
	print("\nListe générée automagiquement par un script\nLe {} {} {} à {}".format(jour,mois,annee,heure), file=f)
