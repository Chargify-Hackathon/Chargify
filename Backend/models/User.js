const mongoose = require("mongoose");
const Schema = mongoose.Schema;



const UserSchema = new Schema({
    username: {
        type: String,
        required: true,
        unique: true,
    },

    email: {
        type: String,
        required: true,
        unique: true,
        
    },

    password: {
        type: String, 
        required: true,
    },

    vehicle: {
        type: String, 
        required: false,
    },
    
    userType: {
        type: String,
        enum: ['ServiceProvider', 'ServiceUser'],
        rquired: true
    },

    location: {
        type: String, 
        coordinate: [Number],
    },

    image: {
        type: String,
    },

    // INR/unit
    rate: {
        type: Number
    },

    /* TODO: Scope expansion if a user 
     has multiple chargers
    
     chargers: {
        type: [Object],
    }*/

});

module.exports = User = mongoose.model("users", UserSchema);
