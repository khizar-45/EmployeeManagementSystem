var methods = {
    CURRENT_DATE: function () {
        var newDate = new Date();
        return newDate.toLocaleString('en-IN', {
            day: 'numeric',
            month: 'numeric',
            year: 'numeric',
            hour: 'numeric',
            minute: 'numeric',
            second: 'numeric',
            hour12: false
        }) + " " + newDate.getMilliseconds();
    },
    JS_DATE_TO_DD_MM_YYYY: function (inputDate) {
        let date, month, year;
        date = inputDate.getDate();
        month = inputDate.getMonth() + 1;
        year = inputDate.getFullYear();

        date = date
            .toString()
            .padStart(2, '0');

        month = month
            .toString()
            .padStart(2, '0');

        return `${date}-${month}-${year}`;
    },
    JS_DATE_OBJ_TO_DB_DATE: function (inputDate) {
        return inputDate.getUTCFullYear() + '-'
            + (inputDate.getUTCMonth() + 1).toString().padStart(2, '0') + '-'
            + inputDate.getUTCDate().toString().padStart(2, '0');
    }
};

module.exports = methods;