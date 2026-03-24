#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INPUT_CSV="${ROOT_DIR}/data/binance/BTCUSDT_1h.csv"
if [[ ! -f "${INPUT_CSV}" ]]; then
  FALLBACK="${ROOT_DIR}/../jesse/data/binance/BTCUSDT_1h.csv"
  if [[ -f "${FALLBACK}" ]]; then
    mkdir -p "${ROOT_DIR}/data/binance"
    cp "${FALLBACK}" "${INPUT_CSV}"
  else
    echo "Missing input CSV at ${INPUT_CSV} and fallback ${FALLBACK}" >&2
    exit 1
  fi
fi

mkdir -p "${ROOT_DIR}/outputs/backtest"
python3 "${ROOT_DIR}/scripts/run_ema_crossover_backtest.py" \
  --input "${INPUT_CSV}" \
  --output-dir "${ROOT_DIR}/outputs/backtest" \
  --initial-capital 10000 \
  --fee-rate 0.0004
