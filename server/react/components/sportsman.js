import React from 'react';
import Details from './details';
import SpecifiedList from './list-view';
import { Button } from 'semantic-ui-react';
import { allQuery, getQuery } from '../actions';
let query = require('../query');

const center = {
    display: "flex",
    flexDirection: "column",
    justifyContent: "center",
    alignItems: "center",
    marginBottom: "20px"
};

class Sportsman extends React.Component {
    constructor(props) {
        super(props);

        // I've no idea why I should get .object
        let sportsman = Object.assign({}, this.props.object);
        let accommodation = sportsman.accommodation;
        let volunteer = sportsman.volunteer;

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

        let handler = (menu, response) => {
            let sportsmanId = `$id=${this.state.sportsman.id}`;
            let accommodationId, volunteerId;
            let object = response.object;
            let params = "";

            let changedInformation = null;
            switch (createdGetQuery) {
                case query.getQueryType.GET_ACCOMMODATION:
                    this.setState({accommodation : object});
                    accommodationId = `$accommodation_id=${id}`;
                    volunteerId = `$volunteer_id=${this.state.volunteer.id}`;
                    params = `${sportsmanId}&${accommodationId}&${volunteerId}`;
                    changedInformation = "accommodation";
                    break;

                case query.getQueryType.GET_VOLUNTEER:
                    this.setState({volunteer : object});
                    accommodationId = `$accommodation_id=${this.state.accommodation.id}`;
                    volunteerId = `$volunteer_id=${id}`;
                    params = `${sportsmanId}&${accommodationId}&${volunteerId}`;
                    changedInformation = "volunteer";
                    break;
            }

            let setHandler = response => {
                console.log(response);

                let menu = this.props.menu;

                if (response.type === 'error') {
                    menu.setError(response.message);
                    return;
                }

                recievedResponse = response.result;

                this.setState({
                    choosing: false,
                    changedInformation: recievedResponse
                });
            };

            query.sendQuery(query.setQueryType.SET_SPORTSMEN, params, setHandler.bind(this));
        }

        getQuery(id, createdGetQuery, this.props.menu, handler.bind(this));
    }

    handleButtonClick = (queryType) => {
        let handler = (menu, response) => {
            this.setState({
                choosing: true,
                data: response.tableBody,
                columns: response.tableHeader,
                queryType
            });
        }

        allQuery(queryType, this.props.menu, handler.bind(this));
    }

    renderButton = (queryType) => {
        let text = "";

        switch (queryType) {
            case query.allQueryType.ALL_SPORTSMEN:
                return;
                break;

            case query.allQueryType.ALL_ACCOMMODATIONS:
                text = "Изменить помещение";
                break;

            case query.allQueryType.ALL_VOLUNTEERS:
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

    renderDetails = (getQueryType, allQueryType, object) => {
        return (
            <div style = {{ display: "flex",
                            flexDirection: "column",
                            marginRight: "20px",
                            marginLeft: "20px",
                            alignItems: "center"
                         }}>
                <Details
                    queryType={getQueryType}
                    object={object}
                />

                {this.renderEmptyObject(object)}

                {this.renderButton(allQueryType)}
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
                                    query.allQueryType.ALL_SPORTSMEN,
                                        this.state.sportsman)}

                {this.renderDetails(query.getQueryType.GET_ACCOMMODATION,
                                    query.allQueryType.ALL_ACCOMMODATIONS,
                                        this.state.accommodation)}

                {this.renderDetails(query.getQueryType.GET_VOLUNTEER,
                                    query.allQueryType.ALL_VOLUNTEERS,
                                        this.state.volunteer)}
            </div>
        );
    }

    renderChoosingFromList = () => {
        if (!this.state.choosing) {
            return
        }

        return (
            <div style={center}>
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
