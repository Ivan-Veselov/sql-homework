import React from 'react';
import { Table } from 'semantic-ui-react';
import {bindActionCreators} from 'redux';
import {connect} from 'react-redux';
import {getQuery} from '../actions/index'

class SpecifiedList extends React.Component {
    // change with map
    renderTableHeader = () => {
        let cells = [];
        for (let i = 0; i < this.props.columns.length; i++) {
            let column_name = this.props.columns[i];

            cells.push(
                <Table.HeaderCell> 
                    {column_name} 
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
        for (let i = 0; i < this.props.data.length; i++) {
            let current_row = this.props.data[i];
            let row_cells = [];
            let row_id = -1;

            for (let item in current_row) {
                if (item === "id") {
                    row_id = current_row[item];
                    continue;
                }

                row_cells.push(
                    <Table.Cell>
                        {current_row[item]}
                    </Table.Cell>
                );
            }


            rows.push(
                <Table.Row
                    key={i}
                    onClick={() => this.props.rowReducer(row_id, this.props.queryType)}
                >
                    {row_cells}
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
        data: state.data,
        columns: state.columns,
        queryType: state.type
    };
}

// Get actions and pass them as props to to SpecifiedList
//      > now SpecifiedList has this.props.selectCell
function matchDispatchToProps(dispatch){
    return bindActionCreators({selectRow : getQuery}, dispatch);
}

// We don't want to return the plain SpecifiedList (component) anymore, we want to return the smart Container
//      > SpecifiedList is now aware of state and actions
export default connect(mapStateToProps, matchDispatchToProps)(SpecifiedList);