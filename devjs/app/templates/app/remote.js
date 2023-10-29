const puppeteer = require('puppeteer');

async function start() {
    const browser = await puppeteer.launch({
     executablePath: "google-chrome",
     headless: "new",
     args: ['--remote-debugging-port=9222', '--remote-debugging-address=0.0.0.0', '--no-sandbox'],
    });

    const page = await browser.newPage();

    // Configure the navigation timeout
    await page.setDefaultNavigationTimeout(0);

    // debugger;
    eval(require('locus'));
    // start crconsole

    // await page.goto( "http://app:3000/breakpoint.html" );
    // await page.reload();

    const version = await browser.version();
    console.log(version)

    // Close browser.
    await browser.close();
}

start();
