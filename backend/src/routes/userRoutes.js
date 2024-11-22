const express = require('express')
const {registerUser} = require('../controllers/userControllers')

const router = express.Router();

// api endpoints 
router.post('/register', registerUser)

module.exports = router;