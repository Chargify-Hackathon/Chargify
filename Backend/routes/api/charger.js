var express = require("express");
var router = express.Router();
const passport = require("passport");

const Charger = require("../../models/Charger");


router.post(
  "/add",
  passport.authenticate("jwt", { session: false }),
  async (req, res) => {
    const OWNER = {
      id: req.user.id,
      username: req.user.username,
      email: req.user.email,
    };

    const NEW_CHARGER = await new Charger({
      owner: OWNER,
      location: req.body.location,
      rate: req.body.rate,
      status: "available",
    });
    console.log(NEW_CHARGER);
    NEW_CHARGER.save().then((charger) => res.json(charger));
  }
);

router.post(
    "/get",
    //passport.authenticate("jwt", { session: false }),
    async(req, res) => {
        const location = req.body.location;
        const size = req.body.size === undefined ? 5 : req.body.size;
        console.log(size);
        Charger.find({
            location: {
                "$geoWithin":{
                    "$centerSphere": [location, size/6378]
                }
            }
        },
        {
            "stauts": 1,
            "_id": 1,
            "owner": 1,
            "location": 1,
            "rate": 1
        }
        ).then(charger => res.json(charger));
    }
);

router.patch("/change",
    passport.authenticate("jwt", { session: false }),
    async (req, res) => {
        const id = req.body.id;
        const status = req.body.status;
        Charger.findOneAndUpdate(
            {_id: id},
            {$set: {"status": status}},
            {new: true}
        )
        .then((charger) => {
            res.json(charger)
        })
        .catch((err) => console.log(err));
    })

module.exports = router; 