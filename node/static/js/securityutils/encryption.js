var key = context.global.key;
var crypto = context.global.crypto;
var encryptionAlgorithm = context.global.encryptionAlgorithm;

var credentials = msg.payload;
var encryptionKey = crypto.createHash('sha256').update(key).digest();
var initVector = crypto.randomBytes(16);
var cipher = crypto.createCipheriv(encryptionAlgorithm, encryptionKey, initVector);
var result = cipher.update(JSON.stringify(credentials), 'utf8', 'base64') + cipher.final('base64');
result = initVector.toString('hex') + result;
msg.payload = result;
return msg;