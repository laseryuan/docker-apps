https://www.digitalocean.com/community/tutorials/how-to-write-end-to-end-tests-in-node-js-using-puppeteer-and-jest#step-3-running-the-sample-web-interface

## Initiating your Testing Program
```
mkdir end-to-end-test-tutorial
dev
npm -y init
npm install --save-dev jest-puppeteer puppeteer jest locus
```

## Configuring your Testing Program
```
mkdir actions # hold the Puppeteer scripts that will crawl your local web page
mkdir logs # hold the results of your tests
mkdir specs # the tests
mkdir utils # helper files like mock credential generation

npm run e2e
```

## Running the Sample Web Interface
```
git clone https://github.com/do-community/mock-auth.git
npm install -g live-server
cd mock-auth
live-server
```

## Testing Account Creation
```
node inspect `which jest` --runInBand
```
