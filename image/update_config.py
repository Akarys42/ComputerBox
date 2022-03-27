#!/usr/bin/env python3

import sys
import re

with open(".config") as file:
    config = file.read()

for argument in sys.argv[1:]:
    key, *_ = argument.split("=")
    new_config = re.sub(f".*{key}.*", argument, config, count=1)

    if new_config == config:
        new_config += "\n" + argument
    config = new_config

with open(".config", "w") as file:
    file.write(config)
