import React from 'react';
import { Table } from 'semantic-ui-react';
import {bindActionCreators} from 'redux';
import {connect} from 'react-redux';
import {getQuery} from '../actions/index'

class SpecifiedList extends React.Component {
    // change with map
    renderTableHeader = () => {
        console.log(this.props);
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
            let rowId = -1;

            for (let item in currentRow) {
                if (item === "id") {
                    rowId = currentRow[item];
                    continue;
                }

                rowCells.push(
                    <Table.Cell>
                        {currentRow[item]}
                    </Table.Cell>
                );
            }


            rows.push(
                <Table.Row
                    key={index}
                    //onClick={() => this.props.rowReducer(row_id, this.props.queryType)}
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

    render() {

        return (
            <div style={{ width:"60%" }}>
                <Table singleLine compact size="large">
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
        data: state.menuReducer.tableBody
    }
}

// Get actions and pass them as props to to SpecifiedList
//      > now SpecifiedList has this.props.selectCell
function matchDispatchToProps(dispatch){
    return bindActionCreators({selectRow : getQuery}, dispatch);
}

// We don't want to return the plain SpecifiedList (component) anymore, we want to return the smart Container
//      > SpecifiedList is now aware of state and actions
export default connect(mapStateToProps, matchDispatchToProps)(SpecifiedList);