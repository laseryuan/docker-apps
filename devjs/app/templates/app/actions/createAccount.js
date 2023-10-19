const chalk = require( 'chalk' );

class createAccount {
  constructor( page ) {
    this.url = "http://127.0.0.1:8080/"
    this.page = page;
    this.signupBtn = '#signup';
    this.signupBody = '#signupBody';
    this.fullnameField = '#fullname';
    this.usernameField = '#username';
    this.passwordField = '#password';
    this.loginPageBtn = '#loginBtn';
    this.signupPageBtn = '#signupBtn';
  }

  async signup( fullname, username, password ) {
    try {
      await this.page.goto( this.url );
      await this.page.waitForSelector( this.signupBtn );
      await this.page.click( this.signupBtn );
      // Wait for the signupBody on the signup page to load
      await this.page.waitForSelector( this.signupBody );

      // Type the login credentials into the input fields
      await this.page.type( this.fullnameField, fullname );
      await this.page.waitForTimeout( 1000 );
      await this.page.type( this.usernameField, username );
      await this.page.waitForTimeout( 1000 );
      await this.page.type( this.passwordField, password );
      await this.page.waitForTimeout( 1000 );

      // Click then create account button
      await this.page.click( this.signupPageBtn );

      // Wait for homepage to load
      await this.page.waitForSelector( '#firstname' );
      await this.page.waitForTimeout( 2000 );

      const firstname = await this.page.$eval( '#homeBody #firstname', el =>  el.textContent );

      return firstname;
    } catch ( err ) {
      console.log( chalk.red( 'ERROR => ', err ) );
    }
  }
}

module.exports = ( page ) => new createAccount( page );
