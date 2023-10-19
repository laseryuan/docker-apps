// https://medium.com/@trivedidarshan30/remote-debugging-in-puppeteer-to-debug-browser-automation-709b6a578d
const puppeteer = require('puppeteer');

async function start() {
 // headless: true,
 // headless: false,
 // executablePath: "google-chrome",
 // devtools: true,
const browser = await puppeteer.launch({
 executablePath: "google-chrome",
 headless: true,
 args: ['--remote-debugging-port=9222', '--remote-debugging-address=0.0.0.0', '--no-sandbox'],
});

const page = await browser.newPage();

await page.goto('https://youtube.com/', {waitUntil: 'networkidle0'});

const filePath = 'file://'+'/home/node/node_app/app/breakpoint.html';
eval(require('locus'));

// start crconsole
await page.goto(filePath);
// await page.reload();

const version = await browser.version();
console.log(version)

// Close browser.
await browser.close();
}

start();
