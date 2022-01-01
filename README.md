# PWA-Greenhouse-App


This single page PWA (Progressive Web Application) shows user measurements from sensors that are in greenhouse. It has 2 users - User and Administrator.

User have pages - Live measurements - where user can read data from sensors in real time. (Data is read from ThingSpeaks platform via MQTT protocol) and Trend measurements 
where app show some custom choosen time measurements via Graphs (Chart.js). Data is read from ThingSpeaks platform via RESTful API. 

Administrator can manipulate with users.

App is mobile responsive.

Other functionalities are - Register, Login and  Reset Password (user get mail with steps how to reset password).


App uses Laravel as a backend, MySQL as a database and Vue.js as a frontend. 
