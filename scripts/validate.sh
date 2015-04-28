#!/bin/bash
$@ | awk -f ./scripts/validation.awk
