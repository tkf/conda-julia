#!/usr/bin/env python
from __future__ import print_function

import os
import subprocess


def patchelf(*args, **kwds):
    with open(os.devnull) as devnull:
        kwds_eff = dict(dict(
            stderr=devnull,
            universal_newlines=True,
        ), **kwds)
        return subprocess.check_output(('patchelf',) + args, **kwds_eff)


def fix_rpath(files, dry_run, prepend):
    for elfpath in files:
        try:
            stdout = patchelf('--print-rpath', elfpath)
        except subprocess.CalledProcessError:
            continue
        rpath_orig = stdout.strip()
        rpaths = [p for p in rpath_orig.split(':') if not p.startswith('/')]
        if prepend:
            for p in reversed(prepend):
                if p not in rpaths:
                    rpaths.insert(0, p)
        rpath_new = ':'.join(rpaths)
        if rpath_new != rpath_orig:
            print()
            print('Set RPATH of', elfpath, 'to:')
            print(rpath_new)
            print('from:')
            print(rpath_orig)
            if not dry_run:
                patchelf('--set-rpath', rpath_new, elfpath, stderr=None)


def main(args=None):
    import argparse
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--dry-run', action='store_true')
    parser.add_argument('--prepend', action='append')
    parser.add_argument(
        'files', nargs='*', metavar='FILE',
        help='path to files')
    ns = parser.parse_args(args)
    fix_rpath(**vars(ns))


if __name__ == '__main__':
    main()
