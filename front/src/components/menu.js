import React from 'react';
import { Menu } from 'semantic-ui-react'
import SpecifiedList from './list-view.js';
import {connect} from "react-redux";
import {allQuery} from "../actions";
import {bindActionCreators} from "redux/index";
let query = require('../query');

/**
    Center align
*/
const center = {
    display: "flex",
    flexDirection: "column",
    flexWrap: "wrap",
    justifyContent: "center",
    alignItems: "center",
    marginBottom: "20px",
};

// Global todo: fix code style
class UI extends React.Component {
    renderContent = () => {
        return (
            <SpecifiedList
                data={this.state.table_body}
                columns={this.state.table_header}
            />
        );
    };

    /**
     * Rendering tabs together.
     */
    render() {
        const activeItem = this.state.activeItem;

        return (
            <div style={center}>
                <h1> Olympiad website! </h1>

                <Menu>
                    <Menu.Item
                      name='all_sportsmen'
                      active={activeItem === 'all_sportsmen'}
                      content='Список всех спортсменов'
                      onClick={() => this.props.selectMenuItem(query.allQueryType.ALL_SPORTSMEN)}
                    />

                    <Menu.Item
                      name='all_accomodations'
                      active={activeItem === 'all_accomodations'}
                      content='Список всех помещений'
                      onClick={() => this.props.selectMenuItem(query.allQueryType.ALL_ACCOMODATIONS)}
                    />

                    <Menu.Item
                      name='all_volunteers'
                      active={activeItem === 'all_volunteers'}
                      content='Список всех волонтеров'
                      onClick={() => this.props.selectMenuItem(query.allQueryType.ALL_VOLUNTEERS)}
                    />
                </Menu>

                {this.renderContent()}
            </div>
        );
    };
}


// Get apps state and pass it as props to UI
function mapStateToProps(state) {
    return {
        table_header: state.table_header,
        table_body: state.table_body,
    };
}

// Get actions and pass them as props to to UI
function matchDispatchToProps(dispatch){
    return bindActionCreators({selectMenuItem : allQuery}, dispatch);
}

export default connect(mapStateToProps, matchDispatchToProps)(UI);