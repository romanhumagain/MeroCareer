const mongoose = require('mongoose')
const User = require('../models/userModels')


const handleServerError = async (error, res) => {
  res.status(500).json({detail:error.message})
  console.log(error)
}

const registerUser = async (req, res) => {
  try {
    const { first_name, last_name, username, email, password } = req.body;

    const existing_user = await User.findOne({ email: email })
    if (existing_user) {
      return res.status(400).json({ detail: 'Email already exists !' })
    }

    const user = User({ first_name, last_name, username, email, password })
    await user.save();
    res.status(201).json({ user, detail: 'Successfully created user.' })
  }
  catch (error) {
    handleServerError(error, res)
  }
}

module.exports = {registerUser}