const express = require('express')
const cors = require('cors')
const dotenv = require('dotenv')
const bodyParser = require('body-parser')

const connectDB = require('./config/db')
const register_user = require('./controllers/userControllers')

dotenv.config()
const PORT = process.env.PORT || 5000

const app = express();
app.use(bodyParser.json());
app.use(cors())

connectDB();


app.listen(PORT, ()=>{
  console.log(`Server is running on port ${PORT}`);
})