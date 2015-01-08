# equipes
Script pour former automagiquement 15 équipes en évitant que deux étudiants se retrouvent dans la même équipe que la session précédente. Il produit un fichier txt.

Il est encore bogué: une boucle sans fin peut se produire, à la fin, lorsque des étudiants qui étaient dans la même équipe (ou qui n'étaient pas inscrits) à la session précédente restent encore à placer. Mais il s'interrompt seul après cinq boucles à vide. Il suffit de le relancer en espérant qu'il fonctionne.
