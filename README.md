# EDGE_AI

A reproducible workspace for **EDGE_AI** analysis, Binance data extraction, and the migration of the EMA 20/50 strategy to Jesse.

This research workspace includes:
* Pre-downloaded historical data.
* Backtest artifacts.
* Helper scripts to reproduce the strategy.
* Migration and diagnostic documentation.

---

## What stays in Git

Files and directories that are part of the public repository:

* [README.md](./README.md)
* [README_MIGRATION.md](./README_MIGRATION.md)
* [scripts/](./scripts)
* [data/binance/BTCUSDT_1h.csv](./data/binance/BTCUSDT_1h.csv)
* [outputs/backtest/](./outputs/backtest)
* [.gitignore](./.gitignore)

> **Note:** The content within `outputs/backtest/` is intentionally versioned to document the specific results obtained during research.

## What stays out of Git

Items that should **not** be published:

* `.venv/`
* `.env` and `.env.*` (except for examples)
* `nofx/`
* `jesse/`
* `__pycache__/`, `*.pyc`, `*.pyo`, `*.pyd`
* `.DS_Store`, `Thumbs.db`
* Temporary files and logs

These paths are already managed by the [`.gitignore`](./.gitignore) file.

---

## Structure

```text
EDGE_IA/
├── README.md
├── README_MIGRATION.md
├── .gitignore
├── data/
│   └── binance/
│       └── BTCUSDT_1h.csv
├── outputs/
│   └── backtest/
│       ├── README.md
│       ├── equity_curve.csv
│       ├── summary.json
│       └── trades.csv
└── scripts/
    ├── bootstrap_jesse.sh
    ├── prepare_backtest.sh
    └── run_ema_crossover_backtest.py
```

---

## How to Reproduce

### 1. Local Workspace Backtest
To validate the dataset and run the auxiliary backtest, execute:

```bash
cd /Users/User/Desktop/NFX_IA
bash scripts/prepare_backtest.sh
```

### 2. Separate Jesse Environment
Jesse has been moved to an exclusive folder outside of this repository:
* `/Users/User/Desktop/jesse`

If you want to use the Jesse dashboard, run the bootstrap from its specific directory:

```bash
cd /Users/User/Desktop/jesse
bash scripts/bootstrap_jesse.sh
```

---

## Publication Notes

Before pushing this repository to GitHub:
1. Ensure that `EDGE_IA/` and `jesse/` internal system files are not added to the commit.
2. Keep `data/binance/BTCUSDT_1h.csv` only if you intend to publish the reproducible dataset.
3. Keep `outputs/backtest/` only if you want to share the results and the "paper trail" of the experiment.
4. For a lighter repository, remove `data/` and `outputs/` and update this documentation accordingly.

---

## Project Results

The baseline backtest followed a straightforward strategy:
* **Asset:** `BTCUSDT`
* **Timeframe:** `1h`
* **Entry:** EMA 20 crossing above EMA 50.
* **Exit:** EMA 20 crossing below EMA 50.
* **Shorting:** Disabled.
* **Stop Loss / Take Profit:** None.
* **Fees:** Configurable.

Full migration details can be found in [README_MIGRATION.md](./README_MIGRATION.md).
