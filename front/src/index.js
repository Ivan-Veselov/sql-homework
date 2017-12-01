import React from 'react';
import ReactDOM from 'react-dom';
import injectTapEventPlugin from 'react-tap-event-plugin';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import BodyBackgroundColor from 'react-body-backgroundcolor';
import UI from './components/ui.js';

injectTapEventPlugin();
const App = () => (
	<BodyBackgroundColor backgroundColor='#FAEBD7'>
	    <MuiThemeProvider>
	        <UI />
	    </MuiThemeProvider>
    </BodyBackgroundColor>
);

ReactDOM.render(
    <App />,
    document.getElementById('app')
);