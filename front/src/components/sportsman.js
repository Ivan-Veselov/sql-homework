import React from 'react';
import Details from './details';
import SpecifiedList from './list-view';
import { Button } from 'semantic-ui-react';
import { allQuery, getQuery } from '../actions';
let query = require('../query');

class Sportsman extends React.Component {
    constructor(props) {
        super(props);

        let sportsman = this.props.object; // I've no idea why I should get .object
        let accommodation = this.props["accommodation"];
        let volunteer = this.props["volunteer"];

        delete sportsman.accommodation;
        delete sportsman.volunteer;

        this.state = {
            sportsman,
            volunteer,
            accommodation,
            choosing: false
        }
    }

    onRowClick = (id) => {
        let createdGetQuery = query.createGetQuery(this.state.queryType);
        let response = getQuery(id, createGetQuery);

        let sportsmanId = `$id=${this.state.sportsman.id}`;
        let accommodationId, volunteerId;
        let object = response.object;
        let params = "";

        switch (createdGetQuery) {
            case query.getQueryType.GET_ACCOMMODATION:
                this.setState({accommodation : object});
                accommodationId = `$accommodation_id=${id}`;
                volunteerId = `$volunteer_id=${this.state.volunteer.id}`;
                params = `${sportsmanId}&${accommodationId}&${volunteerId}`;
                break;

            case query.getQueryType.GET_VOLUNTEER:
                this.setState({volunteer : object});
                accommodationId = `$accommodation_id=${this.state.accommodation.id}`;
                volunteerId = `$volunteer_id=${id}`;
                params = `${sportsmanId}&${accommodationId}&${volunteerId}`;
                break;
        }

        let handler = response => {
            let menu = this.props.menu;

            if (response.error !== undefined) {
                menu.showError(response.message);
            }

            recievedResponse = response;
        };
        // sendQuery(query.setQueryType.SET_SPORTSMEN, params, handler)
        this.setState({choosing : false});
    }

    handleButtonClick = (queryType) => {
        let response = allQuery(queryType);

        this.setState({
            choosing: true,
            data: response.tableBody,
            columns: response.tableHeader,
            queryType
        });
    }

    renderButton = (queryType) => {
        let text = "";

        switch (queryType) {
            case query.getQueryType.GET_SPORTSMAN:
                return;
                break;

            case query.getQueryType.GET_ACCOMMODATION:
                text = "Изменить помещение";
                break;

            case query.getQueryType.GET_VOLUNTEER:
                text = "Изменить волонтера";
                break;
        }

        return (
            <Button primary onClick={() => this.handleButtonClick(queryType)}>
                {text}
            </Button>
        );
    };

    renderEmptyObject = (object) => {
        if (object === null || object === undefined) {
            return (
                <h5> Выбранный объект у спортсмена отсутствует </h5>
            );
        }
    };

    renderDetails = (queryType, object) => {
        return (
            <div style = {{ display: "flex",
                            flexDirection: "column",
                            marginRight: "20px",
                            marginLeft: "20px",
                            alignItems: "center"
                         }}>
                <Details
                    queryType={queryType}
                    object={object}
                />

                {this.renderEmptyObject(object)}

                {this.renderButton(queryType)}
            </div>
        );
    }

    renderInformation = () => {
        if (this.state.choosing) {
            return
        }

        return (
            <div style = {{ display: "flex",
                            flexDirection: "row",
                            marginRight: "20px",
                            marginLeft: "20px",
                         }}>
                {this.renderDetails(query.getQueryType.GET_SPORTSMAN,
                                        this.state.sportsman)}

                {this.renderDetails(query.getQueryType.GET_ACCOMMODATION,
                                        this.state.accommodation)}

                {this.renderDetails(query.getQueryType.GET_VOLUNTEER,
                                        this.state.volunteer)}
            </div>
        );
    }

    renderChoosingFromList = () => {
        if (!this.state.choosing) {
            return
        }

        return (
            <div>
                <h3> Выберите из списка объект, на который нужно заменить: </h3>

                <SpecifiedList
                    columns={this.state.columns}
                    data={this.state.data}
                    onRowClick={this.onRowClick}
                    queryType={this.state.queryType}
                />
            </div>
        );
    }

    render() {

        return (
            <div>
                {this.renderInformation()}
                {this.renderChoosingFromList()}
            </div>
        );
    };
}

export default Sportsman;
