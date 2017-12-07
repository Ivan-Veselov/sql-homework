// "state = null" is set so that we don't throw an error when app first boots up
export default function (state = {}, action) {
    switch (action.type) {
        case 'MENU_SELECTED':
            return action.payload;

    }

    return state;
}