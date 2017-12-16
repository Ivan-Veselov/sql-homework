import $ from "jquery";
let port = 8080;

let allQueryType = {
    ALL_SPORTSMEN: 'sportsman/all',
    ALL_ACCOMMODATIONS: 'accommodation/all',
    ALL_VOLUNTEERS: 'volunteer/all',
};

let getQueryType = {
    GET_SPORTSMAN: 'sportsman/get',
    GET_ACCOMMODATION: 'accommodation/get',
    GET_VOLUNTEER: 'volunteer/get',
};

let setQueryType = {
    SET_SPORTSMEN: 'sportsman/set'
};

// TODO: extract this functions to another file
let getDetailTableHeader = (queryType) => {
    switch (queryType) {
        case getQueryType.GET_ACCOMMODATION:
            return "Информация о помещении";

        case getQueryType.GET_SPORTSMAN:
            return "Информация о спортсмене";

        case getQueryType.GET_VOLUNTEER:
            return "Информация о волонтере";
    }
};

let createGetQuery = (allQuery) => {
    return allQuery.replace("all", "get");
};

let getCellNames = (queryType) => {
    // TODO: on all query do the same
    switch (queryType) {
        case getQueryType.GET_ACCOMMODATION:
            return ["Улица", "Номер дома", "Тип помещения", "Название", ""];

        case getQueryType.GET_SPORTSMAN:
            return ["Имя", "Пол", "Рост", "Вес", "Возраст", "Страна", ""];

        case getQueryType.GET_VOLUNTEER:
            return ["Имя", "Номер телефона", ""];
    }
};

let sendQuery = (queryName, params, dataHandler) => {
    let convertedParams = params === "" ? "" : `?${params}`;
    let requestUrl = encodeURI(`http://localhost:${port}/${queryName}${convertedParams}`);
    $.ajax({
        type: "GET",
        url: requestUrl,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(response) {
            return dataHandler(response);
        }
    });

    return {};
};

module.exports = {
    allQueryType,
    getQueryType,
    setQueryType,
    getCellNames,
    getDetailTableHeader,
    createGetQuery,
    sendQuery
};
