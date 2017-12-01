import React from 'react';
import { Menu } from 'semantic-ui-react'

/**
    Center align
*/
const center = {
    display: "flex",
    flexDirection: "column",
    flexWrap: "wrap",
    justifyContent: "center",
    alignItems: "center",
};


class UI extends React.Component {
    constructor() {
        super();
        this.state = {}
    }

    /**
        On sportmen click -- view all sportsmen
        On accomodation click -- view all accomodations
    */
    handleItemClick = (e, { name }) => this.setState({ activeItem: name })

    /**
     * Rendering tabs together.
     */
    render() {
        const { activeItem } = this.state

        return (
            <div style={center}>
                <h1> Olympiad website! </h1>

                <Menu>
                    <Menu.Item
                      name='sportmen'
                      active={activeItem === 'sportmen'}
                      content='Список всех спортсменов'
                      onClick={this.handleItemClick}
                    />

                    <Menu.Item
                      name='accomodations'
                      active={activeItem === 'accomodations'}
                      content='Список всех помещений'
                      onClick={this.handleItemClick}
                    />
                </Menu>

                <h1> TODO click list </h1>
            </div>
        );
    }
}

export default UI;