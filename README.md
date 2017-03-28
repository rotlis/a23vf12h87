# BBL

#### Toolset

* esplorer
* esptool
* https://www.npmjs.com/package/nodemcu-tool
* node-red
* bower

Node/Npm/PM2/Node-red installation
  brew install node
  brew install npm
  npm install pm2@latest -g
  npm install -g --unsafe-perm node-red node-red-admin

node-red modules to install

    http://flows.nodered.org/node/node-red-contrib-splitter
    http://flows.nodered.org/node/json-db-node-red
    https://www.npmjs.com/package/node-red-contrib-file-function

MQTT broker

    Install mosquitto mqtt broker by following https://mosquitto.org/download/
    apt-get install mosquitto
    apt-get install mosquitto_clients

#### Generate privatekey.pem and certificate.pem on new server and use them in TLS configuration

    openssl genrsa -out privatekey.pem 1024
    openssl req -new -key privatekey.pem -out private-csr.pem
    openssl x509 -req -days 365 -in private-csr.pem -signkey privatekey.pem -out certificate.pem

#### How to Start/setup 
    1- Navigate to the the project directory
    2- execute 'pm2 start /usr/local/bin/node-red --name better-build-lights -- -u .' to register the app
    3- Execute 'sudo pm2 startup' to make the pm2 start automatically whenever the machine reboots
    4- Execute 'pm2 save' to save the registered app
    5- Execute 'sudo pm2 list' to see the registered apps
    6- execute 'sudo pm2 logs better-build-lights' to check logs
    7- execute 'sudo pm2 stop better-build-lights' to stop the process
    8- execute 'sudo pm2 start better-build-lights' to start the process


#### NodeMcu build configuration

Use https://nodemcu-build.com/ ot build it yourself with Docker image

    CJSON, end user setup, file, GPIO, HTTP, mDNS, net, node, RTC mem, timer, net, node, wifi, WS2812

#### Flash the image to the device
 
    python esptool.py -p /dev/tty.wchusbserial1410 write_flash  --flash_mode dio -fs 32m \
    0x00000 _bbl_mqtt-2017-03-28-10-32-31-integer.bin \
    0x3fc000 esp_init_data_default.bin
