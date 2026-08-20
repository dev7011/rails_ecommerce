♦️source: https://www.youtube.com/watch?v=hURUMwdCWuI&t=3560s 

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
    rails generate devise:views
    rails generate devise:views  


♦️3. STEP DEVISE-MODEL GENERIEREN

    rails generate devise Admin
    rails db:migrate

♦️ 4. STEP Konfiguration von Devise 
    
    👉 in app/controllers/application_controller.rb
        before_action :authenticate_user!
    👉 in config/environments/development.rb
        config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
