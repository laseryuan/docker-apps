let createAccount = require( '../actions/global-setup' );
let createAccount = require( '../actions/global-teardown' );

let credentials = require( '../utils/credentials' );
let createAccount = require( '../actions/createAccount' );

jest.setTimeout(60000);

describe('Basic authentication e2e tests', () => {
  let credential;
  beforeAll( async () => {
    // globalSetup(); //start web server

    // Set a definite size for the page viewport so view is consistent across browsers
    await page.setViewport( {
      width: 1366,
      height: 768,
      deviceScaleFactor: 1
    } );

    credential = credentials( 'User' );
    createAccount = await createAccount( page );
  } );

  afterAll( async () => {
    // globalTeardown();
  } );

  it( 'Should be able to create an account', async () => {
    // debugger
    const firstname = await createAccount.signup( credential.fullname, credential.username, credential.password );
    page.waitForTimeout( 1000 );
    expect( credential.fullname ).toContain( firstname );
  })

} );
