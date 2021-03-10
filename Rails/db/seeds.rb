# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@admin = User.create!(email: "a@a.com", password: "123456", firstname: "Réal", lastname: "Tremblay", address: "1570 rue morin", city: "Shawinigan", postal_code: "G0X2V0", province: "Québec", phone_number: "8195335333", is_admin: true)
@admin.picture.attach(io: File.open(Rails.root + "app/assets/images/default.jpg"), filename: 'default.jpg')
@jerebern = User.create!(email: "b@b.com", password: "123456", firstname: "Jérémy", lastname: "Bernard", address: "2-1903 rue Saint-Jacques", city: "Shawinigan", postal_code: "G9N4A7", province: "Québec", phone_number: "8193295860", is_admin: false)
@jevei = User.create!(email: "c@c.com", password: "123456", firstname: "Jérémy", lastname: "Veillette", address: "3-1903 rue Saint-Jacques", city: "Shawinigan", postal_code: "G9N4A7", province: "Québec", phone_number: "8197358945", is_admin: false)
@felixcm1129 = User.create!(email: "d@d.com", password: "123456", firstname: "Félix", lastname: "Carle-Milette", address: "1660 chemin de Saint-Jean-des-Piles", city: "Shawinigan", postal_code: "G0X2V0", province: "Québec", phone_number: "8196996429", is_admin: false)
@johndoe = User.create!(email: "e@e.com", password: "123456", firstname: "John", lastname: "Doe", address: "Planet Knowhere", city: "Galaxy", postal_code: "000000", province: "Universe", phone_number: "2348956742", is_admin: false)

