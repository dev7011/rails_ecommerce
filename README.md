♦️FONT-AWESOME-SASS INTEGRIEREN IN RAILS 7♦️

    gem "font-awesome-sass", "~> 6.5.1"
    bundle install
    
    👉  Datei app/assets/stylesheets/application.css in  app/assets/stylesheets/application.css.scss umbenennen und folgende Zeile hinzufügen:
        @import "font-awesome";
    bin/dev


♦️2. STEP DEVISE
    gem "devise", "~> 5.0"
    bundle install
    rails generate devise:install


