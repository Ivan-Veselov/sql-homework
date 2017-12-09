import React from 'react';
import { Table, Icon } from 'semantic-ui-react';
import {bindActionCreators} from 'redux';
import {connect} from 'react-redux';
import {getQuery, getSportsmanAccommodation} from '../actions/index';
let query = require('../query');

class SpecifiedList extends React.Component {
    // TODO : change with map
    // TODO : fix child key prop
    renderTableHeader = () => {
        let cells = [];
        for (let index = 0; index < this.state.columns.length; index++) {
            let columnName = this.state.columns[index];

            cells.push(
                <Table.HeaderCell key={index}>
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
        for (let index = 0; index < this.state.data.length; index++) {
            let currentRow = this.state.data[index];
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

            let allQuery = this.state.queryType;
            let getQuery = this.createGetQuery(allQuery);
            let paramFunctions = [
                this.state.selectRow(objectId, getQuery),
                this.state.accommodationButton(objectId)
            ];

            rowCells.push(getClickableButtons(allQuery, paramFunctions));
            rows.push(
                <Table.Row key={index}>
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
            <Table.Cell>
                <Icon name='hotel' onClick={() => getSportsmanAccommodation}/>
                <Icon name='info circle' onClick={() => getInfo}/>
            </Table.Cell>
        );
    }

    return (
        <Table.Cell>
            <Icon name='info circle' onClick={() => getInfo}/>
        </Table.Cell>
    );
};

// We don't want to return the plain SpecifiedList (component) anymore, we want to return the smart Container
//      > SpecifiedList is now aware of state and actions
export default SpecifiedList;