const getParams = require("../util/get_params");
const currentDate = require("../util/current_date_time");
const mysql = require("../util/run_mysql_script");

var methods = {
  GET_EMPLOYEES: async function (event, credentials, logMsg) {
    var reqParams = [];
    var returnResponse = {
      code: 201,
      msg: "Unknown exception. Please contact admin.",
      logMsg: logMsg,
    };
    try {
      var getParamsResponse = await getParams.GET_PARAMS(
        event,
        reqParams,
        returnResponse.logMsg
      );

      if (getParamsResponse?.code === 200) {
        var sqlQuery = `SELECT EmployeeId, Name, Age, Department, Email FROM ${credentials.INTERNAL_USE_DUMMY_DB_NAME}.users_ali WHERE Status = 'active';`;
        console.log(sqlQuery);

        var mysqlResponse = await mysql.executeQueryAstraOne(
          sqlQuery,
          [],
          credentials,
          getParamsResponse.logMsg
        );

        if (mysqlResponse?.code === 200) {
          mysqlResponse.logMsg += `${currentDate.CURRENT_DATE()} : 200 : GET_EMPLOYEES - fetched successfully.\n`;
          returnResponse = {
            code: 200,
            msg: mysqlResponse.msg || [],
            logMsg: mysqlResponse.logMsg,
          };
        } else {
          mysqlResponse.logMsg += `${currentDate.CURRENT_DATE()} : 201 : GET_EMPLOYEES - failed to fetch data.\n`;
          returnResponse = {
            code: 201,
            msg: "Failed to retrieve data.",
            logMsg: mysqlResponse.logMsg,
          };
        }
      } else {
        returnResponse = getParamsResponse;
      }
    } catch (e) {
      returnResponse.logMsg += `${currentDate.CURRENT_DATE()} : 205 : GET_EMPLOYEES - Error : ${JSON.stringify(
        e
      )}\n`;
      returnResponse = {
        code: 205,
        msg: "Unknown error. Please contact admin.",
        logMsg: returnResponse.logMsg,
      };
    }

    return new Promise((resolve) => resolve(returnResponse));
  },

  ADD_EMPLOYEE: async function (event, credentials, logMsg) {
    var reqParams = ["Name", "Age", "Department", "Email"];
    var returnResponse = {
      code: 201,
      msg: "Unknown exception. Please contact admin.",
      logMsg: logMsg,
    };
    try {
      var getParamsResponse = await getParams.GET_PARAMS(
        event,
        reqParams,
        returnResponse.logMsg
      );

      if (getParamsResponse?.code === 200) {
        // var { Name, Age, Department, Email } = getParamsResponse.msg;
        var Name = getParamsResponse.msg[0];
        var Age = getParamsResponse.msg[1];
        var Department = getParamsResponse.msg[2];
        var Email = getParamsResponse.msg[3];
        var sqlQuery = `INSERT INTO ${credentials.INTERNAL_USE_DUMMY_DB_NAME}.users_ali (Name, Age, Department, Email, Status, CreatedOn, UpdatedOn) VALUES (?, ?, ?, ?, 'active', NOW(), NOW());`;
        console.log(sqlQuery);

        var mysqlResponse = await mysql.executeQueryAstraOne(
          sqlQuery,
          [Name, Age, Department, Email],
          credentials,
          getParamsResponse.logMsg
        );

        if (mysqlResponse?.code === 200) {
          mysqlResponse.logMsg += `${currentDate.CURRENT_DATE()} : 200 : ADD_EMPLOYEE - added successfully.\n`;
          returnResponse = {
            code: 200,
            msg: mysqlResponse.msg || [],
            logMsg: mysqlResponse.logMsg,
          };
        } else {
          mysqlResponse.logMsg += `${currentDate.CURRENT_DATE()} : 201 : ADD_EMPLOYEE - failed to add data.\n`;
          returnResponse = {
            code: 201,
            msg: "Failed to add data.",
            logMsg: mysqlResponse.logMsg,
          };
        }
      } else {
        returnResponse = getParamsResponse;
      }
    } catch (e) {
      returnResponse.logMsg += `${currentDate.CURRENT_DATE()} : 205 : ADD_EMPLOYEE - Error : ${JSON.stringify(
        e
      )}\n`;
      returnResponse = {
        code: 205,
        msg: "Unknown error. Please contact admin.",
        logMsg: returnResponse.logMsg,
      };
    }

    return new Promise((resolve) => resolve(returnResponse));
  },

  UPDATE_EMPLOYEE: async function (event, credentials, logMsg) {
    var reqParams = ["EmployeeId", "Name", "Age", "Department", "Email"];
    var returnResponse = {
      code: 201,
      msg: "Unknown exception. Please contact admin.",
      logMsg: logMsg,
    };
    try {
      var getParamsResponse = await getParams.GET_PARAMS(
        event,
        reqParams,
        returnResponse.logMsg
      );

      if (getParamsResponse?.code === 200) {
        var EmployeeId = getParamsResponse.msg[0];
        var Name = getParamsResponse.msg[1];
        var Age = getParamsResponse.msg[2];
        var Department = getParamsResponse.msg[3];
        var Email = getParamsResponse.msg[4];

        var sqlQuery = `UPDATE ${credentials.INTERNAL_USE_DUMMY_DB_NAME}.users_ali SET Name = ?, Age = ?, Department = ?, Email = ?, UpdatedOn = NOW() WHERE EmployeeId = ? AND Status = 'active';`;
        console.log(sqlQuery);

        var mysqlResponse = await mysql.executeQueryAstraOne(
          sqlQuery,
          [Name, Age, Department, Email, EmployeeId],
          credentials,
          getParamsResponse.logMsg
        );

        if (mysqlResponse?.code === 200) {
          mysqlResponse.logMsg += `${currentDate.CURRENT_DATE()} : 200 : UPDATE_EMPLOYEE - updated successfully.\n`;
          returnResponse = {
            code: 200,
            msg: mysqlResponse.msg || [],
            logMsg: mysqlResponse.logMsg,
          };
        } else {
          mysqlResponse.logMsg += `${currentDate.CURRENT_DATE()} : 201 : UPDATE_EMPLOYEE - failed to update data.\n`;
          returnResponse = {
            code: 201,
            msg: "Failed to update data.",
            logMsg: mysqlResponse.logMsg,
          };
        }
      } else {
        returnResponse = getParamsResponse;
      }
    } catch (e) {
      returnResponse.logMsg += `${currentDate.CURRENT_DATE()} : 205 : UPDATE_EMPLOYEE - Error : ${JSON.stringify(
        e
      )}\n`;
      returnResponse = {
        code: 205,
        msg: "Unknown error. Please contact admin.",
        logMsg: returnResponse.logMsg,
      };
    }

    return new Promise((resolve) => resolve(returnResponse));
  },

  DELETE_EMPLOYEE: async function (event, credentials, logMsg) {
    var reqParams = ["EmployeeId"];
    var returnResponse = {
      code: 201,
      msg: "Unknown exception. Please contact admin.",
      logMsg: logMsg,
    };
    try {
      var getParamsResponse = await getParams.GET_PARAMS(
        event,
        reqParams,
        returnResponse.logMsg
      );

      if (getParamsResponse?.code === 200) {
        var EmployeeId = getParamsResponse.msg[0];
        var sqlQuery = `UPDATE ${credentials.INTERNAL_USE_DUMMY_DB_NAME}.users_ali SET Status = 'inactive', UpdatedOn = NOW() WHERE EmployeeId = ? AND Status = 'active';`;
        console.log(sqlQuery);

        var mysqlResponse = await mysql.executeQueryAstraOne(
          sqlQuery,
          [EmployeeId],
          credentials,
          getParamsResponse.logMsg
        );

        if (mysqlResponse?.code === 200) {
          mysqlResponse.logMsg += `${currentDate.CURRENT_DATE()} : 200 : DELETE_EMPLOYEE - status set to inactive successfully.\n`;
          returnResponse = {
            code: 200,
            msg: mysqlResponse.msg || [],
            logMsg: mysqlResponse.logMsg,
          };
        } else {
          mysqlResponse.logMsg += `${currentDate.CURRENT_DATE()} : 201 : DELETE_EMPLOYEE - failed to update status.\n`;
          returnResponse = {
            code: 201,
            msg: "Failed to update status.",
            logMsg: mysqlResponse.logMsg,
          };
        }
      } else {
        returnResponse = getParamsResponse;
      }
    } catch (e) {
      returnResponse.logMsg += `${currentDate.CURRENT_DATE()} : 205 : DELETE_EMPLOYEE - Error : ${JSON.stringify(
        e
      )}\n`;
      returnResponse = {
        code: 205,
        msg: "Unknown error. Please contact admin.",
        logMsg: returnResponse.logMsg,
      };
    }

    return new Promise((resolve) => resolve(returnResponse));
  },

  REMOVE_EMPLOYEE: async function (event, credentials, logMsg) {
    var reqParams = ["EmployeeId"];
    var returnResponse = {
      code: 201,
      msg: "Unknown exception. Please contact admin.",
      logMsg: logMsg,
    };
    try {
      var getParamsResponse = await getParams.GET_PARAMS(
        event,
        reqParams,
        returnResponse.logMsg
      );

      if (getParamsResponse?.code === 200) {
        var { EmployeeId } = getParamsResponse.msg;
        var sqlQuery = `DELETE FROM ${credentials.INTERNAL_USE_DUMMY_DB_NAME}.users_ali WHERE EmployeeId = ?;`;
        console.log(sqlQuery);

        var mysqlResponse = await mysql.executeQueryAstraOne(
          sqlQuery,
          [EmployeeId],
          credentials,
          getParamsResponse.logMsg
        );

        if (mysqlResponse?.code === 200) {
          mysqlResponse.logMsg += `${currentDate.CURRENT_DATE()} : 200 : REMOVE_EMPLOYEE - deleted successfully.\n`;
          returnResponse = {
            code: 200,
            msg: mysqlResponse.msg || [],
            logMsg: mysqlResponse.logMsg,
          };
        } else {
          mysqlResponse.logMsg += `${currentDate.CURRENT_DATE()} : 201 : REMOVE_EMPLOYEE - failed to delete.\n`;
          returnResponse = {
            code: 201,
            msg: "Failed to delete.",
            logMsg: mysqlResponse.logMsg,
          };
        }
      } else {
        returnResponse = getParamsResponse;
      }
    } catch (e) {
      returnResponse.logMsg += `${currentDate.CURRENT_DATE()} : 205 : REMOVE_EMPLOYEE - Error : ${JSON.stringify(
        e
      )}\n`;
      returnResponse = {
        code: 205,
        msg: "Unknown error. Please contact admin.",
        logMsg: returnResponse.logMsg,
      };
    }

    return new Promise((resolve) => resolve(returnResponse));
  },

  FETCH_CSE: async function (event, credentials, logMsg) {
    // POSITIONS
    var reqParams = [];
    var returnResponse = {
      code: 201,
      msg: "Unknown exception. Please contact admin.",
      logMsg: logMsg,
    };
    try {
      var getParamsResponsePromise = getParams.GET_PARAMS(
        event,
        reqParams,
        returnResponse.logMsg
      );
      var getParamsResponse = await getParamsResponsePromise;

      if (
        getParamsResponse &&
        getParamsResponse.code &&
        getParamsResponse.code === 200
      ) {
        var sqlQuery =
          "SELECT * FROM " +
          credentials.INTERNAL_USE_DUMMY_DB_NAME +
          ".users_ali WHERE Department = 'CSE';";
        console.log(sqlQuery);

        var sqlValues = [
          // getParamsResponse.msg[0],
        ];

        console.log(sqlValues);

        var mysqlResponsePromise = mysql.executeQueryAstraOne(
          sqlQuery,
          sqlValues,
          credentials,
          getParamsResponse.logMsg
        );
        var mysqlResponse = await mysqlResponsePromise;

        if (mysqlResponse && mysqlResponse.code && mysqlResponse.code === 200) {
          mysqlResponse.logMsg +=
            currentDate.CURRENT_DATE() +
            " : 200 : FETCH_CSE - given successfully." +
            "\n";
          //   console.log(mysqlResponse);
          returnResponse = {
            code: 200,
            msg: mysqlResponse.msg || [],
            logMsg: mysqlResponse.logMsg,
          };
        } else {
          mysqlResponse.logMsg +=
            currentDate.CURRENT_DATE() +
            " : 201 : FETCH_CSE - failed to get data." +
            "\n";

          returnResponse = {
            code: 201,
            msg: "Failed to retrieve data.",
            logMsg: mysqlResponse.logMsg,
          };
        }
      } else {
        console.log(getParamsResponse.msg[0]);
        returnResponse = getParamsResponse;
      }
    } catch (e) {
      returnResponse.logMsg +=
        currentDate.CURRENT_DATE() +
        " : 205 : " +
        "FETCH_CSE - Error " +
        " : " +
        JSON.stringify(e) +
        "\n";

      console.log(returnResponse.logMsg);
      console.log(e);

      returnResponse = {
        code: 205,
        msg: "Unknown error. Please Contact Admin.",
        logMsg: returnResponse.logMsg,
      };
    }

    return new Promise((resolve) => {
      resolve(returnResponse);
    });
  },

  FETCH_IT: async function (event, credentials, logMsg) {
    // POSITIONS
    var reqParams = [];
    var returnResponse = {
      code: 201,
      msg: "Unknown exception. Please contact admin.",
      logMsg: logMsg,
    };
    try {
      var getParamsResponsePromise = getParams.GET_PARAMS(
        event,
        reqParams,
        returnResponse.logMsg
      );
      var getParamsResponse = await getParamsResponsePromise;

      if (
        getParamsResponse &&
        getParamsResponse.code &&
        getParamsResponse.code === 200
      ) {
        var sqlQuery =
          "SELECT * FROM " +
          credentials.INTERNAL_USE_DUMMY_DB_NAME +
          ".users_ali WHERE Department = 'IT';";
        console.log(sqlQuery);

        var sqlValues = [
          // getParamsResponse.msg[0],
        ];

        console.log(sqlValues);

        var mysqlResponsePromise = mysql.executeQueryAstraOne(
          sqlQuery,
          sqlValues,
          credentials,
          getParamsResponse.logMsg
        );
        var mysqlResponse = await mysqlResponsePromise;

        if (mysqlResponse && mysqlResponse.code && mysqlResponse.code === 200) {
          mysqlResponse.logMsg +=
            currentDate.CURRENT_DATE() +
            " : 200 : FETCH_IT - given successfully." +
            "\n";
          //   console.log(mysqlResponse);
          returnResponse = {
            code: 200,
            msg: mysqlResponse.msg || [],
            logMsg: mysqlResponse.logMsg,
          };
        } else {
          mysqlResponse.logMsg +=
            currentDate.CURRENT_DATE() +
            " : 201 : FETCH_IT - failed to get data." +
            "\n";

          returnResponse = {
            code: 201,
            msg: "Failed to retrieve data.",
            logMsg: mysqlResponse.logMsg,
          };
        }
      } else {
        console.log(getParamsResponse.msg[0]);
        returnResponse = getParamsResponse;
      }
    } catch (e) {
      returnResponse.logMsg +=
        currentDate.CURRENT_DATE() +
        " : 205 : " +
        "FETCH_IT - Error " +
        " : " +
        JSON.stringify(e) +
        "\n";

      console.log(returnResponse.logMsg);
      console.log(e);

      returnResponse = {
        code: 205,
        msg: "Unknown error. Please Contact Admin.",
        logMsg: returnResponse.logMsg,
      };
    }

    return new Promise((resolve) => {
      resolve(returnResponse);
    });
  },

  FETCH_ECE: async function (event, credentials, logMsg) {
    // POSITIONS
    var reqParams = [];
    var returnResponse = {
      code: 201,
      msg: "Unknown exception. Please contact admin.",
      logMsg: logMsg,
    };
    try {
      var getParamsResponsePromise = getParams.GET_PARAMS(
        event,
        reqParams,
        returnResponse.logMsg
      );
      var getParamsResponse = await getParamsResponsePromise;

      if (
        getParamsResponse &&
        getParamsResponse.code &&
        getParamsResponse.code === 200
      ) {
        var sqlQuery =
          "SELECT * FROM " +
          credentials.INTERNAL_USE_DUMMY_DB_NAME +
          ".users_ali WHERE Department = 'ECE';";
        console.log(sqlQuery);

        var sqlValues = [
          // getParamsResponse.msg[0],
        ];

        console.log(sqlValues);

        var mysqlResponsePromise = mysql.executeQueryAstraOne(
          sqlQuery,
          sqlValues,
          credentials,
          getParamsResponse.logMsg
        );
        var mysqlResponse = await mysqlResponsePromise;

        if (mysqlResponse && mysqlResponse.code && mysqlResponse.code === 200) {
          mysqlResponse.logMsg +=
            currentDate.CURRENT_DATE() +
            " : 200 : FETCH_ECE - given successfully." +
            "\n";
          //   console.log(mysqlResponse);
          returnResponse = {
            code: 200,
            msg: mysqlResponse.msg || [],
            logMsg: mysqlResponse.logMsg,
          };
        } else {
          mysqlResponse.logMsg +=
            currentDate.CURRENT_DATE() +
            " : 201 : FETCH_ECE - failed to get data." +
            "\n";

          returnResponse = {
            code: 201,
            msg: "Failed to retrieve data.",
            logMsg: mysqlResponse.logMsg,
          };
        }
      } else {
        console.log(getParamsResponse.msg[0]);
        returnResponse = getParamsResponse;
      }
    } catch (e) {
      returnResponse.logMsg +=
        currentDate.CURRENT_DATE() +
        " : 205 : " +
        "FETCH_ECE - Error " +
        " : " +
        JSON.stringify(e) +
        "\n";

      console.log(returnResponse.logMsg);
      console.log(e);

      returnResponse = {
        code: 205,
        msg: "Unknown error. Please Contact Admin.",
        logMsg: returnResponse.logMsg,
      };
    }

    return new Promise((resolve) => {
      resolve(returnResponse);
    });
  },
};

module.exports = methods;
