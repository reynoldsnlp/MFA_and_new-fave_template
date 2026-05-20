# mfa-and-new-fave-with-uv

Example of using `uv` to use MFA and new-fave together.

## Setup scripts

- POSIX: `./scripts/setup_uv_env.sh`
- Windows (PowerShell): `./scripts/setup_uv_env.ps1`

Both scripts install `uv` if needed, create a `.venv`, install
`montreal-forced-aligner` and `new-fave`, and run `scripts/toy_import_check.py`.

## CI

GitHub Actions workflow `.github/workflows/test-uv-setup-scripts.yml` runs the setup
scripts on Ubuntu, macOS, and Windows.
