import React from 'react';
import Details from './details';
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

        console.log(this.state);
    }

    renderDetails = (queryType, object) => {
        return (
            <div style = {{ leftMargin: "50px",
                            rightMargin: "50px" }}>
                <Details
                    queryType={queryType}
                    object={object}
                />
            </div>
        );
    }

    render() {
        return (
            <div style = {{ display: "flex",
                            flexDirection: "row",
                            margin: "auto"
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
