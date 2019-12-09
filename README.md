# day07 de la piscine Ruby/Rails de 42 Paris
le jour 07 de la piscine Ruby de 42 refait/day06 of the 42 swimming pool Ruby/rails  
  
## Salut à toi duoquadratain qui se retrouve tout seul à faire la piscine Ruby !  
  
  
### Tes meilleurs amis  
* les [railsguides](https://guides.rubyonrails.org/) pour des explications d'ensemble et la doc de l'[API](https://api.rubyonrails.org/) pour de la doc sur une méthode précise.  
  
Mais aussi:  
* Une très bonne adresse en français [grafikart](https://www.grafikart.fr/tutoriels/ruby-on-rails)  
* L'excellent [Rails tutorial](https://www.railstutorial.org/book) de Michael Hartl  
* [goRails](https://gorails.com/series), d'autant qu'avec le GitHub Student Pack, on bénéficie d'un abonnement d'un an gratos  
* Les vidéos de [RailsCast](http://railscasts.com/)  
* Et une toute nouvelle ressource (doc + code), très complète, [RubyGarage](https://rubygarage.github.io/)  
* ton cerveau, il peut servir...    
  
### Avant de coder, installons !  
Avant toute chose et tout code, il vous faut utiliser un gestionnaire de version de Ruby (et donc de Rails) [RVM](https://rvm.io/)
 et [rbenv](https://github.com/rbenv/rbenv#readme) étant les plus connus et utilisés, mais existe aussi chruby, uru, etc.  
  
Avec RVM, on installe la version de Ruby désirée, en regardant sur [site officel de Ruby](https://www.ruby-lang.org/en/downloads/releases/) 
les versions de Ruby (`rvm install 2.6.5` par exemple), créer un gemset (un environnement isolé) avec `rvm gemset create 
nom_du_gemset`, je nomme en général mes gemsets avec la version de Ruby@rails_version, par ex `rvm gemset create rails427`.  
Une fois le gemset créé, on rentre dedans/l'utilise avec `rvm 2.6.5@rails4.2.7` dans cet exemple et ensuite, seulement on 
installe rails avec la bonne version avec `gem install rails  -v 4.2.7 -no-ri -no-rdoc` sans la doc incluse 


outre le code de ce repo voici quelques pistes pour t'aider:  

## ex00  

Extrait de l'excellent ebook de Xavier Nayrac **Créer votre framework web en Ruby**
à acheter sur [leanpub](https://leanpub.com)  
  
>## 15 - La base de données Postgresql
>
>Avant de pouvoir déployer une application réalisée à l’aide de notre framework sur Heroku, nous devons apprendre à utiliser
> la base de données Postgresql. Pour la bonne raison qu’Heroku ne gère pas Sqlite.
>
>### Installation
>Pour l’installation sur Windows, téléchargez ce dont vous avez besoin sur le site web de Postgresql. Sur ce même site 
>il y a une section consacrée à OS X. Sur Linux vous devriez pouvoir utiliser votre gestionnaire de paquets, par exemple 
>sudo apt-get install postgresql, ou vous pouvez là aussi consulter le site web de Postgresql, section Linux.
>
>### Configuration
>La base de données Postgresql est pré configurée avec un utilisateur répondant au nom de postgres. Vous allez ajouter
> un nouvel utilisateur nommé framework avec lequel vous pourrez pratiquer tous les tests qu’ils vous plaira. Le programme
> en ligne de commande que nous allons utiliser pour gérer Postgresql est psql. Vous verrez qu’il ressemble assez à sqlite3,
> vous ne serez pas perdu. Tout d’abord vous allez empruntez l’identité de l’utilisateur postgres pour vous connecter.
>
>Connectez vous comme si vous étiez postgres  
>```bash
>    $ sudo -u postgres psql  
>    psql (9.5.6)  
>    Type "help" for help.  
>    postgres=# 
>```
>La commande `sudo -u nom commande` permet de lancer le programme commande comme si vous étiez l’utilisateur nom.
>
>Une fois connecté, vous pouvez créer un nouvel utilisateur. Ici je crée un utilisateur ayant pour nom framework et pour 
>mot de passe bonjour :
>
>### Création d’un utilisateur  
>```postgresql
>    postgres=# create user framework password 'bonjour';
>```
>
>Maintenant que l’utilisateur est créé, nous allons lui fournir des droits. Et même 
>beaucoup de droit pour être tranquille pour la suite. Nous ne sommes pas entrain 
>d’administrer des serveurs d’entreprises où il faut rester prudent sur qui peut 
>faire quoi. Nous sommes entrain de configurer une machine de développement pour 
>tester une nouvelle base de données. Saisissez donc la commande suivante telle 
>quelle pour donner un maximum de droits à notre utilisateur :
>
>Beaucoup de droits:  
>```postgresql
>postgres=# alter user framework with superuser;  
>```
>### Création de la base de données  
>Avec Sqlite il fallait simplement créer un nouveau fichier pour obtenir une nouvelle base de données. Avec Postgresql 
>nous devons utiliser le langage SQL. Nous créons une base de donnée nommée framework_blog et nous spécifions qu’elle 
>appartient à l’utilisateur framework.  
>
>#### Création d’une base de données  
>```postgresql
>postgres=# create database framework_blog owner framework;
>```
>Vous pouvez lister toutes les bases de données avec la commande \l. Vous devriez voir apparaitre celle que vous venez de 
>créer à l’instant. (J’ai supprimé plusieurs lignes et colonnes dans la sortie suivant pour qu’elle tienne sur une page)
>
>Lister les bases  
>```postgresql
>postgres=# \l
>                          List of databases  
>     Name       |    Owner  | Encoding |      Access privileges      
>----------------+-----------+----------+-------------------------  
> xxx            | xavier    | UTF8     |                           
> xxx            | xavier    | UTF8     |                           
> ...  
> framework_blog | framework | UTF8     | =Tc/framework          +  
>                |           |          | framework=CTc/framework  
>```  
>
>Avant de poursuivre nous devons nous connecter à la base de données framework_blog. Pour ce faire nous utilisons la 
>commande `\c nom_de_la_base`  
>
>### Connexion à la base framework_blog  
>```postgresql
> postgres=# \c framework_blog 
> You are now connected to database "framework_blog" as user "postgres".
> framework_blog=#  
>```
> Vous remarquerez comme le prompt a changé. À tout moment vous pouvez demander à quelle base vous êtes connecté et avec
> quel utilisateur en utilisant la commande `\c` sans arguments :
> 
> Voir la connexion actuelle
>```postgresql
> framework_blog=# \c  
> You are now connected to database "framework_blog" as user "postgres".  
> ```  
>### Création de la table posts  
>
> Contrairement à Sqlite, Postgresql possède une foultitude de type de données. Vous les trouverez sur le site de Postgresql. 
Pour la colonne id nous utiliserons le type serial et pour la date nous pourrons utiliser le type timestamp. Quant aux colonnes
 title et content elles restent inchangées. Saisissez la commande suivante dans psql.  
> 
>### Création d’une table  
>```postgresql
>     create table posts(
>        id serial primary key,
>        title text,
>        content text,
>        date timestamp
>    );  
 >```
> Le type serial n’est pas vraiment un type. C’est plutôt un raccourci pour dire qu’on veut un entier qui soit auto incrémenté.
> 
> Vous pouvez maintenant créer deux ou trois posts. Pour entrer la date courante vous avez deux possibilités, soit now(),
> soit current_timestamp. Voici un exemple de chaque :
> 
>### Création de deux posts  
>```postgresql
>     insert into posts(title, content, date)
>      values('Bonjour !', 'Premier post avec Postgresql', now());
>     
>     insert into posts(title, content, date)
>      values('Hello !', 'In english this time', current_timestamp);  
>```  
> Vous pouvez bien sûr afficher le contenu de la table posts pour vous assurer que tout s’est bien déroulé.
> 
> Afficher les posts dans Postgresql
>```postgresql
> framework_blog=# select * from posts;
>  id |   title   |           content            |            date            
> ----+-----------+------------------------------+----------------------------
>   1 | Bonjour ! | Premier post avec Postgresql | 2017-04-12 10:18:09.367729
>   2 | Hello !   | In english this time         | 2017-04-12 10:19:09.474741
> (2 rows)  
>```  
> Finalement vous pouvez quitter psql avec le raccourci Ctrl+d, ou bien en saisissant la commande `\q`.
> 
>### Utiliser Postgresql dans notre framework  
> Pour être capable d’utiliser Postgresql avec notre framework nous devons ajouter la gem pg dans le Gemfile, et retirer 
>la gem sqlite3. Votre Gemfile devrait ressembler à celui-ci :
> 
>#### Ajouter la gem pg au Gemfile  
>
>```ruby
>
> 1 source "https://rubygems.org/"
> 2 
> 3 gem 'rack', '~> 2.0.1'
> 4 gem 'puma'
> 5 gem 'sequel'
> 6 gem 'pg'
>```
> N’oubliez pas de faire un bundle…
> 
> Ça faisait longtemps qu’on avait pas fait un bundle…
>```bash
> $ bundle
> Resolving dependencies...
> Using pg 0.19.0
> Using puma 3.7.1
> Using rack 2.0.1
> Using sequel 4.43.0
> Using bundler 1.13.7
>``` 
> La chaîne de connexion dont a besoin Sequel pour se connecter à une base de données Postgresql est de la forme suivante :
>  
> `postgres://utilisateur:mot_de_passe@serveur:port/nom_de_la_base`  
  
autre doc pour la configuration sur Linux ([fedora](https://doc.fedora-fr.org/wiki/Installation_et_configuration_de_PostgreSQL))

>###2 Installation de PostgreSQL
>#### 2.1 Installation
> L'installation du serveur de base de données se fera par dnf, le gestionnaire de paquets de Fedora. Voici la commande 
>à taper dans un terminal :
>```bash
># dnf install postgresql-server
>``` 
>   
>#### 2.2 Activation  
> Pour utiliser PostgreSQL, il vous faut avant tout faire une initialisation de la base de données, pour cela tapez cette 
>commande :
>```bash
># postgresql-setup initdb
>``` 
>   
> Si tout se passe bien vous avez pour réponse :
>   
> base de données : [ ok ]  
> Ensuite, il est nécessaire de démarrer le service :
>```bash
># systemctl start postgresql.service
>``` 
> 
> Afin de s'assurer que le service est bien démarré sans erreur, son état peut être consulté :
>```bash
># systemctl status postgresql.service
>``` 
> 
> Si vous souhaitez que son lancement soit automatique lors du démarrage de la machine :
>```bash
># systemctl enable postgresql.service
>``` 
>  
>#### 2.3 L'utilisateur postgres  
>>#####    L'utilisateur postgres  
>> Dès le départ, PostgreSQL crée un utilisateur nommé postgres.
>> Cet utilisateur est le super-utilisateur (l'équivalent de root sur votre système) du serveur de base de donnée.
> 
> Par mesure de sécurité, il est impératif d'affecter un mot de passe chiffré à cet utilisateur :
>```bash
># su - postgres
>``` 
> 
> 
> Désormais vous êtes en tant qu'utilisateur postgres, ensuite tapez :  
>```bash
>$ psql
>```
> Pour résultat vous devriez avoir ceci :
>```postgresql
> could not change directory to "/root"
> Welcome to psql 10.6.1, the PostgreSQL interactive terminal.
> Type:  \copyright for distribution terms
>        \h for help with SQL commands
>        \? for help with psql commands
>        \g or terminate with semicolon to execute query
>        \q to quit
> postgres=# 
>``` 
> 
> 
>>A noter
>> Le # indique bien que vous utilisez un super-utilisateur du serveur de base de donnée PostgreSQL.  
>
> C'est le moment de lui attribuer un mot de passe, <mot_de_passe> est à remplacer par le mot passe de votre choix, pour
> cela tapez :  
>```postgresql
># ALTER USER postgres WITH PASSWORD '<mot_de_passe>';
>``` 
>  
>#### 2.4 Sécurisation
> La sécurité, lorsque l'on a une base de données sur le réseau, c'est un point crucial.
> En effet, il est tout à fait possible de chiffrer les mots de passes des utilisateurs du serveur de base de données.
> 
> Pour cela, il faut éditer le fichier `/var/lib/pgsql/pg_hba.conf` en tant qu'utilisateur root et modifier le fichier en
> remplaçant `ident sameuser` par `md5` afin d'obtenir les lignes suivantes :
> 
>
>```editorconfig
> # "local" is for Unix domain socket connections only
> local   all         all                               md5
> # IPv4 local connections:
> host    all         all         127.0.0.1/32          md5
> # IPv6 local connections:
> host    all         all         ::1/128               md5
>```
> Pour que les modifications prennent effet il faut redémarrer le serveur :
>  
>```bash
># systemctl restart postgresql.service
>``` 
> 
> De plus amples informations sur la sécurisation d'une base de données PostgreSQL sont disponibles dans le documentation
> du serveur.
> 
>#### 2.5 Création d'un utilisateur
>##### 2.5.1 À la main  
> Il est recommandé de ne pas utiliser le super utilisateur postgres pour lire et écrire dans vos base de données.
> Pour cela, il est intéressant de créer un utilisateur dédié :
>```bash
> # su - postgres
> $ psql
>``` 
> 
>
> Pour créer l'utilisateur, tapez (<mon_user> est à changer par un nom d'utilisateur de votre choix) :
>```postgresql
># CREATE USER <mon_user>;
>``` 
> 
> 
> Pour lui donner le droit de créer des bases de données, tapez ceci (<mon_user> est à changer par le nom d'utilisateur 
>choisi au préalable) :
>```postgresql
># ALTER ROLE <mon_user> WITH CREATEDB;
>``` 
> 
> 
> Il est vivement conseillé d'attribuer un mot de passe pour votre nouvel utilisateur (<mon_user> est à changer par le nom 
>d'utilisateur choisi au préalable, <password> est à changer par le mot de passe correspondant) :
>```postgresql
> # ALTER USER <mon_user> WITH ENCRYPTED PASSWORD '<password>';
>``` 
> 
>
> Ensuite, créez la base de donnée de l'utilisateur (<mon_user> est à changer par le nom d'utilisateur choisi au préalable) :
>```postgresql
># CREATE DATABASE <mon_user>;
>``` 
>>Utilisateur virtuel éponyme
>> Si l'utilisateur virtuel que vous venez de créer porte le même nom que votre utilisateur système, il est possible 
>>d'utiliser l'interface psql depuis celui-ci.
>> Remarquez tout de même le changement du signe de l'invite de commande qui devient alors >, cela signifie bien que vous
>> n'êtes plus en utilisateur root.
  
  
Après ces extraits de doc, voici pour Mac  
```bash
brew update
brew install postgresql
#==> Caveats
#If builds of PostgreSQL 9 are failing and you have version 8.x installed,
#you may need to remove the previous version first. See:
#  https://github.com/Homebrew/homebrew/issues/2510
#
#To migrate existing data from a previous major version (pre-9.0) of PostgreSQL, see:
#  https://www.postgresql.org/docs/9.6/static/upgrading.html
#
#To migrate existing data from a previous minor version (9.0-9.5) of PostgreSQL, see:
#  https://www.postgresql.org/docs/9.6/static/pgupgrade.html

#  You will need your previous PostgreSQL installation from brew to perform `pg_upgrade`.
#  Do not run `brew cleanup postgresql` until you have performed the migration.
#
#To have launchd start postgresql now and restart at login:
#  brew services start postgresql
#Or, if you don't want/need a background service you can just run:
#  pg_ctl -D /Users/pcadiot/.brew/var/postgres start
pg_ctl -D /Users/pcadiot/.brew/var/postgres start
cd ex00
rvm 2.3.4
rvm gemset create rails4.2.7
rvm 2.3.4@rails4.2.7
gem install rails -v 4.2.7
bundle update
# createdb d07
rails new acme -d postgresql
cd acme
cp -f ~/Downloads/gemfile .
rake db:create  
```  
  
En cas de problème de connexion, vérifier le fichier pg_hba.conf, en remplaçant sur les lignes `local` et `host` les `ident`
par `md5` ou mieux `scram-sha-256`  en oubliant pas de relancer postgres après avoir sauvegardé les modifications sur ce 
fichier.  

## ex01  
  
  Ha [**Devise**](http://devise.plataformatec.com.br/)
```bash
rails g devise:install  # Permet de générer la configuration
rails g devise:views    # Permet d'importer les vues
rails g devise User     # Permet de générer le model et les migrations pour le model User
```  
Après la première commande, devise vous affiche ceci:  
    
> Some setup you must do manually if you haven't yet:
>  
>    1. Ensure you have defined default url options in your environments files. Here
>       is an example of default_url_options appropriate for a development environment
>       in config/environments/development.rb:
>```ruby
>config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
>```  
>    In production, :host should be set to the actual host of your application.
>  
>    2. Ensure you have defined root_url to *something* in your config/routes.rb.
>       For example:
>```ruby
>root to: "home#index"
>```  
>         
>  
>    3. Ensure you have flash messages in app/views/layouts/application.html.erb.
>       For example:
>  
>```html+erb
><p class="notice"><%= notice %></p>
><p class="alert"><%= alert %></p>
>```         
>    
>    4. You can copy Devise views (for customization) to your app by running:
>```bash
>rails g devise:views
>```  
>         
>  

##### Erreurs possibles  
- Lors de `rails generate devise:install` cette erreur:
 >`in `<top (required)>': undefined method `to_time_preserves_timezone=' for ActiveSupport:Module (NoMethodError)`   
  
 Commentez la ligne 10 dans acme/config/initializers/to_time_preserves_timezone.rb, cette erreur survient si votre version 
 de Ruby est inférieure à la 2.4

- Lorsque vous faites votre `rails generate devise user` et malgré la présence dans votre Gemfile de la gem pg
 >`in `rescue in spec': Specified 'postgresql' for database adapter, but the gem is not loaded. Add `gem 'pg'` to your  
 >Gemfile (and ensure its version is at the minimum required by ActiveRecord). (Gem::LoadError)`  

 rajoutez dans le Gemfile une version compatible, la 0.21 par exemple
 ```ruby
 # extrait du Gemfile
 gem 'pg', '~> 0.21' 
 ```
 Puis faite un `bundle update`
 
Pour les validations, vous pouvez rajouter dans le `app\models\user.rb`
```ruby
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :name, presence: true, on: :create
  validates :email, presence: true, on: :create
```

Pour les strong_parameters, il faut rajouter dans `application_controller.rb`  (comme indiqué dans la 
[doc de devise](http://devise.plataformatec.com.br/#configuring-controllers) )
```ruby
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end
```
Et bien-sur il vous faut modifier la migration créée par Devise en rajoutant le nom et la biography  
```ruby
# à rajouter dans acme/app/db/migrate/xxxxxxxx_devise_create_user.rb
      t.string :name, null: false, default: ''
      t.text :bio, default: '' 
```
et pareil, rajouter ces deux champs dans les vues `views/devise/registrations/new.html.erb` et `edit.html.erb`  
```html+erb
  <div class="field">
    <%= f.label :name %><br />
    <%= f.text_field :name, autofocus: true, autocomplete: "name" %>
  </div>

  <div class="field">
    <%= f.label :email %><br />
    <%= f.email_field :email, autocomplete: "email" %>
  </div>

  <div class="field">
    <%= f.label :biography %><br />
    <%= f.text_area :bio %>
  </div>
```
Après ces opérations, le seed passe et les 2 Users stories sont satisfaites !

## ex02  
_Pour l'instant (ayant déjà un compte gratuit Cloudinary et ne voulant pas l'épuiser avec les 5000 du seed), je ne travaille
qu'en local, on verra ça après !_ Mais **promis**, on va le faire !   
J'ai fait le choix d'avoir deux uploaders différents, un pour les avatars de Brand, l'autre pour les pict de Product. On 
va demander à Rails de faire (aussi) le café aussi, en scaffoldant comme des bêtes   

```shell script
rails generate uploader Avatar
rails generate uploader Pict
rails generate scaffold Brand name:string avatar:string
rails generate scaffold Product name:string description:text brand:references pict:string price:decimal
```
  
 on monte les uploaders dans les modèles, et on en profite pour écrire les associations
```ruby
class Brand
  has_many  :products
  mount_uploader :avatar, AvatarUploader
end
```
Comme la maison ne recule devant rien, on va faire des attributs imbriqués, des nested_attributes pour pouvoir éditer, 
depuis la page edit d'un Product, aussi le nom et l'avatar d'une marque (Brand)   
```ruby
class Product < ActiveRecord::Base
  belongs_to :brand
  accepts_nested_attributes_for :brand
  mount_uploader :pict, PictUploader
end
```
Puisqu'on utilise les `nested_attributes`, il faut modifier les `strong_parameters` dans le contrôleur des produits avec
`brand_attributes`, et, tant qu'on y est, on rajoute aussi la version cache de pict et d'avatar (qui sert à stocker en 
cache l'image téléchargée en cas de rafraîchissement ou de non validation de la page)    
```ruby
  # extrait de acme/controllers/products_controller.rb
  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:name, :description, :brand_id, :pict, :price,
                                    :brand, # ça je ne sais pas pourquoi rails me l'a demandée
                                    :pict_cache, #le cache de pict, qui l'eût cru !                              
                                    brand_attributes: %i[name avatar avatar_cache])
  end
```
_ceci (minimagik et imageMagik) ne concerne que le stockage des images en local_
Pour pouvoir bénéficier de `resize_to_fit` on doit décommenter dans les Uploaders les lignes 
`include CarrierWave::MiniMagick` et `  version :thumb do  
                                          process resize_to_fit: [50, 50]  
                                          end`  
Pour que MiniMagik fonctionne, il faut installer `ImageMagik` comme indiqué dans la doc de CarrierWave, avec 
`brew install imagemagick` sur MacOS ou votre gestionnaire de paquets sur Linux (`apt-get install` ou `dnf install` par 
ex.) **ET** modifier le Gemfile en rajoutant la gem minimagik  
```ruby
# ex01/acme/Gemfile (extrait à  rajouter)
gem 'mini_magick'
```                                     
```ruby
# ex02/acme/uploaders/avatar_uploader.rb
class AvatarUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # J'ai enlevé tout ce qui ne nous concerne pas

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [50, 50]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # ...
end
```
Pour que le `db/seeds.rb` passe, il faut rajouter un Array nommé price  
```ruby
# ex02/acme/db/seeds.rb (extrait)
price = [1.29, 4.00, 5.25, 7.75, 9.99, 10.00, 25.5, 49.99, 66.66, 74.99, 99.99]
50.times do |tm|
  mk = Brand.create!(name: FFaker::Product.brand,
                     avatar: open(FFaker::Avatar.image))

  50.times do |tw|
    Product.create!(name: FFaker::Product.product,
                    pict: open(FFaker::Avatar.image),
                    description: FFaker::HipsterIpsum.paragraph,
                    brand_id: mk.id, price: price.sample)
  end
end 
```

Dernière modif, pour que l'affichage des Products soit joli, on modifie 2 lignes, l'une pour afficher le nom de la marque
(Brand) et l'autre pour afficher la photo réduite, la miniature (thumb) de chaque Product  
```html+erb
<!-- # ex01/acme/views/products.html.erb (extrait) -->
<!--# avant : -->
         <td><%= product.brand %></td>
         <td><%= product.pict %></td>
<!--# après: -->
        <td><%= product.brand.name %></td>
        <td><%= image_tag product.pict_url(:thumb) unless product.pict.file.nil? %></td> 
```  
  
  
_Maintenant ocuppons-nous de Cloudinary !_  
  
  
1. l'identification  
chez moi, la méthode avec un fichier YAML, dans `config` n'a jamais voulu fonctionner !
```yaml
--- acme/config/cloudinary.yaml
development:
  cloud_name: dl1hwhz99
  api_key: <%= ENV["CLOUDINARY_API_KEY"] %>
  api_secret: <%= ENV["CLOUDINARY_API_SECRET"] %>
  enhance_image_tag: true
  static_file_support: false
production:
  cloud_name: dl1hwhz99
  api_key: <%= ENV["CLOUDINARY_API_KEY"] %>
  api_secret: <%= ENV["CLOUDINARY_API_SECRET"] %>
  enhance_image_tag: true
  static_file_support: true
test:
  cloud_name: dl1hwhz99
  api_key: <%= ENV["CLOUDINARY_API_KEY"] %>
  api_secret: <%= ENV["CLOUDINARY_API_SECRET"] %>
  enhance_image_tag: true
  static_file_support: false
```
Et non, petit malin, je ne vais pas vous montrer mes api_key et api_secret ! J'utilise des variables d'environnement. Pour
les utiliser, soit vous les mettez dans votre .bashrc ou .zshrc, puis un petit coup de `source ~/.zshrc`
```shell script
export CLOUDINARY_API_SECRET=MaisSiCestMaVeritableCle
export CLOUDINARY_API_KEY=12345678913345
```
ou vous lancez vos commandes ainsi (mais les variables ne seront conservées que durant la session)
```shell script
CLOUDINARY_API_SECRET=MaisSiCestMaVeritableCle
CLOUDINARY_API_KEY=12345678913345
rake db:migrate
rails server
```
Bon, revenons à nos moutons électriques, puisque cette méthode (avec le fichier cloudinary.yml) ne fonctionnait pas, j'ai
utilisé l'autre façon, en créant un fichier `acme/config/initializer/cloudinary.rb`  
```ruby
Cloudinary.config do |config|
  config.cloud_name = 'dl1hwhz99'
  config.api_key = (ENV['CLOUDINARY_API_KEY']).to_s
  config.api_secret = (ENV['CLOUDINARY_API_SECRET']).to_s
  config.enhance_image_tag = true
  config.secure = true
  config.cdn_subdomain = true
end
```
Si cette façon fonctionne, on remarquera qu'elle est moins souple quant à la définition de diférents environnements (dev, 
prod, test).  
Pour les utilisateurs de Rubymine, il faut éditer la configuration, dans la **Toolbar**, en principe juste sous la barre
des menus, clique sur le petit triangle tête en bas, **Edit Configurations...** et vous aurez alors, dans la boîte de 
dialogues venant de s'ouvrir, une ligne pour les variables d'environnement, avec, tout à fait à droite de cette ligne, une
petite icône grisée rectangulaire de liste permettant d'entrer les variables sous forem de tableaux  

2. les modifications des uploaders  


On va effacer la grande majorité de ce qu'on avait fait avant, quand on travaillait sans Cloudinary, en local !  
```ruby
class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def public_id
    return 'acme/' + model.name
  end

  # Create different versions of your uploaded files:
  version :thumb do
    eager
    process resize_to_fit: [50, 50]
  end
end
```
On inclut bien-sûr le module `Cloudinary::CarrierWave`, on rajoute `eager` dans `version :thumb` (c'est facultatif, ça 
permet de forcer le traitement à l'upload des fichiers, sans ça, la création des miniatures se ferait lors des requêtes 
du navigateur lors de l'affichage de la page) et on ajoute une méthode `public_id` afin de créer un identifiant unique 
pour chaque fichier (le `'acme/' +` est lui aussi facultatif).  
Si, comme moi, vous avez créer deux uploaders, vous faites bien-sûr la même chose pour l'autre, PictUploader!  

3. Modification des form(ulaires)  

Déjà, dans mes vues `edit.html.erb`, j'ai remplacé le `<%= render 'form' %>` par `<%= render 'form', brand: @brand %>` et 
donc, dans mes partials `_form.html.erb` je n'ai plus de variables d'instances précédées d'un @, que des variables locales  

```html+erb
<%= form_for product do |f| %>
  <% if product.errors.any? %>
    <div id="error_explanation">
      <h2><%= pluralize(product.errors.count, "error") %> prohibited this product from being saved:</h2>

      <ul>
      <% product.errors.full_messages.each do |message| %>
        <li><%= message %></li>
      <% end %>
      </ul>
    </div>
  <% end %>

  <div class="form-group field">
    <%= f.label :name %><br>
    <%= f.text_field :name %>
  </div>
  <div class="form-group field">
    <%= f.label :description %><br>
    <%= f.text_area :description %>
  </div>
  <div class="form-group field">
    <%= f.label :brand %><br>
    <%= f.text_field :brand_id %>
    <%= f.fields_for :brand, product.brand do |ff| %>
      <div class="form-group field">
      <%= ff.label :name %><br>
      <%= ff.text_field :name %>
      </div>
      <div class="form-group field">
      <%= ff.label :avatar %><br>
        <%= image_tag(product.brand.avatar_url) unless product.brand.avatar.file.nil? %>
        <%= ff.hidden_field :avatar_cache %><br>
      <%= ff.file_field :avatar %>
      </div>
    <% end %>
  </div>
  <div class="form-group field">
    <%= f.label :pict %><br>
    <%= image_tag(product.pict_url) unless product.pict.file.nil? %>
    <%= f.hidden_field :pict_cache %><br>
    <%= f.file_field :pict %>
  </div>
  <div class="form-group field">
    <%= f.label :price %><br>
    <%= f.text_field :price %>
  </div>
  <div class="actions">
    <button>
      <%= f.submit %>
    </button>

  </div>
<% end %>
```

Pareil pour le form de brand, en plus simple puisque pas de **nested_attributes**  

4. Modification des `index.html.erb`  

exemple avec le products  

```html+erb
<p id="notice"><%= notice %></p>

<h1>Listing Products</h1>

<table>
  <thead>
    <tr>
      <th>Name</th>
      <th>Description</th>
      <th>Brand</th>
      <th>Pict</th>
      <th>Price</th>
      <th colspan="3"></th>
    </tr>
  </thead>

  <tbody>
    <% @products.each do |product| %>
      <tr>
        <td><%= product.name %></td>
        <td><%= product.description %></td>
        <td><%= product.brand.name %></td>
        <td><%= image_tag(product.pict_url(:thumb)) unless product.pict.file.nil? %></td>
        <td><%= product.price %></td>
        <td><%= link_to 'Show', product, class: 'btn btn-xs btn-primary' %></td>
        <td><%= link_to 'Edit', edit_product_path(product), class: 'btn btn-xs btn-primary' %></td>
        <td><%= link_to 'Destroy', product, method: :delete, class: 'btn btn-xs btn-danger', data: { confirm: 'Are you sure?' } %></td>
      </tr>
    <% end %>
  </tbody>
</table>

<br>

<%= button_to 'New Product', new_product_path, class: 'btn btn-primary' %>
<%= link_to 'Brands', brands_path, class: 'btn btn-primary' %>

```
On remarquera, pour faire zoli (!), l'utilisation de classes CSS de Bootstrap sur les 
`link_to 'Titre', chemin, , class: 'btn btn-xs btn-primary'` ou `btn-danger` pour l'action delete, `btn-xs` bouton eXtra 
Small pour avoir de petits boutons !  
Petit rappel: `link_to` déclenche par défaut un `GET`, alors que `button_to` est associé par défaut à `POST`  

5. Modification des `show.html.erb`  

Bon, maintenant, vous pouvez le faire tout seul !  

## ex03
  
Mes références: le livre `Agile Web Development with Rails` et un site web en français [Hackademy Rails gestion du panier](https://hackademy.io/tutoriel-videos/rails-07-gestion-du-panier)
, [un article de Medium sur les Single Table Inheritance](https://medium.com/@dcordz/single-table-inheritance-using-rails-5-02-6738bdd5101a)
ou encore, cette série d'articles de blog sur les [Single Table Inheritance (STI)](https://devblast.com/b/single-table-inheritance-with-rails-4-part-1)  

Pourquoi de la doc sur les STI ? Car Cart et Order se ressemblent, vous ne trouvez pas ? De même que CartItem et OrderItem...  

On commence par créer deux migrations pour Cart et CartItem:
```shell script
rails g model Cart
rails g model CartItem product:references cart:belongs_to quantity:integer
rails g migration add_type_to_cart type:string 
rails g migration add_type_to_cart_items type:string 
```
>à noter que `belongs_to` est juste un alias de `references`  

On édite la seconde migration pour rajouter `default: 1` à quantity, et les deux dernières en rajoutant respectivement 
`default: 'Cart'` et `default: 'CartItem'` puis les modèles pour terminer les associations. Dans 
le modèle Cart, on rajoute `has_many :cart_items, dependent: :destroy` et on vérifie les associations pour CartItem:  

```ruby
class CartItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
end
```
Donc un premier concern pour les contrôleurs, nommé `recordable.rb` :
```ruby
# acme/controllers/concerns/recordable.rb
module Recordable
  extend ActiveSupport::Concern

  def add
    current_cart.add_item @product
    # puts '*****************************************************************'
    # puts "params: #{params}"
    # puts "je suis bien dans add avec (#{@product})"
    # puts "current_cart: #{current_cart.inspect}"
    # puts "cart_items: #{current_cart.cart_items.inspect}"
    # puts '*****************************************************************'

    # render partial: 'shared/panier', locals: { cart: current_cart } # , notice: 'Product was successfully added to cart.'
    redirect_to products_path, notice: 'Product was successfully added to cart.'
  end

  def remove
    current_cart.remove_item @product
    redirect_to products_path, notice: 'Product was successfully deleted from cart.'
  end

  def remove_all
    current_cart.remove_all
    redirect_to products_path, notice: 'Cart was successfully emptied.'
  end

  def checkout
    render partial: 'shared/checkout'
  end
end
```  
un second pour la `current_cart`:  
```ruby
module CurrentCart
  private

  def current_cart
    @cart = Cart.find_by(id: session[:cart_id]) || Cart.create
    session[:cart_id] ||= @cart.id
    @cart
  end
end
```
Bien entendu, on n'oublie pas de les inclure là où il faut, par exemple pour les contrôleurs
```ruby
class ProductsController < ApplicationController
  include Recordable
  include CurrentCart
  before_action :set_product, only: %i[show edit update destroy add remove]
  before_action :current_cart, only: %i[index add remove]
 #
 # etc
end 
```
Un autre pour les modèles, à inclure dans le modèle Cart:  
```ruby
# acme/models/concerns/add_item_concern.rb
module AddItemConcern
  def add_item(product)
    new_item = cart_items.find_by(product: product)
    if new_item
      new_item.quantity += 1
    else
      new_item = CartItem.new(product: product, cart_id: id)
    end
    new_item.save
  end

  def remove_item(product)
    new_item = cart_items.find_by(product: product)
    if new_item.quantity > 1
      new_item.quantity -= 1
      new_item.save
    else
      cart_items.delete new_item
    end
    cart_items
  end

  def remove_all
    cart_items.each do |cart_item|
      cart_items.delete cart_item
    end
  end
end
```

On n'oublie pas de créer les routes correspondantes :
```ruby
# extrait de acme/config/routes.rb
  resources :products do
    collection do
      post 'remove_all', to: 'products#remove_all', as: :remove_all_from_cart
    end

    member do
      post 'add', to: 'products#add', as: :add_to_cart
      post 'remove', to: 'products#remove', as: :remove_to_cart
    end
  end

  post 'checkout', to: 'products#checkout', as: '/checkout' 
```

Et on affiche tout ça, avec par exemple un partial, nommé, soyons fou, `_panier.html.erb`
```html+erb
<nav class="nav nav-nav nav-right">
  <span>
    <h3>
      PANIER DE
      <%= current_user.name.upcase if current_user %>
    </h3>
  </span>
  <table class="container-fluid">
  <thead>
    <tr>
      <th>Name</th>
      <th>Unit Price</th>
      <th>Quantity</th>
      <th>Price</th>
      <th colspan="2"></th>
    </tr>
  </thead>
    <tbody>
        <% unless current_cart.nil? && current_cart.cart_items.empty? %>
          <% current_cart.cart_items.each do |cart_item| %>
            <tr>
              <td><%= cart_item.product.name %></td>
              <td><%= cart_item.product.price %></td>
              <td><%= cart_item.quantity %></td>
              <td><%= cart_item.quantity * cart_item.product.price %></td>
              <td><%= button_to '+', add_to_cart_product_path(cart_item.product), class: 'btn btn-xs btn-primary' %></td>
              <td><%= button_to '-', remove_to_cart_product_path(cart_item.product), class: 'btn btn-xs btn-primary' %></td>
            </tr>
          <% end %>
      <% end %>
    </tbody>
  </table>
  <div class="btn-group btn-group-justified">
    <table>
      <tr>
        <th>
          <%= button_to "Vider le panier", remove_all_from_cart_products_path, data: {
              confirm: "Êtes-vous sûr ?" }, class: "btn btn-danger " %>
        </th>
        <th>
          <%= button_to 'Checkout', checkout_path, class: "btn btn-primary" %>
        </th>
      </tr>
    </table>
  </div>
</nav>
```

Sans oublier de rajouter une ligne dans la boucle each d'affichage de l'index des Product:
```html+erb
 <!-- extrait de acme/views/products/index.html.erb -->
  <tbody>
    <% @products.each do |product| %>
      <tr>
        <!-- etc -->
        <td><%= link_to 'Ajouter au panier', add_to_cart_product_path(product), method: :post, class: 'btn btn-xs btn-primary' %></td>
      </tr>
```

## ex04  

Bon, ben là, pas grand chose à faire, la gem est déjà dans le Gemfile, il suffit juste de décommenter 4 lignes dans 
`acme/config/initializers/rails_admin.rb`  

```ruby
# extrait de acme/config/initializers/rails_admin.rb 
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)
```
et de créer un lien vers le dashboard:  
```html+erb
      <!-- extrait de acme/app/views/shared/_navigation.html.erb -->
      <span>
        <%= link_to 'admin', rails_admin_path, class: 'btn btn-xs btn-primary' %>
      </span>
```  

J'ai rajouté dans config/routes.rb ceci, est-ce vraiment utile, à vous de le tester !
```ruby
  # extrait de acme/config/routes.rb
   mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
 
```

Et hop, le tour est joué !  
  
## ex05
[doc sur cancancan et rails_admin](https://github.com/sferik/rails_admin/wiki/CanCanCan)

```ruby
  # dans application_controller.rb
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, alert: exception.message
  end
```
