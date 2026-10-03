#!/bin/bash
# Runs simple-interest.sh with fixed (synthetic) answers and compares the result line.
# Usage, from anywhere: bash tests/test-simple-interest.sh
# Needs bash and bc, like the script itself.

cd "$(dirname "$0")/.." || exit 1

failures=0

# check <principal> <years> <rate> <expected result line>
check() {
    local actual
    actual=$(printf '%s\n%s\n%s\n' "$1" "$2" "$3" | bash simple-interest.sh | tail -n 1)
    if [ "$actual" = "$4" ]; then
        echo "ok    p=$1 t=$2 r=$3 -> $actual"
    else
        echo "FAIL  p=$1 t=$2 r=$3 -> '$actual' (expected '$4')"
        failures=$((failures + 1))
    fi
}

check 1000 2 5 100.00
check 100 0.5 10 5.00
# 2500.50 * 1.5 * 4.25 / 100 is 159.406875: bc (scale=2) truncates it, it does not round it.
check 2500.50 1.5 4.25 159.40
# bc prints a plain 0 for a zero result.
check 0 3 7 0

# CRLF line endings make bash fail on every line of the script (see .gitattributes).
if grep -q "$(printf '\r')" simple-interest.sh; then
    echo "FAIL  simple-interest.sh contains CR characters"
    failures=$((failures + 1))
else
    echo "ok    simple-interest.sh has LF line endings"
fi

if [ "$failures" -eq 0 ]; then
    echo "All checks passed."
else
    echo "$failures check(s) failed."
    exit 1
fi
