import React from 'react';
import {connect} from "react-redux";
import { Table } from 'semantic-ui-react'
let query = require('../query');

class Details extends React.Component {
    renderDetails = () => {
        let cellNames = query.getCellNames(this.props.queryType);

        let detailIndex = 0;
        let rows = [];
        for (let item in this.props.object) {
            let detail = this.props.object[item];
            let detailName = cellNames[detailIndex];
            detailIndex++;

            rows.push(
                <Table.Row>
                    <Table.Cell textAlign='center'> {detailName} </Table.Cell>
                    <Table.Cell textAlign='center'> {detail} </Table.Cell>
                </Table.Row>
            );
        }

        return rows;
    };

    render() {
        return (
            <Table collapsing definition>
                <Table.Header>
                    <Table.Row>
                        <Table.HeaderCell colSpan='2' textAlign='center'>
                            {query.getDetailTableHeader(this.props.queryType)}
                        </Table.HeaderCell>
                    </Table.Row>
                </Table.Header>

                <Table.Body>
                    {this.renderDetails()}
                </Table.Body>

            </Table>
        );
    };
}


function mapStateToProps(state) {
    return {
        object: state.rowReducer.object,
        queryType : state.query
    }
}

export default connect(mapStateToProps)(Details);