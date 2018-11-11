#!/usr/bin/env python3

import sys
import secrets


try:
    length = int(sys.argv[1])
except IndexError:
    length = None

print(secrets.token_urlsafe(length))