#https://www.amazon.ca/-/fr/Marina-Thermom%C3%A8tre-flottant-ventouse-aquarium/dp/B0002AQITK?ref_=Oct_s9_apbd_orecs_hd_bw_b6rqbEx&pf_rd_r=X0J2Z10J5XYN88WEEXXC&pf_rd_p=38bd970b-92ba-5009-be3c-7de76d6b9340&pf_rd_s=merchandised-search-10&pf_rd_t=BROWSE&pf_rd_i=6292479011&th=1
@product = Product.create(category: "Accessoire et Hygiène", price: 2.97, title: "Thermomètre avec ventouse", description: "Un thermomètre: ça sert à savoir la température de l'eau.", quantity: 10, animal_type: "Aquariophilie")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/thermometre.png"), filename: 'thermometre.png')
#https://zoo-max.com/fr/product/serin-2-lbs-3/?v=c4782f5abe5c
@product = Product.create(category: "Nourriture", price: 7.49, title: "Vitomax pour serin", description: "Vitomax est une nourriture enrichie de vitamines et minéraux.", quantity: 10, animal_type: "Oiseaux")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/vitomaxserin.png"), filename: 'vitomaxserin.png')
#https://www.amazon.ca/-/fr/MiXXAT-%C3%A9lectrique-poisson-r%C3%A9aliste-peluche/dp/B08R75GKRC?ref_=Oct_s9_apbd_onr_hd_bw_b6roVQZ&pf_rd_r=72HBBNPHM29AM45T2JWA&pf_rd_p=d3d0fd8a-55ca-5b01-96f1-8d88b8665180&pf_rd_s=merchandised-search-10&pf_rd_t=BROWSE&pf_rd_i=6291980011
@product = Product.create(category: "Jouet", price: 16.99, title: "Poisson électrique", description: "Jouet poisson électrique à l'herbe à chat.", quantity: 10, animal_type: "Chats")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/poissonelectrique.png"), filename: 'poissonelectrique.png')
#https://www.amazon.ca/-/fr/PawHut-Clapier-sur%C3%A9lev%C3%A9-plateau-coulissant/dp/B07DP9H9CC/ref=zg_mw_6292604011_18?_encoding=UTF8&psc=1&refRID=6D6E931H0RJT1PSATYEK
@product = Product.create(category: "Cage", price: 209.99, title: "Clapier surélevé en bois à 2 étages", description: "Matériau : pin, bois de sapin, fil d'acier. Couleur : Poids du filet : Dimensions totales : Dimensions de la porte en maille HTop : Dimensions de la porte en bois HTop : 27,6 x 12,8 cm. 12,8 x 15,7 cm.", quantity: 10, animal_type: "Petits Animaux")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/clapierbois.png"), filename: 'clapierbois.png')
#https://www.amazon.ca/-/fr/Exo-Terra-Terrarium-verre-cm/dp/B000OQYGQ4/ref=sr_1_35?dchild=1&pf_rd_i=6292579011&pf_rd_p=14ef9e4c-de6f-5130-b917-d2ce76be83da&pf_rd_r=D6DW4VQBM8WWZSBS9V8E&pf_rd_s=merchandised-search-10&pf_rd_t=BROWSE&qid=1613405997&refinements=p_72%3A11192170011&s=pet-supplies&sr=1-35
@product = Product.create(category: "Aquarium et Terrarium", price: 279.81, title: "Terrarium en verre", description: "Terrarium en verre de 45,7 x 45,7 x 45,7 cm pour petit reptiles ou amphibiens.", quantity: 10, animal_type: "Reptiles et Amphibiens")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/petitterrarium.png"), filename: 'petitterrarium.png')
#https://www.amazon.ca/-/fr/Load-Kennel-Door-Blue-15lbs/dp/B0062JFGM0?ref_=Oct_s9_apbd_otopr_hd_bw_b6rpZFD&pf_rd_r=29GXD55HKH0STC9FMXAQ&pf_rd_p=84b0eb4c-0fba-5f16-b821-c3620ae185eb&pf_rd_s=merchandised-search-10&pf_rd_t=BROWSE&pf_rd_i=6292233011&th=1
@product = Product.create(category: "Transport", price: 53.99, title: "Petit pet voyageur", description: "De petite taille et idéal pour les petits chiens.", quantity: 10, animal_type: "Chiens")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/petitpetvoyageur.png"), filename: 'petitpetvoyageur.png')
#https://www.amazon.ca/-/fr/American-Products-30-gallons-Acrylique-Aquarium/dp/B0085Y5AYE/ref=sr_1_106?dchild=1&qid=1613406756&s=pet-supplies&sr=1-106
@product = Product.create(category: "Aquarium et Terrarium", price: 332.57, title: "Aquarium 30 gallon", description: "Aquarium de 30 gallon en acrylique.", quantity: 10, animal_type: "Aquariophilie")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/aquarium30g.png"), filename: 'aquarium30g.png')
#https://www.amazon.ca/liti%C3%A8re-alliage-daluminium-poign%C3%A9e-souple/dp/B08NSNHRLD?ref_=Oct_s9_apbd_onr_hd_bw_b6roT5P&pf_rd_r=RVV3SW9JJVFXNNEP1FYS&pf_rd_p=d59b0580-cf21-57e3-8091-74eac13cc030&pf_rd_s=merchandised-search-10&pf_rd_t=BROWSE&pf_rd_i=6291971011
@product = Product.create(category: "Accessoire et Hygiène", price: 17.99, title: "Pelle a litière", description: "Pelle en alluminium pour nettoyer la litière.", quantity: 10, animal_type: "Chats")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/allupellelitiere.png"), filename: 'allupellelitiere.png')
#https://www.amazon.ca/-/fr/ReptoMin-B%C3%A2tonnets-flottants-aquatiques-grenouilles/dp/B00025640S?ref_=Oct_s9_apbd_orecs_hd_bw_b6rqvX1&pf_rd_r=FKDE80ENS9FJP14FYB1T&pf_rd_p=f8fedcfe-997e-5b32-8d82-8675cf4542f8&pf_rd_s=merchandised-search-10&pf_rd_t=BROWSE&pf_rd_i=6292557011
@product = Product.create(category: "Nourriture", price: 21.99, title: "Bâtonnets flottants", description: "Nourriture pour tortue sousforme de batonnêts flottants.", quantity: 10, animal_type: "Reptiles et Amphibiens")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/turtlefeed.png"), filename: 'turtlefeed.png')
#https://www.amazon.ca/-/fr/Prevue-Products-verte-noire-SP1804-4/dp/B00SK7HOS6/ref=zg_bs_6291718011_24?_encoding=UTF8&psc=1&refRID=P4XMB2BV0821R0HV7AC9
@product = Product.create(category: "Cage", price: 131.80, title: "Cage de vol", description: "Cage verte adaptée pour les petits oiseaux.", quantity: 10, animal_type: "Oiseaux")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/cagevolpetit.png"), filename: 'cagevolpetit.png')
#https://www.amazon.ca/-/fr/HAMMER-Liti%C3%A8re-double-r%C3%A9sistante-contr%C3%B4le/dp/B01MFF2ZAH/ref=lp_6291972011_1_1?th=1
@product = Product.create(category: "Accessoire et Hygiène", price: 18.98, title: "Litière à chat", description: "Élimine à la fois les odeurs d'urine et d'excréments sur le contact.", quantity: 10, animal_type: "Chats")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/litiere.png"), filename: 'litiere.png')
#https://www.amazon.ca/-/fr/Living-60888-transport-animal-compagnie/dp/B006JVPL8A?ref_=Oct_s9_apbd_otopr_hd_bw_b6rr22F&pf_rd_r=APECRY9T4G3T06B5XYFK&pf_rd_p=07a4b9b1-fe81-5631-890f-94876d733f70&pf_rd_s=merchandised-search-10&pf_rd_t=BROWSE&pf_rd_i=6292582011
@product = Product.create(category: "Transport", price: 14.97, title: "Mini pet voyageur", description: "Idéal pour tous les petits animaux.", quantity: 10, animal_type: "Petits Animaux")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/transportpetitanimaux.png"), filename: 'transportpetitanimaux.png')
#https://www.amazon.ca/-/fr/Living-World-Lot-2-bonbons/dp/B0002DH2YW/ref=sr_1_4?dchild=1&qid=1613658721&s=pet-supplies&sr=1-4
@product = Product.create(category: "Accessoire et Hygiène", price: 4.79, title: "Os de Seiche", description: "Parfait et nécessaire pour la santé des os de votre oiseau.", quantity: 10, animal_type: "Oiseaux")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/osdeseiche.png"), filename: 'osdeseiche.png')
#https://www.amazon.ca/-/fr/Omega-Tricky-Treat-English-Manual/dp/B0002DK26M/ref=sr_1_7?dchild=1&qid=1613658774&s=pet-supplies&sr=1-7
@product = Product.create(category: "Jouet", price: 8.97, title: "Balle", description: "Balle jaune-orange pour amuser votre chien sans effort.", quantity: 10, animal_type: "Chiens")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/balchien.png"), filename: 'balchien.png')
#https://www.amazon.ca/-/fr/IAMS-ProACTIVE-Health-Nourriture-poulet/dp/B01DVVEU9G/ref=sr_1_24?dchild=1&qid=1613658844&s=pet-supplies&sr=1-24
@product = Product.create(category: "Nourriture", price: 19.48, title: "Nourriture sèche pour chat", description: "Alimentation saine et complète pour votre chat, contient aussi de la dinde.", quantity: 10, animal_type: "Chats")
@product.picture.attach(io: File.open(Rails.root + "app/assets/images/nourriturechat.png"), filename: 'nourriturechat.png')

