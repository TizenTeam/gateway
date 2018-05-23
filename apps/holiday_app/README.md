1. git clone -b devel/demo/0.4.0 https://github.com/ziransun/gateway
2. cd gateway
yarn

In gateway code at  src/models/oauthclients.ts, we have CLIENT_ID, CLIENT_SECRET set in corresponding to
the settings in app_server.js. e.g.

```
oauthClients.register(
   new ClientRegistry(new URL('http://127.0.0.1:31338/callback'), 'HollyHoliday',

                     'HolidayMaker OAuth Client', 'super secret', '/things:readwrite')
);

```

3. config gateway following UI and start gateway 
npm start 


Steps to set up the holiday app: 


1. cd apps/holiday_app

2. Install socket.io

npm install socket.io 


3. Please replace the gateway address in app_server.js to your own. 

4. start auth server   node ./app_server.js
5. Go to http://localhost:31338

enter username & password 
username: holidaymaker
password: secret

press "Get Token" button

Once token is granted, you will be directed to the sensor access page. Have fun! 

