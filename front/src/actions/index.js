import $ from "jquery";
let port = 1234;
let query = require('../query');
let responses = require('../mock_responses');

/**
 * @param rowId is same as id of object that it holds
 * @param getQueryType /accommodation/get, /sportsman/get, /volunteer/get -- TODO -- global enum
 */
export const getQuery = (rowId, getQueryType) => {
    // TODO handle get queries

    return {
        type: 'MENU_SELECTED',
        queryType: getQueryType,
        rowId
    }
};

/**
 * @param allQueryType same as get, but "all"
 */
export const allQuery = (allQueryType) => {
    let tableHeader = "";
    switch(allQueryType) {
        // wtf?
        query.allQueryType.ALL_ACCOMODATIONS:
            tableHeader = ["Название улицы", "Номер дома"];
            break;

        query.allQueryType.ALL_SPORTSMEN:
            tableHeader = ["Имя Фамилия"];
            break;

        query.allQueryType.ALL_VOLUNTEERS:
            tableHeader = ["Имя Фамилия"];
    }

    let recievedResponse = {};
    let handler = response => {
        recievedResponse = response;
    };

    // temporary : remove this switch and uncomment sendQuery for "real" work
    switch(allQueryType) {
        query.allQueryType.ALL_ACCOMODATIONS:
            recievedResponse = responses.all_accomodations;
            break;

        query.allQueryType.ALL_SPORTSMEN:
            recievedResponse = responses.all_sportsmen;
            break;

        query.allQueryType.ALL_VOLUNTEERS:
            recievedResponse = responses.all_volunteers;

    }
    //sendQuery(allQueryType, "", handler);

    return {
        type: 'MENU_SELECTED',
        queryType: allQueryType,
        table_header: tableHeader,
        table_body: recievedResponse
    }
};

sendQuery = (queryName, params, dataHandler) => {
    let requestUrl = encodeURI(`http://localhost:${port}/${queryName}/${params}`);
    $.ajax({
        type: "GET",
        url: requestUrl,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(response) {
            dataHandler(response);
        }
    });
};