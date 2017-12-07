import $ from "jquery";
let port = 1234;
let query = require('../query');

/**
 * @param rowId is same as id of object that it holds
 * @param getQueryType /accommodation/get, /sportsman/get, /volunteer/get -- TODO -- global enum
 */
export const getQuery = (rowId, getQueryType) => {
    return {
        type: getQueryType,
        rowId
    }
};

/**
 * @param allQueryType same as get, but "all"
 */
export const allQuery = (allQueryType) => {
    let table_header = "";
    switch(allQueryType) {
        // wtf?
        query.allQueryType.ALL_ACCOMODATIONS:
            table_header = ["Название улицы", "Номер дома"];
            break;

        query.allQueryType.ALL_SPORTSMEN:
            table_header = ["Имя Фамилия"];
            break;

        query.allQueryType.ALL_VOLUNTEERS:
            table_header = ["Имя Фамилия"];
    }

    let recieved_response = {};
    let handler = response => {
        recieved_response = response;
    };

    sendQuery(allQueryType, "", handler);

    return {
        type: allQueryType,
        table_header: table_header,
        table_body: recieved_response
    }
};

sendQuery = (query_name, params, data_handler) => {
    let requestUrl = encodeURI(`http://localhost:${port}/${query_name}/${params}`);
    $.ajax({
        type: "GET",
        url: requestUrl,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(response) {
            data_handler(response);
        }
    });
};