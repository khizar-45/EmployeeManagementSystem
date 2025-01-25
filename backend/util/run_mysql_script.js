var mysql = require('mysql2');

let responseBody = { code: 202, msg: 'Unable to Initialize' };
let query = {
    sql: '',
    timeout: 3000,
    values: []
};
const currentDate = require('../util/current_date_time');

var methods = {

    executeQueryAstraOne: async function (sql, values, credentials, logMsg) {
        return new Promise(resolve => {
            logMsg += currentDate.CURRENT_DATE() + " : " + "EXECUTE_QUERY START" + "\n";
            try {
                var connectionParams = {
                    host: credentials.ASTRAGEN_CORE_DB_END_POINT,
                    user: credentials.ASTRAGEN_CORE_DB_USERNAME,
                    password: credentials.ASTRAGEN_CORE_DB_PASSWORD,
                    database: credentials.INTERNAL_USE_DUMMY_DB_NAME,
                    flags: 'MULTI_STATEMENTS'
                };
                // logMsg += currentDate.CURRENT_DATE() + " : 201 : " + 'PARAMS : ' + JSON.stringify(connectionParams) + "\n";
                
                var connection = mysql.createConnection(connectionParams);

                query.sql = sql;
                query.timeout = credentials.QUERY_TIMEOUT;
                query.values = values;

                connection.query(query, function (error, results, fields) {
                    connection.destroy();
                    if (error) {
                        logMsg += currentDate.CURRENT_DATE() + " : 201 - " + 'Invalid Query ' + ' : ' + JSON.stringify(query) + ' : ' + 'MYSQL ERROR : ' + JSON.stringify(error) + "\n";
                        console.log(logMsg);
                        console.log(error);
                        logMsg = "";
                        logMsg += currentDate.CURRENT_DATE() + " : 201 - " + "EXECUTE_QUERY END" + "\n";
                        resolve({ code: 201, msg: 'Unknown error. Please Contact Admin', logMsg: logMsg });
                    } else {
                        logMsg += currentDate.CURRENT_DATE() + " : 200 - " + "EXECUTE_QUERY END" + "\n";
                        resolve({ code: 200, msg: results, logMsg: logMsg });
                    }
                });
            } catch (ex) {
                logMsg += currentDate.CURRENT_DATE() + " : 201 - " + 'Database connection Error ' + ' : ' + JSON.stringify(query) + ' : ' + 'MYSQL ERROR : ' + JSON.stringify(ex) + "\n";
                console.log(logMsg);
                console.log(ex);
                logMsg = "";
                logMsg += currentDate.CURRENT_DATE() + " : 201 - " + "EXECUTE_QUERY END " + "\n";
                connection.destroy();
                resolve({ code: 201, msg: "Unknown error. Please Contact Admin", logMsg: logMsg });
            }
        });

    },
};

module.exports = methods;


