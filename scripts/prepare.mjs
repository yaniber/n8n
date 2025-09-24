#!/usr/bin/env node

import { execSync } from "node:child_process";

// Skip lefthook install in CI, Docker build, or Heroku production deployment
// Heroku check prevents ELIFECYCLE errors during production install when
// lefthook (devDependency) is not available
if (
	process.env.CI ||
	process.env.DOCKER_BUILD ||
	process.env.NODE_ENV === "production" ||
	process.env.DYNO ||
	process.env.HEROKU_APP_NAME
) {
	process.exit(0);
}

execSync("pnpm lefthook install", { stdio: "inherit" });
