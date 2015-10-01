#!/bin/bash
set -eu
T=$(mktemp)
trap "rm $T" EXIT
echo '{ "a": 5, "b": {"c": 6, "d": "hello" } }' > $T
python ghetto_json path=$T a=7 b.c=yellow b.d=unset
diff -u <(printf '{\n  "a": 7,\n  "b": {\n    "c": "yellow"\n  }\n}') $T

