import {combineReducers} from 'redux';
import RowReducer from './list-reducer';
import MenuReducer from './menu-reducer';
import QueryReducer from './query-reducer';
import AccommodationReducer from './accommodation-reducer';

const allReducers = combineReducers({
    rowReducer : RowReducer,
    menuReducer : MenuReducer,
    query : QueryReducer,
    accommodation:  AccommodationReducer
});

export default allReducers;
