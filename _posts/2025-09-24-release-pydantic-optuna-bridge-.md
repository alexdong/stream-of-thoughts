---
layout: post
title: "Release `pydantic-optuna-bridge`"
date: 2025-09-24 15:46
comments: true
categories:
  - ai-optimization
  - python
  - open-source
---

Today I shipped `pydantic-optuna-bridge`, a tiny helper that keeps my Optuna
search spaces and Pydantic models in sync. I extracted the metadata helpers
from the `kaggle-map` project where I was hand-rolling the same glue on every
experiment. The library is now on PyPI at version 0.1.1.

The core idea: describe the hyperparameters once in Pydantic, decorate the
model, and let the bridge derive the matching Optuna distributions. Constrained
fields (`Gt`, `Lt`, `Ge`, `Le`, `Annotated`) become bounded numeric searches,
enums stay enums, and I can control log-scaling or categorical weights without
any extra wiring. Optuna never sees the raw metadata—it just receives
`trial.suggest_*` calls that `pydantic-optuna-bridge` generates on the fly.

Here is the end-to-end flow I keep coming back to:

```python
from enum import Enum
from typing import Annotated

import optuna
from annotated_types import Gt, Lt
from pydantic import BaseModel

from pydantic_optuna_bridge import optuna_config


class Optimizer(str, Enum):
    ADAM = "adam"
    SGD = "sgd"
    RMSPROP = "rmsprop"


@optuna_config(log_scale_fields={"learning_rate"})
class TrainingConfig(BaseModel):
    optimizer: Optimizer
    learning_rate: Annotated[float, Gt(1e-5), Lt(1.0)]
    hidden_units: Annotated[int, Gt(32), Lt(256)]


def objective(trial: optuna.trial.Trial) -> float:
    config = TrainingConfig.from_optuna_trial(trial)
    return do_training_run(config)
```

The decorator attaches everything to `json_schema_extra`, so the metadata is
available for docs, validation reports, or a CLI. Install the optional
`[cli]` extra to get a quick inspection command:

```bash
uv run -m pydantic_optuna_bridge
```

If you use Optuna and already lean on Pydantic to validate configs, this bridge
keeps the two sources of truth from drifting apart. Feedback and pull requests
are welcome.
