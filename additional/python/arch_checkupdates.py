#!/usr/bin/python3

#   arch-checkupdates: Safely print a list of pending updates.

import os
import sys
from subprocess import Popen, PIPE, DEVNULL

def check_path(fspath: str, message: str):
    if not os.path.exists(fspath):
        sys.exit(message)

def run_wait(exepath: str, args: list, err_raise = False, err_msg: str = f'run_wait: stderr') -> list:
    check_path(exepath, f'run_wait: Cannot find exepath {exepath}')

    process = Popen([exepath] + args, stdout=PIPE, stderr=PIPE)
    stdout, stderr = process.communicate()

    if err_raise:
        if stderr:
            sys.exit(err_msg)
    return stdout.decode('utf-8').splitlines()

def arch_checkupdates() -> list:
    uid = os.getuid()
    chkupdates_db = f'/tmp/checkup-db-{uid}'

    if os.path.isfile(f'{chkupdates_db}/db.lck'):
        os.remove(f'{chkupdates_db}/db.lck')

    dbpath = run_wait('/usr/bin/pacman-conf', ['DBPath'])[0]
    try:
        check_path(dbpath, 'DB path not found')
    except:
        dbpath = '/var/lib/pacman/'

    if not os.path.exists(chkupdates_db):
        os.makedirs(chkupdates_db)
    if not os.path.exists(f'{chkupdates_db}/local'):
        os.symlink(f'{dbpath}/local', f'{chkupdates_db}/local', target_is_directory=True)
    run_wait('/usr/bin/pacman', ['-Sy', '--dbpath', chkupdates_db, '--logfile', '/dev/null'], True,'Cannot fetch updates')

    updates = list()
    updates = run_wait('/usr/bin/pacman', ['-Qu', '--dbpath', chkupdates_db])
    return updates