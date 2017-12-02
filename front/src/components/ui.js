import React from 'react';
import { Menu } from 'semantic-ui-react'
import SpecifiedList from './list-view.js';
var queries = require('../queries.js');
var content_type = require('../content_type.js');

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
    constructor() {
        super();

        this.state = {
            contentType : content_type.NONE
        };
    }

    handleAllSportsmen = (response) => {
        this.state = {
            contentType: content_type.TABLE,
            table_header: ["Имя", "Фамилия"],
            table_body: response
        };
    };

    handleAllAccomodations = (response) => {
        this.state = {
            contentType: content_type.TABLE,
            table_header: ["Название", "Адрес"],
            table_body: response
        };
    };

    handleAllVolunteers = (response) => {
        this.state = {
            contentType: content_type.TABLE,
            table_header: ["Имя", "Телефон"],
            table_body: response
        };
    };

    handleGetSportsmen = (response) => {
        this.state = {
            contentType: content_type.INFO
            // TODO: add specified json fields
        };
    };

    // handleGetAccomodation
    // handleGetVolunteer

    handleItemClick = (e, { name }) => {
        this.setState({ activeItem: name });

        switch (name) {
            case 'all_sportsmen':
                queries.sendAllSportsmenQuery(this.handleAllSportsmen.bind(this))

            case 'all_accomodations':
                queries.sendAllAccomodationsQuery(this.handleAllAccomodations.bind(this))

            case 'all_volunteers':
                queries.sendAllVolunteersQuery(this.handleAllVolunteers.bind(this))
        }; 
    };

    renderContent = () => {
        if (this.state.contentType != content_type.NONE) {
            switch (this.state.content_type) {
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
        const activeItem = this.state.activeItem

        // TODO: make clicked/unclicked menu items
        return (
            <div style={center}>
                <h1> Olympiad website! </h1>

                <Menu>
                    <Menu.Item
                      name='all_sportmen'
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
    }
}

export default UI;