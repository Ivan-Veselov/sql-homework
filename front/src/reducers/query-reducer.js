// "state = null" is set so that we don't throw an error when app first boots up
export default function (state = {}, action) {
    switch (action.type) {
        case 'MENU_SELECTED':
        case 'ROW_SELECTED':
        case 'SPORTSMAN_ACCOMMODATION':
            return action.payload.queryType;
            break;
    }

    return null; // why it's forbidden to use indefined?
}
