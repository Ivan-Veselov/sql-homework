import React from 'react';
import ReactDOM from 'react-dom';
import {Provider} from 'react-redux';
import {createStore} from 'redux';
import injectTapEventPlugin from 'react-tap-event-plugin';
import BodyBackgroundColor from 'react-body-backgroundcolor';
import UI from './components/ui.js';
import allReducers from './reducers';

injectTapEventPlugin();

const store = createStore(
    allReducers
);

const App = () => (
	<BodyBackgroundColor backgroundColor='#FAEBD7'>
		<UI />
    </BodyBackgroundColor>
);

ReactDOM.render(
    <Provider store={store}>
        <App />
    </Provider>,
    document.getElementById('app')
);