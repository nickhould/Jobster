# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Scrapers

espresso_jobs = Scraper.create( id: 		1, 
								name:   "Espresso-Jobs", 
                source: "http://www.espresso-jobs.com/",
                icon:   "espresso_icon.png")


grenier = Scraper.create( id: 	  2,
								name:   "Grenier aux Emplois", 
                source: "http://www.grenier.qc.ca/emplois",
                icon: 	"grenier_icon.jpg")


infopresse = Scraper.create( id: 		3,
								name: 	"Infopresse", 
                source: "http://www3.infopresse.com/jobs/",
                icon: 	"infopresse_icon.png")

puts "Done fetching data."