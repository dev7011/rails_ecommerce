♦️1. Tailwind mit gem "tailwindcss-rails" ♦️

    👉 bundle add tailwindcss-rails
    👉 rails tailwindcss:install
    👉 rails tailwindcss:build

    👉 app/views/layouts/application.html.erb anpassen
        <%= stylesheet_link_tag "tailwind", "application", "data-turbo-track": "reload" %>
    👉 touch app/assets/tailwind/application.css

💄2. ACHTUNG: ♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️♦️ 
        bei clone oder Fehlern beim Starten von Rails, 
        kann es sein, dass die Tailwind CSS Datei nicht korrekt gebaut wurde
        ✋ Fehler mit <%= stylesheet_link_tag "tailwind", "data-turbo-track": "reload" %>

   👉 Führen Sie den Befehl aus:
        
        touch app/assets/tailwind/application.css 
        rm -rf tmp/cache
        rm -rf public/assets
        bin/rails assets:clobber
        bin/rails tailwindcss:build 
        
👍 3. Entwicklungsserver richtig starten:       
        
        bin/dev ♦️ watch tailwindcss-rails
        👉 Falls bin/dev nicht ausführbar ist:
                chmod +x bin/dev
