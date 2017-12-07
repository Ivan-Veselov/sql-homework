import React from 'react';
import { Menu } from 'semantic-ui-react'
import SpecifiedList from './list-view';
import Details from './details'
import {connect} from "react-redux";
import {allQuery} from "../actions";
import {bindActionCreators} from "redux";
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
        let queryType = this.props.queryType;
        if (queryType !== null) {
            console.log(queryType);
            switch(queryType) {
                case query.allQueryType.ALL_SPORTSMEN:
                case query.allQueryType.ALL_ACCOMMODATIONS:
                case query.allQueryType.ALL_VOLUNTEERS:
                    return (
                        <SpecifiedList />
                    );

                case query.getQueryType.GET_SPORTSMAN:
                case query.getQueryType.GET_ACCOMMODATION:
                case query.getQueryType.GET_VOLUNTEER:
                    return (
                        <Details />
                    );    
            }
        }
    };

    /**
     * Rendering tabs together.
     */
    render() {
        const activeItem = this.props.activeItem;
        const allSportsmenItem = 'all_sportsmen';
        const allAccommodationsItem = 'all_accommodations';
        const allVolunteersItem = 'all_volunteers';

        return (
            <div style={center}>
                <h1> Olympiad website! </h1>

                <Menu>
                    <Menu.Item
                        name={allSportsmenItem}
                        active={activeItem === allSportsmenItem}
                        content='Список всех спортсменов'
                        onClick={() => this.props.selectMenuItem(allSportsmenItem,
                                                        query.allQueryType.ALL_SPORTSMEN)}
                    />

                    <Menu.Item
                        name={allAccommodationsItem}
                        active={activeItem === allAccommodationsItem}
                        content='Список всех помещений'
                        onClick={() => this.props.selectMenuItem(allAccommodationsItem,
                                                        query.allQueryType.ALL_ACCOMMODATIONS)}
                    />

                    <Menu.Item
                        name={allVolunteersItem}
                        active={activeItem === allVolunteersItem}
                        content='Список всех волонтеров'
                        onClick={() => this.props.selectMenuItem(allVolunteersItem,
                                                        query.allQueryType.ALL_VOLUNTEERS)}
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
        activeItem : state.menuReducer.activeItem,
        queryType : state.query
    }
}

// Get actions and pass them as props to UI
function matchDispatchToProps(dispatch){
    return bindActionCreators({selectMenuItem : allQuery}, dispatch);
}

export default connect(mapStateToProps, matchDispatchToProps)(UI);