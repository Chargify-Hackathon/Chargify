const validator = require("validator");
const isEmpty = require("is-empty");

module.exports = function validateRegisterInput(data) {
  let errors = {};

  const username = data.username;
  const password = data.password;
  const email = data.email;
  
  console.log(username);
  console.log(password);
  // min length 5, accepts uppercase, lowercase, number and _
  const usernameRegex = /^(?=[a-zA-Z0-9._]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]$/;
  // Email regex for all domains
  const emailRegex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  // Minimum 8 characters, one uppercase, one lowercase, one number, one special character
  const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/; 
  

  if(!usernameRegex.test(username)) errors.username = "username invalid";
  
  if(!emailRegex.test(email)) errors.email = "email invalid";
  
  if(!passwordRegex.test(password)) errors.password = "password invalid";

// data.username = !isEmpty(data.username) ? data.username : '';
// data.email = !isEmpty(data.email) ? data.email : '';
// data.password = !isEmpty(data.password) ? data.password : '';

// //username check
// if((!validator.isLength(data.username , { min:6, max:30 }))){
//     errors.username = "name must be atleast 6 characters";
// }
// if(validator.isEmpty(data.username)){
//     errors.username = "username is required"
// }

// //email check
// if(validator.isEmpty(data.email)){
//     errors.email("email is required");
// }else if(validator.isEmail(data.email)){
//     errors.email("email is invalid");
// }

// //password check
// if(!validator.isLength(data.password , {min:6, max:30})){
//     errors.password("password must be atleast 6 characters");
// }
// if(validator.isEmpty(data.password)){
//     errors.password("password is required");
//}

return {
    errors,
    isValid: isEmpty(errors)
}

}
