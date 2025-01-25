const currentDate = require('../util/current_date_time');
const { gzipSync } = require("zlib");


var methods = {

    GENERATING_RANDOM_STRING: function (length, hasDigits, hasSmallLetters, hasCapitalLetters, hasSymbols, logMsg) {
        logMsg += currentDate.CURRENT_DATE() + " : " + "GENERATING_RANDOM_STRING START" + "\n";
        var charsToGenerateString = "";
        if (hasDigits) {
            charsToGenerateString += "0123456789";
        }
        if (hasSmallLetters) {
            charsToGenerateString += "abcdefghijklmnopqrstuvwxyz";
        }
        if (hasCapitalLetters) {
            charsToGenerateString += "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        }
        if (hasSymbols) {
            charsToGenerateString += "!@#%?";
        }
        var result = '';
        for (var i = length; i > 0; --i) {
            result += charsToGenerateString[Math.floor(Math.random() * charsToGenerateString.length)];
        }
        logMsg += currentDate.CURRENT_DATE() + " : " + "GENERATING_RANDOM_STRING END" + "\n";
        return { code: 200, msg: result, logMsg: logMsg };
    },
    COMPRESS_JSON_USING_ZLIB: function (jsonData, logMsg) {
        logMsg += currentDate.CURRENT_DATE() + " : " + "COMPRESS_JSON_USING_ZLIB START" + "\n";
        var jsonString = JSON.stringify(jsonData);
        const gzip = gzipSync(jsonString);
        const base64String = gzip.toString('base64');
        logMsg += currentDate.CURRENT_DATE() + " : " + "COMPRESS_JSON_USING_ZLIB END" + "\n";
        return base64String;
    }
};


module.exports = methods;
