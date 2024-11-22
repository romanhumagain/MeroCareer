const mongoose = require('mongoose')
const bcrypt = require('bcrypt')

const userSchema = new mongoose.Schema(
  {
    first_name: {
      type: String,
      required: true
    },
    last_name: {
      type: String,
      required: true
    },
    username: {
      type: String,
      required: true,
      lowercase: true
    },
    email: {
      type: String,
      unique: true,
      required: true,
      lowercase: true
    },
    password: {
      type: String,
      required: true
    },
  }
);

userSchema.pre("save", async function (next) {
  if(!this.isModified('password')){
    next();
  }
  salt = await bcrypt.genSalt(10)
  this.password = await bcrypt.hash(this.password, salt)
  next();

});

const User = mongoose.model('User', userSchema)
module.exports = User; 