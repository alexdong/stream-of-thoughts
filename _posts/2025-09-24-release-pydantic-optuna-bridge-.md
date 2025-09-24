---
layout: post
title: "Release `pydantic-optuna-bridge`"
date: 2025-09-24 15:46
comments: true
categories:
  - python
  - ai-optimization
  - optuna
---

Today I shipped `pydantic-optuna-bridge`, a helper library that keeps the
[Optuna search spaces](https://optuna.readthedocs.io/en/stable/tutorial/10_key_features/002_configurations.html)
in sync with an underlying Pydantic model. The library is now on
[PyPI at version 0.1.1](https://pypi.org/project/pydantic-optuna-bridge/) and
available via `uv add pydantic-optuna-bridge`.

The core idea is a reflection of the Single Responsibility Principle.

1. Describe the hyperparameters, their types, and available options once in
   Pydantic. This way we can leverage Pydantic to validate configs loaded from
   JSON, YAML, environment variables, or a CLI.
2. Decorate the model with `@optuna_config` to generate an Optuna search space.
   Let the bridge derive the matching Optuna distributions. Constrained fields
   (`Gt`, `Lt`, `Ge`, `Le`, `Annotated`) become bounded numeric searches, enums
   stay enums. (Log-scaling or categorical weights are also supported as optional
   parameters in the decorator.)
3. In Optuna's `objective` function, the code can call
   `Model.from_optuna_trial(trial)` to receive the `trial.suggest_*` calls from
   the bridge on the fly. The bridge never sees the results of the training runs
   and it really does not care about the objective function.

Here is the end-to-end flow you may find useful to refer to:

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

If you use Optuna and already lean on Pydantic to validate configs, this bridge
keeps the two sources of truth from drifting apart. Feedback and pull requests
are welcome.
