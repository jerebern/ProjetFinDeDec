# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.create!(email: "admin@jfj.com", password: "123456", firstname: "Réal", lastname: "Tremblay", address: "1570 rue morin", city: "Shawinigan", postal_code: "G0X2V0", province: "Québec", phone_number: "8195335333", is_admin: true)