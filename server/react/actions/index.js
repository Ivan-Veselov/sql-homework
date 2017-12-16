let query = require('../query');

/**
 * @param id object's id
 * @param getQueryType /accommodation/get, /sportsman/get, /volunteer/get
 */
export function getQuery(id, getQueryType, menu, handleData) {
    let recievedResponse = {};
    let handler = response => {
        if (response.type !== 'success') {
            menu.showError(response.message);
            return;
        }

        recievedResponse = response.result;
        recievedResponse.id = id;

        let data = {
            queryType: getQueryType,
            object: recievedResponse,
            id
        };

        handleData(menu, data);
    };

    query.sendQuery(getQueryType, `id=${id}`, handler.bind(this));
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

export function allQuery(allQueryType, menu, menuItem) {
    let tableHeader = getTableHeader(allQueryType);

    let recievedResponse = [];
    let handler = response => {
        if (response.type !== 'success') {
            menu.showError(response.message);
            return;
        }

        recievedResponse = response.result;

        let data = {
            queryType: allQueryType,
            tableHeader: tableHeader,
            tableBody: recievedResponse,
        };

        menu.setState({
            tableBody : data.tableBody,
            tableHeader : data.tableHeader,
            accommodation : false,
            activeItem : menuItem,
            queryType : allQueryType
        });
    };

    query.sendQuery(allQueryType, "", handler.bind(this));
};

export function getSportsmanAccommodation(accommodationId, menu, handleData) {
    let recievedResponse = {};
    let params = `accommodation_id=${accommodationId}`;
    let queryType = query.allQueryType.ALL_SPORTSMEN;

    let handler = response => {
        if (response.type !== 'success') {
            menu.showError(response.message);
            return;
        }

        recievedResponse = response.result;

        let tableHeader = getTableHeader(queryType);

        let data = {
            queryType,
            tableBody: recievedResponse,
            tableHeader
        };

        handleData(menu, data);
    };

    query.sendQuery(query.allQueryType.ALL_SPORTSMEN, params, handler.bind(this));
};
