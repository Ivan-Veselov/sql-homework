import $ from "jquery";
let port = 1234;

let allQueryType = {
    ALL_SPORTSMEN: 'sportsman/all',
    ALL_ACCOMMODATIONS: 'accomodation/all',
    ALL_VOLUNTEERS: 'volunteers/all',
};

let getQueryType = {
    GET_SPORTSMAN: 'sportsman/get',
    GET_ACCOMMODATION: 'accomodation/get',
    GET_VOLUNTEER: 'volunteers/get',
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
            dataHandler(response);
        }
    });
};

module.exports = {
    allQueryType,
    getQueryType,
    setQueryType,
    getCellNames,
    getDetailTableHeader,
    sendQuery
};
