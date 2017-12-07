// "state = null" is set so that we don't throw an error when app first boots up
export default function (state = null, action) {
    switch (action.type) {
        case 'MENU_SELECTED':
            return {
                queryType: action.queryType,
                table_header: action.table_header,
                table_body: action.table_body
            };
    }
    return state;
}