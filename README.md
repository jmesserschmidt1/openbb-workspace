# OpenBB Workspace

Source code for OpenBB Workspace and the components that build and run it.

## Layout

| Directory | What it is |
|---|---|
| `terminalpro/` | The Workspace frontend (React 18 + TypeScript + Vite) |
| `backend-api/` | Backend API (FastAPI + SQLAlchemy), admin CLI, and admin dashboard |
| `lite/` | Docker packaging that assembles OpenBB Lite from the backend and frontend |
| `excel-add-in/` | The OpenBB Add-in for Excel (Office.js, TypeScript/React) |

Each component keeps its own README with setup and development instructions.

## Run it locally

With Docker installed (Docker Desktop on Mac/Windows), from the repo root:

```bash
./run-local.sh          # builds OpenBB Lite from this repo, serves http://localhost:3000
./run-local.sh --stop   # stops it; data stays in the openbb-data volume
```

The script prints the admin login when the app is ready. Print it again with
`docker exec openbb credentials`.

## Notes

- The `.github/workflows/` files inside each component are kept for reference;
  GitHub Actions only executes workflows from a repository's root `.github/`
  directory, so none of them run here as-is. Internal deployment pipelines are
  maintained separately.
- Licensed under Apache-2.0 (see [LICENSE](LICENSE)). Individual components may carry additional notices in their own directories.
