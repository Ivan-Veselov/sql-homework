import React from 'react';
import ReactDOM from 'react-dom';
import injectTapEventPlugin from 'react-tap-event-plugin';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import BodyBackgroundColor from 'react-body-backgroundcolor';

injectTapEventPlugin();
const App = () => (
	<BodyBackgroundColor backgroundColor='#F0F8FF'>
	    <MuiThemeProvider>
	        <div> "Hello world!" </div>
	    </MuiThemeProvider>
    </BodyBackgroundColor>
);

ReactDOM.render(
    <App />,
    document.getElementById('app')
);