#!/usr/bin/env ruby
# ©2014 Jean-Hugues Roy. GNU GPL v3.

fichier = "Équipes EDM4433 - H2015.txt"

# J'ai remplacé le nom des étudiants par des chefs d'État ou de gouvernement
edm4433 = ["Stephen Harper", "Philippe Couillard", "Kathleen Wynne", "Brian Gallant", "Barack Obama", "François Hollande", "David Cameron", "Mariano Rajoy", "Artur Mas", "Angela Merkel", "Michel Martelly", "Dilma Rousseff", "Enrique Peña Nieto", "Xi Jinping", "Shinzo Abe", "Narendra Modi", "Jacob Zuma", "Benjamin Netanyahou", "Vladimir Poutine", "Petro Porochenko", "Tony Abbott", "Matteo Renzi", "Pedro Passos Coelho", "Cristina Kirchner", "Raul Castro", "Nicolas Maduro", "Abdel Fatah Al-Sissi", "Alassane Ouattara", "Kim Jong-un", "Michelle Bachelet"]

# Équipes de la session précédente
eq5242 = [[edm4433[17], edm4433[18], edm4433[22]], [edm4433[4], edm4433[7], edm4433[12]], [edm4433[11], edm4433[23],edm4433[29]], [edm4433[19], edm4433[28]], [edm4433[2], edm4433[9]], [edm4433[16], edm4433[24], edm4433[26]], [edm4433[5], edm4433[8], edm4433[20]], [edm4433[10], edm4433[27]], [edm4433[6], edm4433[15], edm4433[1]]]

File.open(fichier, 'w') { |file| file.write("Liste d'équipes - EDM4433 - Hiver 2015\n\n" + "="*50 + "\n\n") }

(1..15).each do |equipe|

	puts "Équipe " + equipe.to_s #+ " (il reste " + edm4433.size.to_s + " étudiants)"
	File.open(fichier, 'a') { |file| file.write("Équipe " + equipe.to_s + "\n") }
	# puts eq5242[equipe-1]

	eq1 = 0
	
	num1 = rand(0..(edm4433.size-1))
	etudiant1 = edm4433[num1]
	# puts etudiant1
	t = 0
	(0..8).each do |noEquipe|
		if eq5242[noEquipe].include?(etudiant1) == true
			eq1 = noEquipe + 1
			puts "1. " + etudiant1 + " (" + eq1.to_s + ")"
			File.open(fichier, 'a') { |file| file.write(etudiant1 + "\n") }
			t = 1
		end
	end
	if t == 0
		puts "1. " + etudiant1 + " (-)"
		File.open(fichier, 'a') { |file| file.write(etudiant1 + "\n") }
		eq1 = 0
	end

	edm4433.delete_at(num1)
	# puts eq1
	eq2 = eq1

	boucle = 0

	while eq1 == eq2

		num2 = rand(0..(edm4433.size-1))

		etudiant2 = edm4433[num2]
		# puts etudiant2

		t = 0
		(0..8).each do |noEquipe|
			if eq5242[noEquipe].include?(etudiant2) == true
				eq2 = noEquipe + 1
				if eq2 != eq1
					puts "2. " + etudiant2 + " (" + eq2.to_s + ")"
					File.open(fichier, 'a') { |file| file.write(etudiant2 + "\n") }
				end
				t = 1
			end
			# puts "eq1 = " + eq1.to_s + " , eq2 = " + eq2.to_s
		end
		if t == 0
			if eq2 != eq1
				puts "2. " + etudiant2 + " (-)"
				File.open(fichier, 'a') { |file| file.write(etudiant2 + "\n") }
				eq2 = 0
			elsif equipe > 13
				puts "2. " + etudiant2 + " (-)"
				File.open(fichier, 'a') { |file| file.write(etudiant2 + "\n") }
				eq2 = 0
			end
		end

		# puts "Juste avant fin boucle WHILE : eq1 = " + eq1.to_s + " , eq2 = " + eq2.to_s

		if eq2 != eq1
			edm4433.delete_at(num2)
		end

		boucle += 1

		# puts "Boucle = " + boucle.to_s

		if boucle > 4
			break
		end

	end

	# puts " Après boucle WHILE : eq1 = " + eq1.to_s + " , eq2 = " + eq2.to_s

	puts "-"*25
	File.open(fichier, 'a') { |file| file.write("-"*50 + "\n\n") }

end

if edm4433 == []
	puts "*"*80
	puts "                       SUCCÈS!!!!       ATTABOY!!!!"
	puts "*"*80
else
	puts edm4433
end
