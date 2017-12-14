let query = require('../query');
let responses = require('../mock-responses');

/**
 * @param id object's id
 * @param getQueryType /accommodation/get, /sportsman/get, /volunteer/get
 */
export function getQuery(id, getQueryType) {
    let recievedResponse = {};
    let handler = response => {
        recievedResponse = response;
    };

    switch (getQueryType) {
        case query.getQueryType.GET_ACCOMMODATION:
            recievedResponse = responses.get_accommodation;
            break;

        case query.getQueryType.GET_SPORTSMAN:
            recievedResponse = responses.get_sportsman;
            break;

        case query.getQueryType.GET_VOLUNTEER:
            recievedResponse = responses.get_volunteer;
            break;
    }
    recievedResponse.id = id;
    //sendQuery(getQueryType, `id=${id}`);

    let data = {
        queryType: getQueryType,
        object: recievedResponse,
        id
    };

    return data;
};

function getTableHeader(allQueryType) {
    let tableHeader = "";
    switch (allQueryType) {
        case query.allQueryType.ALL_ACCOMMODATIONS:
            tableHeader = ["Название улицы", "Номер дома", ""];
            break;

        case query.allQueryType.ALL_SPORTSMEN:
            tableHeader = ["Имя Фамилия", ""];
            break;

        case query.allQueryType.ALL_VOLUNTEERS:
            tableHeader = ["Имя Фамилия", ""];
    }

    return tableHeader;
}

/**
 * @param allQueryType same as get, but "all"
 * @param newActiveItem active menu item
 */
export function allQuery(allQueryType) {
    let tableHeader = getTableHeader(allQueryType);

    let recievedResponse = {};
    let handler = response => {
        recievedResponse = response;
    };

    // temporary : remove this switch and uncomment sendQuery for "real" work
    switch (allQueryType) {
        case query.allQueryType.ALL_ACCOMMODATIONS:
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
    };

    return data;
};

export function getSportsmanAccommodation(accommodationId) {
    let recievedResponse = {};
    let handler = response => {
        recievedResponse = response;
    };

    let params = `accomodation_id=${accommodationId}`;
    let queryType = query.allQueryType.ALL_SPORTSMEN;
    //sendQuery(query.getQueryType.GET_SPORTSMAN, params);

    let tableHeader = getTableHeader(queryType);
    recievedResponse = responses.all_sportsmen;

    let data = {
        queryType,
        tableBody: recievedResponse,
        tableHeader
    };

    return data;
};
