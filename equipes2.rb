#!/usr/bin/env ruby
# ©2015 Jean-Hugues Roy. GNU GPL v3.

fichier = "Équipes EDM4424 - automne2015 (TEST).txt"

# étudiants inscrits à la session précédente, regroupés en équipes
# j'ai remplacé le nom des étudiants par des personnalités connues
edm5242 = [
	["Cyrus le Grand", "Spartacus", "Siddhartha Gautama"],
	["William Wallace", "Jeanne d'Arc", "Martin Luther"],
	["Oliver Cromwell", "Benjamin Franklin", "Thomas Paine"],
	["Maximilien Robespierre", "Georges Jacques Danton", "Jean-Paul Marat"],
	["Mohandas Mahatma Gandhi", "Indira Gandhi", "Annie Besant"],
	["Emiliano Zapata", "Pancho Villa", "Simon Bolivar"],
	["Michael Collins", "Eamon de Valera", "John MacBride"],
	["Patrice Lumumba", "Thomas Sankara", "Ahmed Sekou Touré"],
	["Louis-Joseph Papineau", "Robert Nelson", "Jean-Olivier Chénier"],
	["Léon Trotsky", "Karl Marx", "Lénine"],
	["Nelson Mandela", "Desmond Tutu", "Oliver Tambo"],
	["Rosa Parks", "Malcolm X", "Martin Luther King"],
	["Fidel Castro", "Ernesto Che Guevara", "Celia Sanchez"],
	
	["Briffault Claire", "Parent Maude", "Tavernier-Labrie Frédérique"],
	["Deschênes Félix", "Guilbault Jean-Philippe", "Pelchat-Labelle Louis"],
	["Boulianne Alexis", "Lamoureux Samuel", "Lemelin Philippe"],
	["Dancause Samuel", "Groguhé Marissa", "Pednault-Parent Camille"],
	["Balthazar Jean", "Boni-Rowe Nicolas", "Breton François"],
	["Harvey Matisse", "Sénécal Véronique", "Legendre Jasmine"],
	["Côté Raphaël", "Séguin Elizabeth", "Villeneuve Ali"],
	["Beaulieu David", "D'Onofrio Simon", "Pecourt Shannon"],
	["Hébert Maxime", "Lepage Guillaume", "Richard Amélie"],
	["Jetté Geneviève", "Belzile Justine", "Triffault Nicolas"],
	["Gendron Myriam", "Mailhot Hélène", "Sofia-Myriam Nicolau"]
]

# étudiants inscrits à la session en cours
inscrits = ["Bergeron Cloé", "Joo Raphaëlle", "Tancrède Pénéloppe", "Soucy Mélina",
	"Blanchet Emond Geneviève", "Daoust-Braun Sarah", "De Simone Frédérique", "ÉTUDIANT DE 3E ANNÉE #3",
	"St-André Andy", "Proteau Alex", "Vaillancourt Carl", "Dumoulin Charlotte", "ÉTUDIANT DE 3E ANNÉE #4",
	"Bernier Maxime", "Ouimet-Juteau Daphné", "Mercure-Langlois Lili", "Laferrière Mathieu",
	"St-Amour Béland Magalie", "Daraiche Valérie", "Dupuis Léa", "Warnock-Marceau Nina",
	"Dufort Cathyane", "Proulx-Chevarie Rose", "Landreville Nancy", "Scott Christophe",
	"Laventure Camille", "LeBlanc Justine", "Roy-Brunet Béatrice", "ÉTUDIANT DE 3E ANNÉE #1",
	"Desaulniers Gabryel", "Jolin-Dahel Leïla", "Laverdière Charles", "ÉTUDIANT DE 3E ANNÉE #2"
]

edm4424 = []

def inscription1(fichier, etudiant1, etudiant2, equipe)
	File.open(fichier, 'a') { |file| file.write(
		"Équipe " + (equipe+1).to_s + "\n" +
		etudiant1 + "\n" +
		etudiant2 + "\n" +
		"-"*50 + "\n\n"
	) }
end

def inscription2(fichier, etudiant1, etudiant2, etudiant3, equipe)
	File.open(fichier, 'a') { |file| file.write(
		"Équipe " + (equipe+1).to_s + "\n" +
		etudiant1 + "\n" +
		etudiant2 + "\n" +
		etudiant3 + "\n" +
		"-"*50 + "\n\n"
	) }
end

if inscrits.size%2 == 0
	nbLimite = 0
else
	nbLimite = 2
end

File.open(fichier, 'w') { |file| file.write("Liste d'équipes - inscrits - Session 20xx\n\n" + "="*50 + "\n\n") }

nbEquipes = (inscrits.size/2).to_i

# première boucle pour peupler les équipes d'un premier étudiant
(1..nbEquipes).each do |equipe|
	
	num1 = rand(0..(inscrits.size-1))
	etudiant1 = inscrits[num1]
	inscrits.delete_at(num1)
	edm4424.push etudiant1

end

# 2e boucle qui repasse chacune des équipes pour y mettre un 2e étudiant
# tout en s'assurant que ce 2e étudiant n'était pas en équipe avec le 1er la session précédente
# et en faisant en sorte de place un 3e étudiant dans la dernière équipe dans les cas
# où on a un nombre d'inscrits impair
edm4424.each_with_index do |etudiant1, equipe|

	t = 0
	(0..edm5242.size-1).each do |noEquipe|
		if edm5242[noEquipe].include?(etudiant1) == true
			t = 1
		end
	end
	
	puts "="*40
	puts "Il en reste " + inscrits.size.to_s + ": " + inscrits.to_s + "\n\n"

	if t == 0
		num2 = rand(0..(inscrits.size-1))
		etudiant2 = inscrits[num2]
		inscrits.delete_at(num2)
		puts "Équipe " + (equipe+1).to_s + " : " + etudiant1 + " et " + etudiant2
		inscription1(fichier, etudiant1, etudiant2, equipe)
	else
		edm5242.each do |equipe5242|
			if equipe5242.include?(etudiant1) == true
				# puts equipe5242
				num2 = rand(0..(inscrits.size-1))
				etudiant2 = inscrits[num2]	
				
				if equipe5242.include?(etudiant2) == false
					if inscrits.size > nbLimite
						inscrits.delete_at(inscrits.index(etudiant2))
						puts "Équipe " + (equipe+1).to_s + " : " + etudiant1 + " et " + etudiant2
						inscription1(fichier, etudiant1, etudiant2, equipe)
					else
						if nbLimite == 2
							inscrits.delete_at(inscrits.index(etudiant2))
						end
						etudiant3 = inscrits[0]
						if equipe5242.include?(etudiant3) == true
							break
						end
						inscrits.delete(etudiant3)
						puts "Équipe " + (equipe+1).to_s + " : " + etudiant1 + ", " + etudiant2 + " et " + etudiant3
						inscription2(fichier, etudiant1, etudiant2, etudiant3, equipe)
					end
					puts etudiant1 + " était avec " + equipe5242.to_s + "\n\n"

					# if inscrits.size > 1
					# 	inscrits.delete_at(num2)
					# else
					# 	inscrits.delete_at(0)
					# end
				else
					puts "*"*25
					puts "On ne peut pas former d'équipe " + (equipe+1).to_s
					puts "*"*25
				end
			end
		end
	end

end

puts "="*40
puts "Il reste à placer :"
if inscrits.size == 0
	puts "#"*40
	puts "Personne! YESSSSSSSSSSSS! On a réussi!!!"
	puts "#"*40
else
	puts inscrits
end
