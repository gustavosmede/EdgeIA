# Migração NOFX -> Jesse

Este arquivo aponta para a migração prática do backtest EMA20/EMA50.

- Estratégia Jesse: `jesse/strategies/NofxEma20Ema50Crossover/__init__.py`
- Rota Jesse: `jesse/routes.py`
- Runner do workspace: `scripts/run_ema_crossover_backtest.py`
- Preparação do workspace: `scripts/prepare_backtest.sh`

## Como rodar do diretório `NFX_IA`

```bash
bash scripts/prepare_backtest.sh
```

Ou manualmente:

```bash
python3 scripts/run_ema_crossover_backtest.py \
  --input data/binance/BTCUSDT_1h.csv \
  --output-dir outputs/backtest \
  --initial-capital 10000 \
  --fee-rate 0.0004
```

