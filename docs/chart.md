npm i chart.js -d
bin/importmap pin chart.js
rails g stimulus Dashboard

Wenn error, dann importmap korrigieren mit  

pin "chart.js", to: "https://ga.jspm.io/npm:chart.js@4.5.1/dist/chart.js"
pin "@kurkle/color", to: "https://ga.jspm.io/npm:@kurkle/color@0.3.4/dist/color.esm.js"