import $ from "jquery";
let port = 1234;

let allQueryType = {
    ALL_SPORTSMEN: 'sportsman/all',
    ALL_ACCOMODATIONS: 'accomodation/all',
    ALL_VOLUNTEERS: 'volunteers/all',
};

let getQueryType = {
    GET_SPORTSMAN: 'sportsman/get',
    GET_ACCOMODATION: 'accomodation/get',
    GET_VOLUNTEER: 'volunteers/get',
};

let setQueryType = {
    SET_SPORTSMEN: 'sportsman/set'
};

let getCellNames = (queryType) => {
    // TODO: on all query do the same
    switch (queryType) {
        case query.allQueryType.GET_ACCOMODATION:
            return ["Улица", "Номер дома", "Тип помещения", "Название"]; // TODO: название???

        case query.allQueryType.GET_SPORTSMAN:
            return ["Имя", "Пол", "Рост", "Вес", "Возраст", "Страна"];

        case query.allQueryType.GET_VOLUNTEER:
            return ["Имя", "Номер телефона"];
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
    sendQuery
};