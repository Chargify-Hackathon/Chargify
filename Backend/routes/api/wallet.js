var express = require("express");
var router = express.Router();
const passport = require("passport");
const mongoose = require("mongoose");

const Wallet = require("../../models/Wallet");

router.post(
    "/create",
    passport.authenticate("jwt", { session: false }),
    async (req, res) => {

        Wallet.findOne({ owner: req.body.user.id })
        .then((wallet) =>{
            if(wallet){
                console.log(wallet);
                return res.status(400).json({wallet: "Wallet already exists"})
            }
            else
            {
                const Owner = {
                    id: req.body.user.id,
                    username: req.body.user.username,
                    email: req.body.user.email,
                }
        
                const currencyType = req.body.currencyType;
                const amount = req.body.amount;
        
                const NEW_WALLET = new Wallet({
                    owner: Owner,
                    currencyType: currencyType,
                    amount: amount
                });
                NEW_WALLET.save().then((wallet) => res.json(wallet));
            }
        });
    }
);

router.patch(
    "/add",
    passport.authenticate("jwt", { session: false }),
    async (req, res) => {


        const owner = req.body.owner;
        let amount = req.body.amount;

        Wallet.findOneAndUpdate(
            {owner: owner},
            {$inc: {"amount": amount}},
            {new: true}
        )
        .then((wallet) => {
            res.json(wallet)
        })
        .catch((err) => console.log(err));
});

router.patch(
    "/pay",
    passport.authenticate("jwt", { session: false }),
    async (req, res) => {


        const from = req.body.from;
        const to = req.body.to;
        let amount = req.body.amount;

        Wallet.findOneAndUpdate(
            {owner: to},
            {$inc: {"amount": amount}},
            {new: true}
        ).then((wallet) => console.log(wallet));


        Wallet.findOneAndUpdate(
            {owner: from},
            {$inc: {"amount": amount * -1}},
            {new: true}
        )
        .then((wallet) => {
            res.json(wallet)
        })
        .catch((err) => console.log(err));
});

module.exports = router; 
