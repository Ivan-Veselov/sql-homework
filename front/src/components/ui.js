import React from 'react';
import { Menu } from 'semantic-ui-react'
import SpecifiedList from './list-view.js';
import $ from "jquery";
import {connect} from "react-redux";
import {getQuery} from "../actions";
import {bindActionCreators} from "redux/index";
let responses = require('../mock_responses');
let content_type = require('../content_type');

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
    handleItemClick = (e, { name }) => {
        this.setState({ activeItem: name });

        switch (name) {
            case 'all_sportsmen':
                this.handleAllSportsmen(responses.all_sportsmen);
                break;
                /*this.sendQuery(query.ALL_SPORTSMEN, "", 
                                this.handleAllSportsmen.bind(this));*/

            case 'all_accomodations':
                this.handleAllAccomodations(responses.all_accomodations);
                break;
                /*this.sendQuery(query.ALL_ACCOMODATIONS, "", 
                                this.handleAllAccomodations.bind(this));*/

            case 'all_volunteers':
                this.handleAllVolunteers(responses.all_volunteers);
                /*this.sendQuery(query.ALL_VOLUNTEERS, "", 
                                this.handleAllVolunteers.bind(this));*/
        }
    };

    renderContent = () => {
        if (this.state.contentType !== content_type.NONE) {
            switch (this.state.contentType) {
                case content_type.TABLE:
                    return (
                        <SpecifiedList 
                            data={this.state.table_body}
                            columns={this.state.table_header}     
                        />
                    );

                case content_type.INFO:
                    return (
                        <h1> black magic </h1>
                    );
            }
        }
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
                      onClick={this.handleItemClick.bind(this)}
                    />

                    <Menu.Item
                      name='all_accomodations'
                      active={activeItem === 'all_accomodations'}
                      content='Список всех помещений'
                      onClick={this.handleItemClick.bind(this)}
                    />

                    <Menu.Item
                      name='all_volunteers'
                      active={activeItem === 'all_volunteers'}
                      content='Список всех волонтеров'
                      onClick={this.handleItemClick.bind(this)}
                    />
                </Menu>

                {this.renderContent()}
            </div>
        );
    };
}


// Get apps state and pass it as props to SpecifiedList
//      > whenever state changes, the SpecifiedList will automatically re-render
function mapStateToProps(state) {
    return {
        data: state.data,
        columns: state.columns,
        queryType: state.type
    };
}

// Get actions and pass them as props to to UI
function matchDispatchToProps(dispatch){
    return bindActionCreators({selectRow : getQuery}, dispatch);
}

export default connect(mapStateToProps, matchDispatchToProps)(UI);