import React from 'react';
import ReactDOM from 'react-dom';
import injectTapEventPlugin from 'react-tap-event-plugin';
import BodyBackgroundColor from 'react-body-backgroundcolor';
import UI from './components/menu.js';

injectTapEventPlugin();

ReactDOM.render(
    <BodyBackgroundColor backgroundColor='#FAEBD7'>
		<UI />
    </BodyBackgroundColor>,
    document.getElementById('app')
);
