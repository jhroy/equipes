# equipes
:books: :books: :books:

Deux scripts pour former automagiquement des équipes en évitant que deux étudiants se retrouvent dans la même équipe que la session précédente dans un cours préalable. Ils produisent un fichier txt.

Le premier (**equipes.rb**) est encore bogué: une boucle sans fin peut se produire, à la fin, lorsque des étudiants qui étaient dans la même équipe (ou qui n'étaient pas inscrits) à la session précédente restent encore à placer. Mais il s'interrompt seul après cinq boucles à vide. Il suffit de le relancer en espérant qu'il fonctionne.

Le deuxième (**equipes2.rb**) est un peu plus robuste. Lorsqu'une équipe ne peut être formée, une indication est imprimée dans le terminal et l'équipe reste vide. Il faut alors le relancer jusqu'à ce que toutes les équipes soient comblées.

Le troisième (**equipes.py**) est le plus robuste. Rédigé en python, il puise à même deux fichiers CSV, un premier qui contient les noms des étudiants et leur numéro d'équipe dans le cours qu'ils ont suivi à la session ou l'année précédente, le second qui contient les noms des étudiants inscrits au cours pour lequel on souhaite former des équipes.
