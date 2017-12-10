import React from 'react';
import { Menu } from 'semantic-ui-react';
import SpecifiedList from './list-view';
import Details from './details';
import Sportsman from './sportsman';
import { getQuery, allQuery, getSportsmanAccommodation } from '../actions';
let query = require('../query');

/**
    Center align
*/
const center = {
    display: "flex",
    flexDirection: "column",
    justifyContent: "center",
    alignItems: "center",
    marginBottom: "20px"
};

class UI extends React.Component {
    constructor() {
        super();

        this.state = {
            activeItem: null,
            queryType: null,
            tableBody: null,
            tableHeader: null,
            accommodation: false,
            objectInformation: null,

            selectMenuItem : allQuery,
            getQuery,
            getSportsmanAccommodation
        }
    }

    renderContent = () => {
        let queryType = this.state.queryType;

        if (queryType === null) {
            return;
        }

        let data = null;
        let accommodation = this.state.accommodation;
        let accommodationSportsmenClicked = accommodation &&
        queryType === query.getQueryType.GET_SPORTSMAN;

        if (accommodationSportsmenClicked) {
            data = this.state.accommodation;
        } else {
            data = this.state.tableBody;
        }
        let columns = this.state.tableHeader;
        let accommodationButton = undefined;
        if (query.allQueryType.ALL_ACCOMMODATIONS) {
            accommodationButton = this.state.getSportsmanAccommodation;
        }

        switch(queryType) {
            case query.allQueryType.ALL_SPORTSMEN:
            case query.allQueryType.ALL_ACCOMMODATIONS:
            case query.allQueryType.ALL_VOLUNTEERS:
                return (
                    <SpecifiedList
                        columns={columns}
                        data={data}
                        queryType={queryType}
                        getInfo={this.state.getQuery}
                        accommodationButton={accommodationButton}
                        menu={this}
                    />
                );
                break;

            case query.getQueryType.GET_ACCOMMODATION:
            case query.getQueryType.GET_VOLUNTEER:
                return (
                    <Details
                        queryType={queryType}
                        object={this.state.objectInformation}
                    />
                );
                break;

            case query.getQueryType.GET_SPORTSMAN:
            return (
                <Sportsman
                    queryType={queryType}
                    object={this.state.objectInformation}
                />
            );
            break;

        }
    };

    handleClick = (item, queryType) => {
        let data = this.state.selectMenuItem(queryType);

        ///console.log(this.state);
        this.setState({
            tableBody : data.tableBody,
            tableHeader : data.tableHeader,
            accommodation : false,
            activeItem : item,
            queryType : queryType
        });

        //console.log(this.state);
    };

    /**
     * Rendering tabs together.
     */
    render() {
        const activeItem = this.state.activeItem;
        const allSportsmenItem = 'all_sportsmen';
        const allAccommodationsItem = 'all_accommodations';
        const allVolunteersItem = 'all_volunteers';
        //console.log(activeItem);

        return (
            <div style={center}>
                <h1> Olympiad website! </h1>

                <Menu>
                    <Menu.Item
                        name={allSportsmenItem}
                        active={activeItem === allSportsmenItem}
                        content='Список всех спортсменов'
                        onClick={() => this.handleClick(allSportsmenItem,
                                        query.allQueryType.ALL_SPORTSMEN)}
                    />

                    <Menu.Item
                        name={allAccommodationsItem}
                        active={activeItem === allAccommodationsItem}
                        content='Список всех помещений'
                        onClick={() => this.handleClick(allAccommodationsItem,
                                        query.allQueryType.ALL_ACCOMMODATIONS)}
                    />

                    <Menu.Item
                        name={allVolunteersItem}
                        active={activeItem === allVolunteersItem}
                        content='Список всех волонтеров'
                        onClick={() => this.handleClick(allVolunteersItem,
                                        query.allQueryType.ALL_VOLUNTEERS)}
                    />
                </Menu>

                {this.renderContent()}
            </div>
        );
    };
}

export default UI;
