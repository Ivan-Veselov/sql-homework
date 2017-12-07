import React from 'react';
import {connect} from "react-redux";
import { Table } from 'semantic-ui-react'

class Details extends React.Component {
    getTableHeader = () => {
        return "Sportsmen details";
        // TODO: case on query type and return appropriate header
    };

    render() {
        return (
            <Table collapsing definition>
                <Table.Header>
                    <Table.Row>
                        <Table.HeaderCell colSpan='2'> {this.getTableHeader()} </Table.HeaderCell>
                    </Table.Row>
                </Table.Header>

            </Table>
        );
    };
}


function mapStateToProps(state) {
    return state.rowReducer;
}

export default connect(mapStateToProps)(Details);