command1 = Command.create(id: 28, sub_total: 0.221848e4, tps: 0.11092e3, tvq: 0.22185e3, total: 0.255125e4, store_pickup: false, state: "Payé", shipping_adress: "2-1903 rue Saint-Jacques,Shawinigan,Québec,G9N4A7", user_id: 2, created_at: "2021-02-26 08:47:53.809526000 +0000", updated_at: "2021-02-26 08:47:53.809526000 +0000")
cp1 = CommandProduct.create(id: 55, quantity: 4, total_price: 0.7592e2, unit_price: 0.1898e2, product_id: 11, command_id: 28, created_at: "2021-02-26 08:47:53.837369000 +0000", updated_at: "2021-02-26 08:47:53.837369000 +0000")
cp2 = CommandProduct.create(id: 56, quantity: 7, total_price: 0.146993e4, unit_price: 0.20999e3, product_id: 4, command_id: 28, created_at: "2021-02-26 08:47:53.851786000 +0000", updated_at: "2021-02-26 08:47:53.851786000 +0000")
cp3 = CommandProduct.create(id: 57, quantity: 1, total_price: 0.33257e3, unit_price: 0.33257e3, product_id: 7, command_id: 28, created_at: "2021-02-26 08:47:53.868925000 +0000", updated_at: "2021-02-26 08:47:53.868925000 +0000")
cp4 = CommandProduct.create(id: 58, quantity: 1, total_price: 0.749e1, unit_price: 0.749e1, product_id: 2, command_id: 28, created_at: "2021-02-26 08:47:53.885246000 +0000", updated_at: "2021-02-26 08:47:53.885246000 +0000")
cp5 = CommandProduct.create(id: 59, quantity: 1, total_price: 0.33257e3, unit_price: 0.33257e3, product_id: 7, command_id: 28, created_at: "2021-02-26 08:47:53.907518000 +0000", updated_at: "2021-02-26 08:47:53.907518000 +0000")

