import React from 'react';
import { Menu } from 'semantic-ui-react'
import SpecifiedList from './list-view';
import Details from './details'
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
            let data = null;
            let accommodation = this.props.accommodation;
            let accommodationSportsmenClicked = accommodation !== null &&
            queryType == query.getQueryType.GET_SPORTSMAN;

            if (accommodationSportsmenClicked) {
                data = this.props.accommodation;
            } else {
                data = this.props.menuReducer.tableBody;
            }
            let columns = this.props.menuReducer.tableHeader;
            let accommodationButton = undefined;
            if (query.allQueryType.ALL_ACCOMMODATIONS) {
                accommodationButton = this.props.selectAccommodationSportsmen;
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
                            getInfo={getQuery}
                            accommodationButton={accommodationButton}
                        />
                    );

                case query.getQueryType.GET_SPORTSMAN:
                case query.getQueryType.GET_ACCOMMODATION:
                case query.getQueryType.GET_VOLUNTEER:
                    return (
                        <Details
                            queryType={queryType}
                            object={this.state.rowReducer}
                        />
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

export default UI;
