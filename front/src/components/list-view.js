import React from 'react';
import { Table } from 'semantic-ui-react';
import {bindActionCreators} from 'redux';
import {connect} from 'react-redux';
import {getQuery} from '../actions/index';

class SpecifiedList extends React.Component {
    // TODO : change with map
    // TODO : fix child key prop
    renderTableHeader = () => {
        let cells = [];
        for (let index = 0; index < this.props.columns.length; index++) {
            let columnName = this.props.columns[index];

            cells.push(
                <Table.HeaderCell>
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
                    <Table.Cell>
                        {currentRow[item]}
                    </Table.Cell>
                );
            }

            let allQuery = this.props.queryType;
            let getQuery = this.createGetQuery(allQuery);
            rows.push(
                <Table.Row
                    key={index}
                    onClick={() => this.props.selectRow(objectId, getQuery)}
                >
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

// Get apps state and pass it as props to SpecifiedList
//      > whenever state changes, the SpecifiedList will automatically re-render
function mapStateToProps(state) {
    return {
        columns : state.menuReducer.tableHeader,
        data: state.menuReducer.tableBody,
        queryType: state.query
    }
}

// Get actions and pass them as props to to SpecifiedList
//      > now SpecifiedList has this.props.selectRow
function matchDispatchToProps(dispatch) {
    return bindActionCreators({selectRow : getQuery}, dispatch);
}

// We don't want to return the plain SpecifiedList (component) anymore, we want to return the smart Container
//      > SpecifiedList is now aware of state and actions
export default connect(mapStateToProps, matchDispatchToProps)(SpecifiedList);