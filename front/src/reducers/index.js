import {combineReducers} from 'redux';
import RowReducer from './list-reducer';
import MenuReducer from './menu-reducer';
import QueryReducer from './query-reducer';

const allReducers = combineReducers({
    rowReducer : RowReducer,
    menuReducer : MenuReducer,
    query : QueryReducer
});

export default allReducers;