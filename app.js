const createError = require('http-errors');
const express = require('express');
const path = require('path');
const cookieParser = require('cookie-parser');
const logger = require('morgan');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');


const users = require('./routes/api/users');
const charger = require('./routes/api/charger');
const wallet = require("./routes/api/wallet");


const app = express();

app.use(
  bodyParser.urlencoded({
    limit: "25mb",
    extended: true,
  })
);

app.use(logger('dev'));
app.use(express.json());
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// Get DB Key
const db = require("./config/key").mongoURI;
const passport = require('passport');
const { default: validator } = require('validator');

// Connect to MongoDB
mongoose
  .connect(db, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    ssl: true,
    sslValidate:true,
    sslCA: require('fs').readFileSync(`${__dirname}/certs/6110838a-f63c-11e9-b889-bad5fb6348ac`)
  })
  .then(() => console.log("MongoDB Connected"))
  .catch((err) => console.log(err));
mongoose.set('useFindAndModify', true);

app.use(passport.initialize());

require("./config/passport")(passport);

app.use('/api/users', users);
app.use('/api/charger', charger);
app.use("/api/wallet", wallet);


const port = 8080;

app.listen(port, () => 
  console.log(`Server up and running on port ${port}`));


module.exports = app;
