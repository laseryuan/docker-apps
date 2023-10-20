// https://github.com/argos-ci/jest-puppeteer/blob/main/packages/jest-dev-server/README.md

const { setup: setupDevServer } = require("jest-dev-server");

module.exports = async function globalSetup() {
  globalThis.servers = await setupDevServer({
    command: `node config/start.js --port=3000`,
    launchTimeout: 50000,
    port: 3000,
  });
  // Your global setup
};
