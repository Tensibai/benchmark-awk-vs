#!/bin/bash
set -ev
$@ | awk -f ./scripts/validation.awk
