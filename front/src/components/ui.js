import React from 'react';
import { Menu } from 'semantic-ui-react'
import SpecifiedList from './list-view.js';

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


class UI extends React.Component {
    constructor() {
        super();

        this.state = {isContentRendered: false};
    }

    /**
        On sportmen click -- view all sportsmen
        On accomodation click -- view all accomodations
    */
    handleItemClick = (e, { name }) => {
        this.setState({ activeItem: name });

        switch (name) {
            case 'all_sportsmen':
                this.sendAllSportsmenQuery()

            case 'all_accomodations':
                this.sendAllAccomodationsQuery()
        }; 
    };

    // TODO: extract this to another query handle file
    sendAllSportsmenQuery = () => {
        let query_name = "/sportsman/all";
        let params = "";

        data_handler = (response) => {
            this.state = {
                isContentRendered: true,
                table_header: ["Имя", "Фамилия"],
                table_body: response
            };
        };
    };

    sendAllAccomodationsQuery = () => {
        let query_name = "/accomodation/all";
        let params = "";

        data_handler = (response) => {
            this.state = {
                isContentRendered: true,
                table_header: ["Название", "Адрес"],
                table_body: response
            };
        };
    };

    sendQuery = (query_name, params, data_handler) => {
        let requestUrl = encodeURI("http://localhost:1234/" + query_name + "/" + params);
        $.ajax({
            type: "GET",
            url: requestUrl,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                data_handler(response);
            }
        });
    };

    renderQueryContent = () => {
        if (this.state.isContentRendered) {
            return (
                <SpecifiedList 
                    data={this.state.table_body}
                    columns={this.state.table_header}            
                />
            );
        }
    };

    /**
     * Rendering tabs together.
     */
    render() {
        const { activeItem } = this.state

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
                </Menu>

                {this.renderQueryContent()}
            </div>
        );
    }
}

export default UI;