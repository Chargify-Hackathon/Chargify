const mongoose = require("mongoose");
const Schema = mongoose.Schema;


/*
owner
currencyType (optional)
amount: 10000 - TxAmount
*/

// Add Money -> Get Coins -> Transfer from A to B


const WalletSchema = new Schema({
    owner: {
        type: Object,
        required: true, 
        unique: true
    },

    currencyType: {
        type: String, 
        required: true, 
    },
    amount: {
        type: Number,
        required: true
    },
    // Txn: {
    //     type: Object,
    //     required: true
    // }
});


module.exports = Wallet = mongoose.model("wallet", WalletSchema);