command2 = Command.create(id: 17, sub_total: 0.154585e4, tps: 0.7729e2, tvq: 0.15459e3, total: 0.177773e4, store_pickup: false, state: "Payé", shipping_adress: "2-1903 rue Saint-Jacques,Shawinigan,Québec,G9N4A7", user_id: 2, created_at: "2021-02-25 21:49:18.675352000 +0000", updated_at: "2021-02-25 21:49:18.675352000 +0000")
cp6 = CommandProduct.create(id: 13, quantity: 4, total_price: 0.7592e2, unit_price: 0.1898e2, product_id: 11, command_id: 17, created_at: "2021-02-25 21:49:18.692429000 +0000", updated_at: "2021-02-25 21:49:18.692429000 +0000")
cp7 = CommandProduct.create(id: 14, quantity: 7, total_price: 0.146993e4, unit_price: 0.20999e3, product_id: 4, command_id: 17, created_at: "2021-02-25 21:49:18.811428000 +0000", updated_at: "2021-02-25 21:49:18.811428000 +0000")
commmand3 = Command.create(id: 29, sub_total: 0.3498e2, tps: 0.175e1, tvq: 0.35e1, total: 0.4023e2, store_pickup: false, state: "Payé", shipping_adress: "2-1903 rue Saint-Jacques,Shawinigan,Québec,G9N4A7", user_id: 2, created_at: "2021-02-26 09:03:53.941476000 +0000", updated_at: "2021-02-26 09:03:53.941476000 +0000")
cp8 = CommandProduct.create(id: 60, quantity: 1, total_price: 0.1799e2, unit_price: 0.1799e2, product_id: 8, command_id: 29, created_at: "2021-02-26 09:03:53.957263000 +0000", updated_at: "2021-02-26 09:03:53.957263000 +0000")
cp9 = CommandProduct.create(id: 61, quantity: 1, total_price: 0.1699e2, unit_price: 0.1699e2, product_id: 3, command_id: 29, created_at: "2021-02-26 09:03:53.972044000 +0000", updated_at: "2021-02-26 09:03:53.972044000 +0000")
#conversations
conversation1 = Conversation.create(title: "Où est ma commande?", description: "J'aimerais savoir ce qu'il se passe avec ma commande", status: "En cours", created_at:"2021-03-09 07:46:29.308824000 +0000", updated_at: "2021-03-09 07:46:29.308824000 +0000", user_id: 2)
conversation2 = Conversation.create(title: "Nourriture pour crocodile", description: "J'aimerais pouvoir nourrir mon animal", status: "En cours", created_at:"2021-02-08 07:46:29.308824000 +0000", updated_at: "2021-02-08 07:46:29.308824000 +0000", user_id: 3)
conversation3 = Conversation.create(title: "Besoin d'un conseille", description: "Je ne sais pas quoi faire", status: "En cours", created_at:"2021-02-23 07:46:29.308824000 +0000", updated_at: "2021-02-23 07:46:29.308824000 +0000", user_id: 4)
conversation4 = Conversation.create(title: "La litière pue beaucoup", description: "Ça pue beaucoup", status: "En cours", created_at:"2021-02-27 07:46:29.308824000 +0000", updated_at: "2021-02-27 07:46:29.308824000 +0000", user_id: 5)

