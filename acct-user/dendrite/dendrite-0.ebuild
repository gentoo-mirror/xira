# Copyright 2023 Kirixetamine <revelation@krxt.dev>
# Distributed under the terms of the ISC License

EAPI=8

inherit acct-user

DESCRIPTION="Account for the dendrite homeserver"
ACCT_USER_ID=-1
ACCT_USER_GROUPS=( dendrite )
ACCT_USER_HOME=/var/lib/dendrite
ACCT_USER_HOME_PERMS=0700

acct-user_add_deps
