const currentDate = require('../util/current_date_time');

var methods = {
    GET_PARAMS: async function (event, reqParams, logMsg) {
        return new Promise(resolve => {
            logMsg += currentDate.CURRENT_DATE() + " : " + 'GET_PARAMS START' + "\n";
            try {
                var responseData = [];
                if (!event.body) {
                    logMsg += currentDate.CURRENT_DATE() + " : " + '205 - GET_PARAMS END : Event Body Not Found : ' + JSON.stringify(event.body) + "\n";
                    resolve({ code: 205, msg: 'InSufficient Data', logMsg: logMsg });
                } else {
                    var data = JSON.parse(event.body);
                    var isDataPresent = true;
                    for (var i = 0; i < reqParams.length; i++) {
                        var item = reqParams[i];
                        if (data[item]) {
                            responseData.push(data[item]);
                        } else {
                            isDataPresent = false;
                        }
                    }
                    if (isDataPresent) {
                        logMsg += currentDate.CURRENT_DATE() + " : " + '200 - GET_PARAMS END' + "\n";
                        resolve({ code: 200, msg: responseData, logMsg: logMsg });
                    } else {
                        logMsg += currentDate.CURRENT_DATE() + " : " + '205 - GET_PARAMS ERROR: Required Params: ' + reqParams + ', Front End Params: ' + JSON.stringify(data) + "\n";
                        resolve({ code: 205, msg: 'InSufficient Data', logMsg: logMsg });
                    }
                }
            } catch (e) {
                logMsg += currentDate.CURRENT_DATE() + " : 201 - " + 'GET_PARAMS Error: Required Params: ' + reqParams + ', Front End Params: ' + JSON.stringify(data) + "\n";
                logMsg += currentDate.CURRENT_DATE() + " : 201 - " + 'GET_PARAMS Exception: ' + JSON.stringify(e) + "\n";
                resolve({ code: 201, msg: 'Invalid Data', logMsg: logMsg });
            }
        });
    },
    GET_NON_MANDATORY_PARAMS: async function (event, reqParams, logMsg) {
        return new Promise(resolve => {
            logMsg += currentDate.CURRENT_DATE() + " : " + 'GET_NON_MANDATORY_PARAMS START' + "\n";
            try {
                var responseData = [];
                var data = JSON.parse(event.body);

                for (var i = 0; i < reqParams.length; i++) {
                    var item = reqParams[i];
                    if (data[item]) {
                        responseData.push(data[item]);
                    } else {
                        responseData.push('NA');
                    }
                }
                logMsg += currentDate.CURRENT_DATE() + " : " + '200 - GET_NON_MANDATORY_PARAMS END' + "\n";
                resolve({ code: 200, msg: responseData, logMsg: logMsg });
            } catch (e) {
                logMsg += currentDate.CURRENT_DATE() + " : 201 - " + 'GET_NON_MANDATORY_PARAMS Error: Required Params: ' + reqParams + ', Front End Params: ' + JSON.stringify(data) + "\n";
                logMsg += currentDate.CURRENT_DATE() + " : 201 - " + 'GET_NON_MANDATORY_PARAMS Exception: ' + JSON.stringify(e) + "\n";
                resolve({ code: 201, msg: 'Invalid Data', logMsg: logMsg });
            }
        });
    }
};

module.exports = methods;