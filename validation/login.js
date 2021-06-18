const validator = require("validator");
const isEmpty = require("is-empty");

module.exports = function validateRegisterInput(data) {
  let errors = {};

  const username = data.username;
  const password = data.password;
  const email = data.email;
  
  // min length 5, accepts uppercase, lowercase, number and _
  const usernameRegex = /^[a-zA-Z0-9_]{5,}[a-zA-Z]+[0-9]*$/;
  // Email regex for all domains
  const emailRegex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  // Minimum 8 characters, one uppercase, one lowercase, one number, one special character
  const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/; 
  

  if(usernameRegex.test(username)) errors.username = "username invalid";
  
  if(passwordRegex.test(password)) errors.password = "password invalid";
  

  return {
    errors,
    isValid: isEmpty(errors),
  };
};
