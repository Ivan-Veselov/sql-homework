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

    let data = {
        queryType: getQueryType,
        rowId
    };
    return {
        type: 'MENU_SELECTED',
        payload: data

    }
};

/**
 * @param queryType same as get, but "all"
 * @param newActiveItem active menu item
 */
export const allQuery = (newActiveItem, queryType) => {
    let tableHeader = "";
    switch (queryType) {
        case query.allQueryType.ALL_ACCOMODATIONS:
            tableHeader = ["Название улицы", "Номер дома"];
            break;

        case query.allQueryType.ALL_SPORTSMEN:
            tableHeader = ["Имя Фамилия"];
            break;

        case query.allQueryType.ALL_VOLUNTEERS:
            tableHeader = ["Имя Фамилия"];
    }

    let recievedResponse = {};
    let handler = response => {
        recievedResponse = response;
    };

    // temporary : remove this switch and uncomment sendQuery for "real" work
    switch (queryType) {
        case query.allQueryType.ALL_ACCOMODATIONS:
            recievedResponse = responses.all_accomodations;
            break;

        case query.allQueryType.ALL_SPORTSMEN:
            recievedResponse = responses.all_sportsmen;
            break;

        case query.allQueryType.ALL_VOLUNTEERS:
            recievedResponse = responses.all_volunteers;
            break;
    }
    //sendQuery(allQueryType, "", handler);
    let data = {
        queryType: queryType,
        tableHeader: tableHeader,
        tableBody: recievedResponse,
        activeItem: newActiveItem
    };

    return {
        type: 'MENU_SELECTED',
        payload: data
    }
};

let sendQuery = (queryName, params, dataHandler) => {
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