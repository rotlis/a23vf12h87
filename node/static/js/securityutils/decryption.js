var key = context.global.key;
var crypto = context.global.crypto;
var encryptionAlgorithm = context.global.encryptionAlgorithm;

var encryptedCredentials = msg.payload;
var encryptionKey = crypto.createHash('sha256').update(key).digest();
var initVector = new Buffer(encryptedCredentials.substring(0, 32),'hex');
encryptedCredentials = encryptedCredentials.substring(32);
var decipher = crypto.createDecipheriv(encryptionAlgorithm, encryptionKey, initVector);
var decrypted = decipher.update(encryptedCredentials, 'base64', 'utf8') + decipher.final('utf8');
msg.payload = JSON.parse(decrypted);
return msg;