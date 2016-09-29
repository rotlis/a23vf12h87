# a23vf12h87




Toolset
esplorer
node-red modules to install

http://flows.nodered.org/node/node-red-contrib-splitter
http://flows.nodered.org/node/json-db-node-red


#### Generate privatekey.pem and certificate.pem on new server and use them in TLS configuration

openssl genrsa -out privatekey.pem 1024
openssl req -new -key privatekey.pem -out private-csr.pem
openssl x509 -req -days 365 -in private-csr.pem -signkey privatekey.pem -out certificate.pem

#### 



build configurations:

NodeMCU build configuration:
CJSON, end user setup, file, GPIO, HTTP, mDNS, net, node, RTC mem, timer, net, node, wifi, WS2812

python esptool.py -p /dev/tty.usbserial-A700eZt9 write_flash  --flash_mode dio -fs 32m 0x00000 _bbl_nodemcu-master-12-modules-2016-08-27-08-59-06-integer.bin 0x3fc000 esp_init_data_default.bin
