// "state = null" is set so that we don't throw an error when app first boots up
export default function (state = null, action) {
    switch (action.type) {
        case 'ROW_SELECTED':
            return {
                rowId : action.rowId,
                queryType : action.getQueryType
            };
    }
    return state;
}