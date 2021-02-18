# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@admin = User.create!(email: "admin@jfj.com", password: "123456", firstname: "Réal", lastname: "Tremblay", address: "1570 rue morin", city: "Shawinigan", postal_code: "G0X2V0", province: "Québec", phone_number: "8195335333", is_admin: true)
@admin.picture.attach(io: File.open(Rails.root + "app/assets/images/default.jpg"), filename: 'default.jpg')
#https://www.amazon.ca/-/fr/Marina-Thermom%C3%A8tre-flottant-ventouse-aquarium/dp/B0002AQITK?ref_=Oct_s9_apbd_orecs_hd_bw_b6rqbEx&pf_rd_r=X0J2Z10J5XYN88WEEXXC&pf_rd_p=38bd970b-92ba-5009-be3c-7de76d6b9340&pf_rd_s=merchandised-search-10&pf_rd_t=BROWSE&pf_rd_i=6292479011&th=1
@product = Product.create(category: "Accessoire et Hygiène", price: 2.97, title: "Thermomètre avec ventouse", description: "Un thermomètre: ça sert à savoir la température de l'eau.", quantity: 10, animal_type: "Aquariophilie")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.jpg"), filename: 'thermometre.jpg')
#https://zoo-max.com/fr/product/serin-2-lbs-3/?v=c4782f5abe5c
@product = Product.create(category: "Nourriture", price: 7.49, title: "Vitomax pour serin", description: "Vitomax est une nourriture enrichie de vitamines et minéraux.", quantity: 10, animal_type: "Oiseaux")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/vitomaxserin.jpg"), filename: 'vitomaxserin.jpg')
#https://www.amazon.ca/-/fr/MiXXAT-%C3%A9lectrique-poisson-r%C3%A9aliste-peluche/dp/B08R75GKRC?ref_=Oct_s9_apbd_onr_hd_bw_b6roVQZ&pf_rd_r=72HBBNPHM29AM45T2JWA&pf_rd_p=d3d0fd8a-55ca-5b01-96f1-8d88b8665180&pf_rd_s=merchandised-search-10&pf_rd_t=BROWSE&pf_rd_i=6291980011
@product = Product.create(category: "Jouet", price: 16.99, title: "Poisson électrique", description: "Jouet poisson électrique à l'herbe à chat.", quantity: 10, animal_type: "Chats")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/poissonelectrique.jpg"), filename: 'poissonelectrique.jpg')
#https://www.amazon.ca/-/fr/PawHut-Clapier-sur%C3%A9lev%C3%A9-plateau-coulissant/dp/B07DP9H9CC/ref=zg_mw_6292604011_18?_encoding=UTF8&psc=1&refRID=6D6E931H0RJT1PSATYEK
@product = Product.create(category: "Cage", price: 209.99, title: "Clapier surélevé en bois à 2 étages", description: "Matériau : pin, bois de sapin, fil d'acier. Couleur : Poids du filet : Dimensions totales : Dimensions de la porte en maille HTop : Dimensions de la porte en bois HTop : 27,6 x 12,8 cm. 12,8 x 15,7 cm.", quantity: 10, animal_type: "Petits Animaux")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/clapierbois.jpg"), filename: 'clapierbois.jpg')
#https://www.amazon.ca/-/fr/Exo-Terra-Terrarium-verre-cm/dp/B000OQYGQ4/ref=sr_1_35?dchild=1&pf_rd_i=6292579011&pf_rd_p=14ef9e4c-de6f-5130-b917-d2ce76be83da&pf_rd_r=D6DW4VQBM8WWZSBS9V8E&pf_rd_s=merchandised-search-10&pf_rd_t=BROWSE&qid=1613405997&refinements=p_72%3A11192170011&s=pet-supplies&sr=1-35
@product = Product.create(category: "Aquarium et Terrarium", price: 279.81, title: "Terrarium en verre", description: "Terrarium en verre de 45,7 x 45,7 x 45,7 cm pour petit reptiles ou amphibiens.", quantity: 10, animal_type: "Reptiles et Amphibiens")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/petitterrarium.jpg"), filename: 'petitterrarium.jpg')
#https://www.amazon.ca/-/fr/Load-Kennel-Door-Blue-15lbs/dp/B0062JFGM0?ref_=Oct_s9_apbd_otopr_hd_bw_b6rpZFD&pf_rd_r=29GXD55HKH0STC9FMXAQ&pf_rd_p=84b0eb4c-0fba-5f16-b821-c3620ae185eb&pf_rd_s=merchandised-search-10&pf_rd_t=BROWSE&pf_rd_i=6292233011&th=1
@product = Product.create(category: "Transport", price: 53.99, title: "petit pet voyageur", description: "De petite taille et idéal pour les petits chiens.", quantity: 10, animal_type: "Chiens")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/petitpetvoyageur.jpg"), filename: 'petitpetvoyageur.jpg')
#https://www.amazon.ca/-/fr/American-Products-30-gallons-Acrylique-Aquarium/dp/B0085Y5AYE/ref=sr_1_106?dchild=1&qid=1613406756&s=pet-supplies&sr=1-106
@product = Product.create(category: "Aquarium et Terrarium", price: 332.57, title: "Aquarium 30 gallon", description: "Aquarium de 30 gallon en acrylique.", quantity: 10, animal_type: "Aquariophilie")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/aquarium30g.jpg"), filename: 'aquarium30g.jpg')
#https://www.amazon.ca/liti%C3%A8re-alliage-daluminium-poign%C3%A9e-souple/dp/B08NSNHRLD?ref_=Oct_s9_apbd_onr_hd_bw_b6roT5P&pf_rd_r=RVV3SW9JJVFXNNEP1FYS&pf_rd_p=d59b0580-cf21-57e3-8091-74eac13cc030&pf_rd_s=merchandised-search-10&pf_rd_t=BROWSE&pf_rd_i=6291971011
@product = Product.create(category: "Accessoire et Hygiène", price: 17.99, title: "Pelle a litière", description: "Pelle en alluminium pour nettoyer la litière.", quantity: 10, animal_type: "Chats")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/allupellelitiere.jpg"), filename: 'allupellelitiere.jpg')
#https://www.amazon.ca/-/fr/ReptoMin-B%C3%A2tonnets-flottants-aquatiques-grenouilles/dp/B00025640S?ref_=Oct_s9_apbd_orecs_hd_bw_b6rqvX1&pf_rd_r=FKDE80ENS9FJP14FYB1T&pf_rd_p=f8fedcfe-997e-5b32-8d82-8675cf4542f8&pf_rd_s=merchandised-search-10&pf_rd_t=BROWSE&pf_rd_i=6292557011
@product = Product.create(category: "Nourriture", price: 21.99, title: "Bâtonnets flottants", description: "Nourriture pour tortue sousforme de batonnêts flottants.", quantity: 10, animal_type: "Reptiles et Amphibiens")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/turtlefeed.jpg"), filename: 'turtlefeed.jpg')
#https://www.amazon.ca/-/fr/Prevue-Products-verte-noire-SP1804-4/dp/B00SK7HOS6/ref=zg_bs_6291718011_24?_encoding=UTF8&psc=1&refRID=P4XMB2BV0821R0HV7AC9
@product = Product.create(category: "Cage", price: 131.80, title: "Cage de vol", description: "Cage verte adaptée pour les petits oiseaux.", quantity: 10, animal_type: "Oiseaux")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/cagevolpetit.jpg"), filename: 'cagevolpetit.jpg')
#https://www.amazon.ca/-/fr/HAMMER-Liti%C3%A8re-double-r%C3%A9sistante-contr%C3%B4le/dp/B01MFF2ZAH/ref=lp_6291972011_1_1?th=1
@product = Product.create(category: "Accessoire et Hygiène", price: 18.98, title: "Litière à chat", description: "Élimine à la fois les odeurs d'urine et d'excréments sur le contact.", quantity: 10, animal_type: "Chats")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/litiere.jpg"), filename: 'litiere.jpg')
#https://www.amazon.ca/-/fr/Living-60888-transport-animal-compagnie/dp/B006JVPL8A?ref_=Oct_s9_apbd_otopr_hd_bw_b6rr22F&pf_rd_r=APECRY9T4G3T06B5XYFK&pf_rd_p=07a4b9b1-fe81-5631-890f-94876d733f70&pf_rd_s=merchandised-search-10&pf_rd_t=BROWSE&pf_rd_i=6292582011
@product = Product.create(category: "Transport", price: 14.97, title: "Mini pet voyageur", description: "Idéal pour tous les petits animaux.", quantity: 10, animal_type: "Petits Animaux")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/transportpetitanimaux.jpg"), filename: 'transportpetitanimaux.jpg')
#https://www.amazon.ca/-/fr/Living-World-Lot-2-bonbons/dp/B0002DH2YW/ref=sr_1_4?dchild=1&qid=1613658721&s=pet-supplies&sr=1-4
@product = Product.create(category: "Accessoire et Hygiène", price: 4.79, title: "Os de Seiche", description: "Parfait et nécessaire pour la santé des os de votre oiseau.", quantity: 10, animal_type: "Oiseaux")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/osdeseiche.jpg"), filename: 'osdeseiche.jpg')
#https://www.amazon.ca/-/fr/Omega-Tricky-Treat-English-Manual/dp/B0002DK26M/ref=sr_1_7?dchild=1&qid=1613658774&s=pet-supplies&sr=1-7
@product = Product.create(category: "Jouet", price: 8.97, title: "Balle", description: "Balle jaune-orange pour amuser votre chien sans effort.", quantity: 10, animal_type: "Chiens")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/balchien.jpg"), filename: 'balchien.jpg')
#https://www.amazon.ca/-/fr/IAMS-ProACTIVE-Health-Nourriture-poulet/dp/B01DVVEU9G/ref=sr_1_24?dchild=1&qid=1613658844&s=pet-supplies&sr=1-24
@product = Product.create(category: "Nourriture", price: 19.48, title: "Nourriture sèche pour chat", description: "Alimentation saine et complète pour votre chat, contient aussi de la dinde.", quantity: 10, animal_type: "Chats")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/nourriturechat.jpg"), filename: 'nourriturechat.jpg')

command1 = Command.create(sub_total: 9.99, tps: 1.78,tvq: 1.80,total: 13.57,store_pickup: true, state: "test", shipping_adress: "Hellooo worlld", user_id: 1)
command2 = Command.create(sub_total: 9.99, tps: 1.78,tvq: 1.80,total: 13.57,store_pickup: true, state: "test", shipping_adress: "Hellooo worlld", user_id: 1)
