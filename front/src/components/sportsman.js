import React from 'react';
import Details from './details';
import { Button } from 'semantic-ui-react'
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
            accommodation
        }
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
            <Button primary> {text} </Button>
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

    render() {
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
    };
}

export default Sportsman;
