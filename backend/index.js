exports.handler = async function (event) {
    var userRole = "";
    var logMsg = "";
    var responseData = { code: 221, msg: "Unknown Exception. Please contact admin" };
    const currentDate = require('./util/current_date_time');

    logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "Start Time";    
    //logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "Query Params: " + JSON.stringify(event.queryStringParameters);
    // if (event.requestContext && event.requestContext.authorizer && event.requestContext.authorizer.claims) {
    //     //logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "reqCon-auth-claims: " + JSON.stringify(event.requestContext.authorizer.claims);
    //     //logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "User group: " + event.requestContext.authorizer.claims["cognito:groups"];
    //     userRole = event.requestContext.authorizer.claims["cognito:groups"];
    // }
    
    try {
        var isLocal = false;
        var localCredentials = require('./env_variables');
        var credentials = localCredentials;
        if (process && process.env && process.env.CURRENT_ENV) {
            if (process.env.CURRENT_ENV === localCredentials.CURRENT_ENV) {
                credentials = localCredentials;
                isLocal = true;
            } else {
                credentials = process.env;
            }
        } else {
            credentials = localCredentials;
            isLocal = true;
        }

        var missing_keys = [];
        Object.keys(localCredentials).forEach(function (key) {
            if (!credentials.hasOwnProperty(key)) {
                missing_keys.push[key];
            }
        });        

        if (missing_keys.length > 0) {
            logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "Missing Environment Variables : " + JSON.stringify(missing_keys);
            throw new Error({ code: 221, msg: 'InSufficient Data' });
        }
        var apiPath = "";
        var pathInfo = [];
        var iToken = "";

        if (event.path) {
            apiPath = event.path;
            pathInfo = apiPath.split("/");
            pathInfo.splice(0, 1);
            iToken = event.headers.Authorization;
        } else if (event.rawPath) {
            apiPath = event.rawPath;
            pathInfo = apiPath.split("/");
            pathInfo.splice(0, 1);
            iToken = event.headers.authorization;
        }

        logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "api : " + apiPath + " - " + pathInfo + "\n";

        if (pathInfo.length >= 2) {
            var handlerName = pathInfo[0];
            var taskName = pathInfo[1];

            var canMakeApiCall = false;
            if ((handlerName == 'un_auth') || isLocal) {
                canMakeApiCall = true;
            } else {
                //logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "Event: " + JSON.stringify(event);
                var iTokenResp = await checkIToken(iToken, isLocal, currentDate, credentials, logMsg);
                logMsg = iTokenResp.logMsg;
                
                if (iTokenResp && iTokenResp.code && iTokenResp.code === 200 && iTokenResp.msg && iTokenResp.msg['cognito:groups'] && iTokenResp.msg['cognito:groups'][0] && iTokenResp.msg['cognito:username']) {
                    // if (iTokenResp?.code === 200 && iTokenResp?.msg?.['cognito:groups']?.[0] && iTokenResp?.msg?.['cognito:username']) {   
                    userRole = iTokenResp.msg['cognito:groups'][0];
                    const userName = iTokenResp.msg['cognito:username'];
                    if (userName && event.queryStringParameters["os"] && event.queryStringParameters["deviceId"]) {
                        var reqBody = {
                            username: userName,
                            os: event.queryStringParameters["os"],
                            device_id: event.queryStringParameters["deviceId"],
                        };
                        logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "CACHE check : " + JSON.stringify(reqBody);

                        const accessCache = require('./util/access_cache');
                        var cacheRespPromise = accessCache.VALIDATE_USER_OS_DEVICE("VALIDATE_USER_LOGIN_DEVICE", iToken, reqBody, credentials, logMsg);
                        var cacheResp = await cacheRespPromise;                        
                        logMsg = cacheResp.logMsg;
                        //logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "CACHE RESP : " + JSON.stringify(cacheResp);
                        if (cacheResp && cacheResp.code && cacheResp.code == 200) {                            
                            canMakeApiCall = true;
                            // logMsg += "\n" + currentDate.CURRENT_DATE() + " : CACHE VALID : " + JSON.stringify(cacheResp.msg);
                        } else {                            
                            logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "Invalid device";
                        }
                    } else {                        
                        logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "Missing data";
                    }
                } else {                    
                    logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "Session expired";
                }
            }

            if (canMakeApiCall) {                
                var handlerLocation = './handlers/' + handlerName + '_handler';
                if (validateUserRole(handlerName, userRole)) {                    
                    const myHandler = require(handlerLocation);
                    var handlerResponsePromise = myHandler[taskName](event, credentials, logMsg);
                    var handlerResponse = await handlerResponsePromise;
                    handlerResponse.logMsg += "\n" + currentDate.CURRENT_DATE() + " : END Time";
                    logMsg = ""+handlerResponse.logMsg; // need to recreate as it is delete later
                    delete handlerResponse['logMsg'];
                    responseData = handlerResponse;                    
                }else {
                    logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "Access Denied";                    
                    responseData = { code: 201, msg: "Access Denied" };
                }
            } else {                
                logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "Not Authenticated ";                
                responseData = { code: 401, msg: "Not Authenticated" };
            }
        } else {            
            logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "Insufficient Path variables : " + pathInfo.length + " - " + JSON.stringify(pathInfo);            
            responseData = { code: 221, msg: "InSufficient Data" };
        }

    } catch (ex) {        
        console.log(ex);
        logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "Exception : " + JSON.stringify(ex);        
        responseData = { code: 221, msg: "Unknown Exception. Please contact admin : " + JSON.stringify(ex) }
    } finally {        
        console.log(logMsg);
        return response = {
            statusCode: 200,
            headers: {
                //    "Access-Control-Allow-Origin": "*",
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(responseData),
        };
    }
};

function validateUserRole(handlerName, userRole) {    
    var apiCallCanFrwd = false;
    if (userRole.length == 0) {
        // localhost call
        apiCallCanFrwd = true;
    } else if ((handlerName == 'common')
        || (handlerName == "user_s3_uploads")
        || (handlerName == "messages")
        || (handlerName.toUpperCase() == userRole.toUpperCase())
        || ((userRole.toUpperCase() == "PRINCIPAL") && (handlerName.toUpperCase() == "PRINCIPAL" || handlerName.toUpperCase() == "STAFF"))
        || ((userRole.toUpperCase() == "STAFF") && (handlerName.toUpperCase() == "PRINCIPAL" || handlerName.toUpperCase() == "STAFF")) // remove this after role based auth completion
    ) {
        apiCallCanFrwd = true;
    } else {       
        console.log("Invalid request from " + userRole + " : to : " + handlerName);
    }
    return apiCallCanFrwd;
}

async function checkIToken(iToken, isLocal, currentDate, credentials, logMsg) {
    logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "IToken Check";
    if (isLocal) {
        logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "IToken Check success : Local Call";
        return { code: 200, msg: "Local Call", logMsg: logMsg };
    } else if (!iToken) {
        logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "IToken Not found";
        return { code: 401, msg: "Not authenticated", logMsg: logMsg };
    } else {
        try {            
            const { CognitoJwtVerifier } = require("aws-jwt-verify");            
            const verifier = CognitoJwtVerifier.create({
                userPoolId: credentials.ASTRAGEN_CORE_APP_USER_POOL_ID,
                tokenUse: "id", // can be access - check and use accrodingly
                clientId: credentials.ASTRAGEN_CORE_APP_CLIENT_ID,
            });           
    
            var resp = await verifier.verify(iToken);            
            logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "IToken Check success ";
            return { code: 200, msg: resp, logMsg: logMsg };
        } catch (e) {
            console.log(e);
            logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "IToken Check failed : " + isLocal + " : " + iToken;
            logMsg += "\n" + currentDate.CURRENT_DATE() + " : " + "IToken Check failed : " + e;
            return { code: 401, msg: "Invalid Token", logMsg: logMsg };
        }
    }
}


