#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
JESSE_DIR="${ROOT_DIR}/../jesse"
VENV_DIR="${ROOT_DIR}/.venv"
PYTHON_BIN="${PYTHON_BIN:-python3.11}"

if ! command -v "${PYTHON_BIN}" >/dev/null 2>&1; then
  PYTHON_BIN="python3"
fi

if [[ ! -d "${VENV_DIR}" ]]; then
  "${PYTHON_BIN}" -m venv "${VENV_DIR}"
fi

source "${VENV_DIR}/bin/activate"
python -m pip install --upgrade pip
python -m pip install -r "${JESSE_DIR}/requirements.txt"
python -m pip install -e "${JESSE_DIR}"

if ! command -v redis-server >/dev/null 2>&1; then
  brew install redis
fi

if ! command -v psql >/dev/null 2>&1; then
  brew install postgresql@14
fi

if ! brew list redis >/dev/null 2>&1; then
  brew install redis
fi

if ! brew list postgresql@14 >/dev/null 2>&1; then
  brew install postgresql@14
fi

brew services start redis >/dev/null 2>&1 || true
brew services start postgresql@14 >/dev/null 2>&1 || true

export PATH="/opt/homebrew/opt/postgresql@14/bin:${PATH}"

for _ in 1 2 3 4 5; do
  if psql -d postgres -c "SELECT 1" >/dev/null 2>&1; then
    break
  fi
  sleep 2
done

if ! psql -d postgres -c "SELECT 1" >/dev/null 2>&1; then
  echo "PostgreSQL is not accepting local connections yet. Start the service manually with: brew services start postgresql@14" >&2
  exit 1
fi

psql -d postgres <<'SQL'
DO $$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'jesse_user') THEN
      CREATE ROLE jesse_user LOGIN PASSWORD 'password';
   END IF;
END
$$;
SQL

if ! psql -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname = 'jesse_db'" | grep -q 1; then
  createdb -O jesse_user jesse_db
fi

cp "${JESSE_DIR}/.env.example" "${JESSE_DIR}/.env"

cd "${JESSE_DIR}"
exec "${VENV_DIR}/bin/jesse" run
