module.exports = ( user ) => {
  let username = `${user}-${Math.random()}`
  let password = `${Math.random()}`;
  // Make sure both usernames and passwords are strings
  username = String( username );
  password = String( password );
  const fullname = "John Doe"
  let credential = { fullname, username, password };
  return credential;
}
