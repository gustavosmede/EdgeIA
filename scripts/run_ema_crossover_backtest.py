#!/usr/bin/env python3
from pathlib import Path
import runpy
import sys


ROOT = Path(__file__).resolve().parents[1]
TARGET = (ROOT / ".." / "jesse" / "scripts" / "run_ema_crossover_backtest.py").resolve()

if not TARGET.exists():
    raise SystemExit(f"Missing delegated runner: {TARGET}")

sys.argv[0] = str(TARGET)
runpy.run_path(str(TARGET), run_name="__main__")
