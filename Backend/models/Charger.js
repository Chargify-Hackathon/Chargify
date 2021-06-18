const mongoose = require("mongoose");
const Schema = mongoose.Schema;
const GeoJson = require('mongoose-geojson-schema');

/* 
TODO: When a request is made for a location
we also need to send the ID for that location
then the IDs have to be mapped

when you click on the ID, it should show the status
*/
const ChargerSchema = new Schema({
    owner: {
        type: Object,
        required: true
    }, 

    location: {
        type: Schema.Types.Point,
        required: true
    },

    // INR/unit
    rate: {
        type: Number
    },

    status: {
        type: String,
        enum: [
            'available', 
            'unavailable', 
            'busy'
        ],
        default: 'available',
    },
    
});

module.exports = Charger = mongoose.model("charger", ChargerSchema);