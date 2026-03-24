# EDGE_IA

Workspace reproduzível para análise do EDGE_IA, extração de dados Binance e migração da estratégia EMA 20/50 para Jesse.

Ele é um workspace de pesquisa com:
- dados históricos já baixados;
- artefatos do backtest;
- scripts auxiliares para reproduzir a estratégia;
- documentação da migração e do diagnóstico.

## O que entra no Git

Arquivos e diretórios que fazem parte do repositório público:

- [README.md](./README.md)
- [README_MIGRACAO.md](./README_MIGRACAO.md)
- [scripts/](./scripts)
- [data/binance/BTCUSDT_1h.csv](./data/binance/BTCUSDT_1h.csv)
- [outputs/backtest/](./outputs/backtest)
- [.gitignore](./.gitignore)

O conteúdo de `outputs/backtest/` é intencionalmente versionado porque documenta o resultado obtido.

## O que sai do Git

Itens que não devem ser publicados:

- `.venv/`
- `.env`
- `.env.*` exceto exemplos
- `nofx/`
- `jesse/`
- `__pycache__/`
- `*.pyc`, `*.pyo`, `*.pyd`
- `.DS_Store`
- `Thumbs.db`
- arquivos temporários e logs

Esses caminhos já estão cobertos por [`.gitignore`](./.gitignore).

## Estrutura

```text
EDGE_IA/
├── README.md
├── README_MIGRACAO.md
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

## Como reproduzir

### 1. Backtest local do workspace

```bash
cd /Users/gustavomedeiros/Desktop/NFX_IA
bash scripts/prepare_backtest.sh
```

Esse comando valida o dataset `BTCUSDT_1h.csv` e executa o backtest auxiliar.

### 2. Ambiente Jesse separado

O Jesse foi movido para uma pasta exclusiva fora deste repositório:

- `/Users/User/Desktop/jesse`

Se você quiser o dashboard do Jesse, rode o bootstrap a partir do diretório dele:

```bash
cd /Users/User/Desktop/jesse
bash scripts/bootstrap_jesse.sh
```

## Notas de publicação

Antes de publicar este repositório no GitHub:

1. garanta que `nofx/` e `jesse/` não sejam adicionados ao commit;
2. mantenha `data/binance/BTCUSDT_1h.csv` apenas se você quiser publicar o dataset reproduzível;
3. mantenha `outputs/backtest/` apenas se quiser publicar os resultados e o rastro do experimento;
4. se preferir um repositório mais leve, remova `data/` e `outputs/` e atualize esta documentação.

## Resultado do projeto

O backtest base foi uma estratégia simples:

- ativo: `BTCUSDT`
- timeframe: `1h`
- entrada: cruzamento da EMA 20 acima da EMA 50
- saída: cruzamento da EMA 20 abaixo da EMA 50
- sem short
- sem stop loss
- sem take profit
- fee configurável

Os detalhes completos da migração estão em [README_MIGRACAO.md](./README_MIGRACAO.md).
