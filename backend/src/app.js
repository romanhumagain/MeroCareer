const express = require('express')
const cors = require('cors')
const bodyParser = require('body-parser')

const app = express();
app.use(bodyParser.json());
app.use(cors())

// endpoints
app.use('/api/user', require('./routes/userRoutes'))

module.exports = app;
