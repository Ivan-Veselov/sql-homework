let port = 1234;
// redesign functions appearence

function sendAllSportsmenQuery(data_handler) {
    let query_name = "/sportsman/all";
    let params = "";

    sendQuery(query_name, params, data_handler)
};

function sendAllAccomodationsQuery(data_handler) {
    let query_name = "/accomodation/all";
    let params = "";

    sendQuery(query_name, params, data_handler)
};

function sendAllVolunteersQuery(data_handler) {
    let query_name = "/volunteer/all";
    let params = "";

    sendQuery(query_name, params, data_handler)
};

function sendSportsmanGetQuery(sportsman_id, data_handler) {
    let query_name = "/sportsman/get";
    let params = "id=" + sportsman_id;

    sendQuery(query_name, params, data_handler)
};

function sendAccomodationGetQuery(accomodation_id, data_handler) {
    let query_name = "/accomodation/get";
    let params = "id=" + accomodation_id;

    sendQuery(query_name, params, data_handler)
};

function sendVolunteerGetQuery(volunteer_id, data_handler) {
    let query_name = "/volunteer/get";
    let params = "id=" + volunteer_id;

    sendQuery(query_name, params, data_handler)
};

function sendQuery(query_name, params, data_handler) {
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

module.exports = {
  sendAllSportsmenQuery: sendAllSportsmenQuery,
  sendAllAccomodationsQuery: sendAllAccomodationsQuery,
  sendAllVolunteersQuery: sendAllVolunteersQuery
};