#!/usr/bin/env bash

# check for files in "some list of directories" matching "some list of suffixes"

# upload them somewhere, and delete them when done
# could've just made some record of which files we uploaded, but if these are completed files, "pine" shouldn't need them around afterward.

# test command that worked:
# lftp sftp://archive:changeme@sftp -e 'set sftp:auto-confirm yes; put -O 2022/11/07 testpants; bye'

