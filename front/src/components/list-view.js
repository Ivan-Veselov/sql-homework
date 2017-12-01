import React from 'react';
import { Table } from 'semantic-ui-react'

class SpecifiedList extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            data: this.props.data,
            columns: this.props.columns,
            click_handler: this.props.handler
        }
    }

    renderTableHeader = () => {
        cells = [];
        for (var i = 0; i < this.props.columns.length; i++) {
            let column_name = this.props.columns[i];

            cells.push(
                <Table.HeaderCell> {column_name} </Table.HeaderCell>
            );
        }

        return (
            <Table.Row>
                {cells}
            </Table.Row>
        );
    };

    renderTableBody = () => {
        rows = []
        for (var i = 0; i < this.props.data.length; i++) {
            let current_row = this.props.data[i];
            let row_cells = [];
            for (var j = 0; j < current_row.length; j++) {
                let current_row_item = current_row[j]

                row_cells.push(
                    <Table.Cell> {current_row_item} </Table.Cell>
                );
            }

            cells.push(
                <Table.Row>
                    {row_cells}
                </Table.Row>
            );
        }

        return (
            {rows}
        );
    };

    render() {
        return (
            <Table singleLine compact>
                <Table.Header>
                    {this.renderTableHeader()}
                </Table.Header>

                <Table.Body>
                    {this.renderTableBody()}
                </Table.Body>
            </Table>
        );
    }
}

export default SpecifiedList;