#message
@message = Message.create(body: "Allo, j'ai passé une commande récemment et j'aimerais savoir si je vais bientôt la recevoir", user_id: 2, conversation_id: 1);
@message = Message.create(body: "Allo M. Bernard, puis-je avoir le numéro de votre commande?", user_id: 1, conversation_id: 1);
@message = Message.create(body: "Oui avec plaisir. Mon numéro de commande est le 28", user_id: 2, conversation_id: 1);
@message = Message.create(body: "Parfait je vous reviens avec cela bientôt", user_id: 1, conversation_id: 1);

@message = Message.create(body: "Allo, pensez-vous un jour avoir de la nourriture pour crocrodile?", user_id: 3, conversation_id: 2);
@message = Message.create(body: "Allo M. Veillette, je ne crois pas que nous allions un jour en avoir", user_id: 1, conversation_id: 2);
@message = Message.create(body: "Vous devriez probablement lui donner du steak crue", user_id: 1, conversation_id: 2);
@message = Message.create(body: "J'ai essayé, mais je crois qu'il est végétarien...", user_id: 3, conversation_id: 2);
@message = Message.create(body: "Ah bon, c'est bien la première fois que j'entend ça. Malheureusement je ne peux pas vous aidez plus que cela.
    Vous devriez peut-être aller voir un vétérinaire pour de meilleur conseille.", user_id: 1, conversation_id: 2);
@message = Message.create(body: "Je vais faire ça. Merci.", user_id: 3, conversation_id: 2);
@message = Message.create(body: "Ça ma fait plaisir de vous aider", user_id: 1, conversation_id: 2);

@message = Message.create(body: "Allo, j'aurais besoin d'un conseil", user_id: 4, conversation_id: 3);

@message = Message.create(body: "Allo j'ai un problème avec ma litière", user_id: 5, conversation_id: 4);
@message = Message.create(body: "Bonjour, je suis désolé d'entendre ça", user_id: 1, conversation_id: 4);
@message = Message.create(body: "Vous avez combien de chat? Et à quel rythme faites vous la litière?", user_id: 1, conversation_id: 4);
@message = Message.create(body: "J'ai 4 chats et je la fais au semaine", user_id: 5, conversation_id: 4);
@message = Message.create(body: "Dans un cas comme le votre il est conseillé de la faire à tous les jours et même il est conseillé d'avoir au minimum une litière pour 2 chats.
     Donc, dans votre cas, vous devriez avoir 2 litières", user_id: 1, conversation_id: 4);
@message = Message.create(body: "ok merci du conseille", user_id: 5, conversation_id: 4);
@message = Message.create(body: "Ça ma fait plaisir de vous aider", user_id: 1, conversation_id: 4);

conversation4.update(status: "Terminer");

#cart
@cart = Cart.create!(sub_total: 887.29, user_id: 1)
@cart = Cart.create!(sub_total: 1545.85, user_id: 2)


@cart_product = CartProduct.create(total_price: 790.80, quantity: 6, cart_id: 1, product_id: 10, created_at: "2020-02-05 07:46:29.308824000 +0000")
@cart_product = CartProduct.create(total_price: 33.53, quantity: 7, cart_id: 1, product_id: 13, created_at: "2021-02-05 07:46:29.308824000 +0000")
@cart_product = CartProduct.create(total_price: 53.99, quantity: 1, cart_id: 1, product_id: 6)
@cart_product = CartProduct.create(total_price: 8.97, quantity: 1, cart_id: 1, product_id: 14)
@cart_product = CartProduct.create(total_price: 75.92, quantity: 4, cart_id: 2, product_id: 11)
@cart_product = CartProduct.create(total_price: 1469.93, quantity: 7, cart_id: 2, product_id: 4)
@taxes = CurrentTax.create(tps:0.05, tvq:0.09975)