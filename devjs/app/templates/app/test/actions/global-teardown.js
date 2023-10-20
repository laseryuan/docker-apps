https://github.com/argos-ci/jest-puppeteer/blob/main/packages/jest-dev-server/README.md

const { teardown: teardownDevServer } = require("jest-dev-server");

module.exports = async function globalTeardown() {
  await teardownDevServer(globalThis.servers);
  // Your global teardown
};
