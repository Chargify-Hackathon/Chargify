const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const AssignedSchema = new Schema({
    User: {
        type: Object,
        required: true
    },

    Charger: {
        type: Object,
        required: true
    }
});

module.exports = Assigned = mongoose.model("assigned", AssignedSchema);