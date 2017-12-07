import {combineReducers} from 'redux';
import RowReducer from './row-reducer';
import MenuReducer from './menu-reducer';

const allReducers = combineReducers({
    rowReducer : RowReducer,
    menuReducer : MenuReducer
});

export default allReducers;