let query = require('../query');

/**
 * @param id object's id
 * @param getQueryType /accommodation/get, /sportsman/get, /volunteer/get
 */
export function getQuery(id, getQueryType, menu) {
    let recievedResponse = {};
    let handler = response => {
        if (response.type !== 'success') {
            menu.showError(response.message);
            return;
        }

        recievedResponse = response.result;
        recievedResponse.id = id;
    };

    query.sendQuery(getQueryType, `id=${id}`, handler);

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

export function allQuery(allQueryType, menu) {
    let tableHeader = getTableHeader(allQueryType);

    let recievedResponse = {};
    let handler = response => {
        if (response.type !== 'success') {
            menu.showError(response.message);
            return;
        }

        recievedResponse = response.result;
    };

    query.sendQuery(allQueryType, "", handler);

    let data = {
        queryType: allQueryType,
        tableHeader: tableHeader,
        tableBody: recievedResponse,
    };

    return data;
};

export function getSportsmanAccommodation(accommodationId, menu) {
    let recievedResponse = {};
    let handler = response => {
        if (response.type !== 'success') {
            menu.showError(response.message);
            return;
        }

        recievedResponse = response.result;
    };

    let params = `accomodation_id=${accommodationId}`;
    let queryType = query.allQueryType.ALL_SPORTSMEN;
    query.sendQuery(query.getQueryType.GET_SPORTSMAN, params, handler);

    let tableHeader = getTableHeader(queryType);
    recievedResponse = responses.all_sportsmen;

    let data = {
        queryType,
        tableBody: recievedResponse,
        tableHeader
    };

    return data;
};
