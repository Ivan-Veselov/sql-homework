import React from 'react';
import { Table, Icon } from 'semantic-ui-react';
let query = require('../query');

class SpecifiedList extends React.Component {
    constructor(props) {
        super(props);
    }

    // TODO : change with map
    renderTableHeader = () => {
        let cells = [];
        for (let index = 0; index < this.props.columns.length; index++) {
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

            let allQuery = this.props.queryType;
            let getQuery = this.createGetQuery(allQuery);
            let paramFunctions = [
                this.props.getInfo(objectId, getQuery),
                this.props.accommodationButton(objectId)
            ];

            rowCells.push(getClickableButtons(allQuery, paramFunctions));
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

    createGetQuery = (allQuery) => {
        return allQuery.replace("all", "get");
    };

    render() {
        return (
            <div style={{ width:"60%" }}>
                <Table selectable singleLine compact size="large">
                    <Table.Header>
                        {this.renderTableHeader()}
                    </Table.Header>

                    {this.renderTableBody()}
                </Table>
            </div>
        );
    }
}

let getClickableButtons = (queryType, clickFunctions) => {
    let getInfo = clickFunctions[0];
    if (queryType === query.getQueryType.GET_ACCOMMODATION) {
        let getSportsmanAccommodation = clickFunctions[1];
        return (
            <Table.Cell key={"icons key"}>
                <Icon name='hotel' onClick={() => getSportsmanAccommodation}/>
                <Icon name='info circle' onClick={() => getInfo}/>
            </Table.Cell>
        );
    }

    return (
        <Table.Cell key={"icons key"}>
            <Icon name='info circle' onClick={() => getInfo}/>
        </Table.Cell>
    );
};


export default SpecifiedList;
