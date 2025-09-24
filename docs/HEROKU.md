# Heroku Deployment Notes

## Build Fix for ELIFECYCLE Error

### Problem
Heroku builds were failing with "ELIFECYCLE Command failed with exit code 1" during `pnpm install --frozen-lockfile`. 

### Root Cause
The `prepare` lifecycle script runs `pnpm lefthook install` during `pnpm install`, but this requires:
- `pnpm` command (not available during Heroku production install)  
- `lefthook` package (devDependency, not installed in production)

### Solution
Modified `scripts/prepare.mjs` to skip lefthook installation when:
- `NODE_ENV=production` (Heroku sets this)
- `DYNO` or `HEROKU_APP_NAME` environment variables are present (Heroku-specific)

This follows the existing pattern used for CI and Docker builds.

### Testing
To reproduce the issue locally:
```bash
./.github/scripts/diagnose-heroku-pnpm.sh
```

### Why This Fix
- **Minimal**: Only adds environment checks, no dependency changes
- **Safe**: Lefthook is only needed for development git hooks
- **Consistent**: Uses same pattern as existing CI/Docker checks
- **Production-ready**: Heroku deployments don't need git hooks

The `heroku-postbuild` script in package.json handles the actual build process after dependencies are installed.