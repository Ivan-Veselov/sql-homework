import React from 'react';
import { Table, Icon } from 'semantic-ui-react';
let query = require('../query');

class SpecifiedList extends React.Component {
    constructor(props) {
        super(props);
    }

    renderTableHeader = () => {
        let cells = [];
        let columnsNumber = this.props.columns.length;

        if (this.props.onRowClick !== undefined) {
            columnsNumber -= 1; // removing empty icon column
        }

        for (let index = 0; index < columnsNumber; index++) {
            let columnName = this.props.columns[index];

            cells.push(
                <Table.HeaderCell key={(-index - 1).toString()}>
                    {columnName}
                </Table.HeaderCell>
            );
        }

        return (
            <Table.Row>
                {cells}
            </Table.Row>
        );
    };

    renderTableBody = () => {
        let rows = [];
        for (let index = 0; index < this.props.data.length; index++) {
            let currentRow = this.props.data[index];
            let rowCells = [];
            let objectId = -1;

            for (let item in currentRow) {
                if (item === "id") {
                    objectId = currentRow[item];
                    continue;
                }

                rowCells.push(
                    <Table.Cell key={item}>
                        {currentRow[item]}
                    </Table.Cell>
                );
            }

            if (this.props.onRowClick !== undefined) {
                rows.push(
                    <Table.Row key={index.toString()}
                                onClick={() => this.props.onRowClick(objectId)}>
                        {rowCells}
                    </Table.Row>
                );

                continue;
            }

            let allQuery = this.props.queryType;
            let getQuery = query.createGetQuery(allQuery);
            let paramFunctions = [
                this.props.getInfo,
                this.props.accommodationButton
            ];

            rowCells.push(getClickableButtons(this.props.menu,
                            allQuery, paramFunctions, objectId, getQuery));

            rows.push(
                <Table.Row key={index.toString()}>
                    {rowCells}
                </Table.Row>
            );
        }

        return (
            <Table.Body>
                {rows}
            </Table.Body>
        );
    };

    render() {
        return (
            <div style={{ display: "flex",
                          justifyContent: "center",
                          width:"60%" }}>
                <Table selectable={this.props.onRowClick !== undefined}
                        singleLine compact size="large">
                    <Table.Header>
                        {this.renderTableHeader()}
                    </Table.Header>

                    {this.renderTableBody()}
                </Table>
            </div>
        );
    }
}

function handleHotelClick(menu, response) {
    // sorry...
    menu.setState({
        accommodation: true,
        queryType: response.queryType,
        tableHeader: response.tableHeader,
        tableBody: response.tableBody
    });
};

function handleGetInfoClick(menu, response) {
    menu.setState({
        accommodation: false,
        queryType: response.queryType,
        objectInformation: response.object
    });
};

let getClickableButtons = (menu, queryType, clickFunctions, objectId, getQuery) => {
    let getInfo = clickFunctions[0];
    // TODO : better code
    if (queryType === query.allQueryType.ALL_ACCOMMODATIONS) {
        let getSportsmanAccommodation = clickFunctions[1];
        return (
            <Table.Cell key={"icons key"}>
                <Icon name='hotel' onClick={() =>
                    handleHotelClick(menu, getSportsmanAccommodation(objectId, menu))
                }/>


                <Icon name='info circle' onClick={() =>
                    handleGetInfoClick(menu, getInfo(objectId, getQuery, menu))
                }/>
            </Table.Cell>
        );
    }

    return (
        <Table.Cell key={"icons key"}>
            <Icon name='info circle' onClick={() =>
                handleGetInfoClick(menu, getInfo(objectId, getQuery, menu))
            }/>
        </Table.Cell>
    );
};


export default SpecifiedList;
