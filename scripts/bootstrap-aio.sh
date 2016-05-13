#!/bin/bash

set -o xtrace

scripts/bootstrap-roles.sh
scripts/bootstrap-group_vars.sh
scripts/bootstrap-inventory.sh
