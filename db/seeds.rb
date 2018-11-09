# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'json'
require 'open-uri'

url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
api_drinks_serialized = open(url).read
api_drinks = JSON.parse(api_drinks_serialized)

api_drinks['drinks'].each do |d|
  ingredient = Ingredient.new(
    name: d['strIngredient1']
  )
  ingredient.save!
end

puts 'Creating 100 fake cocktails...'
200.times do
  cocktail = Cocktail.new(
    name: Faker::StarWars.character
  )
  cocktail.save
end

puts 'Creating random doses for cocktails...'
Cocktail.all.each do |cocktail|
  rand(1..6).to_i.times do
    dose = Dose.new(
      description: "#{(1..10).to_a.sample} cl",
      ingredient_id: (1..160).to_a.sample,
      cocktail_id: cocktail.id
    )
    dose.save
  end
end
