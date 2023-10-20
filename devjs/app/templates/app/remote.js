// https://medium.com/@trivedidarshan30/remote-debugging-in-puppeteer-to-debug-browser-automation-709b6a578d
const puppeteer = require('puppeteer');

async function start() {
    const browser = await puppeteer.launch({
     executablePath: "google-chrome",
     headless: true,
     args: ['--remote-debugging-port=9222', '--remote-debugging-address=0.0.0.0', '--no-sandbox'],
    });

    const page = await browser.newPage();

    eval(require('locus'));

    // start crconsole
    await page.goto("http://127.0.0.1:8080/breakpoint.html");
    // await page.reload();

    const version = await browser.version();
    console.log(version)

    // Close browser.
    await browser.close();
}

start();
