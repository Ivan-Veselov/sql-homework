import $ from "jquery";
let port = 1234;
let query = require('../query');
let responses = require('../mock-responses');

/**
 * @param id object's id
 * @param getQueryType /accommodation/get, /sportsman/get, /volunteer/get
 */
export const getQuery = (id, getQueryType) => {
    let recievedResponse = {};
    let handler = response => {
        recievedResponse = response;
    };

    switch (getQueryType) {
        case query.allQueryType.GET_ACCOMODATION:
            recievedResponse = responses.get_accommodation;
            break;

        case query.allQueryType.GET_SPORTSMAN:
            recievedResponse = responses.get_sportsman;
            break;

        case query.allQueryType.GET_VOLUNTEER:
            recievedResponse = responses.get_volunteer;
            break;
    }
    //sendQuery(getQueryType, `id=${id}`);

    let data = {
        queryType: getQueryType,
        recievedResponse,
        id
    };

    return {
        type: 'ROW_SELECTED',
        payload: data
    }
};

/**
 * @param allQueryType same as get, but "all"
 * @param newActiveItem active menu item
 */
export const allQuery = (newActiveItem, allQueryType) => {
    let tableHeader = "";
    switch (allQueryType) {
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
    switch (allQueryType) {
        case query.allQueryType.ALL_ACCOMODATIONS:
            recievedResponse = responses.all_accommodations;
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
        queryType: allQueryType,
        tableHeader: tableHeader,
        tableBody: recievedResponse,
        activeItem: newActiveItem
    };

    return {
        type: 'MENU_SELECTED',
        payload: data
    }
};