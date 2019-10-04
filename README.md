Extrait de l'excellent ebook de Xavier Nayrac **Créer votre framework web en Ruby**
à acheter sur [leanpub](https://leanpub.com)  
  
>##15 - La base de données Postgresql
>
>Avant de pouvoir déployer une application réalisée à l’aide de notre framework sur Heroku, nous devons apprendre à utiliser
> la base de données Postgresql. Pour la bonne raison qu’Heroku ne gère pas Sqlite.
>
>###Installation
>Pour l’installation sur Windows, téléchargez ce dont vous avez besoin sur le site web de Postgresql. Sur ce même site 
>il y a une section consacrée à OS X. Sur Linux vous devriez pouvoir utiliser votre gestionnaire de paquets, par exemple 
>sudo apt-get install postgresql, ou vous pouvez là aussi consulter le site web de Postgresql, section Linux.
>
>###Configuration
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
>Une fois connecté, vous pouvez créer un nouvel utilisateur. Ici je crée un utilisateur ayant pour nom framework et pour mot de passe bonjour :
>
>###Création d’un utilisateur  
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
>###Création de la base de données  
>Avec Sqlite il fallait simplement créer un nouveau fichier pour obtenir une nouvelle base de données. Avec Postgresql 
>nous devons utiliser le langage SQL. Nous créons une base de donnée nommée framework_blog et nous spécifions qu’elle 
>appartient à l’utilisateur framework.  
>
>####Création d’une base de données  
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
>###Connexion à la base framework_blog  
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
  
