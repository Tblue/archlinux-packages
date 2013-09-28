# evrouter package (slighty patched version)

This is my personal, patched version of the
[evrouter](https://aur.archlinux.org/packages/evrouter/) package.

Besides cleaning up some of the code, my patch implements
the following changes (if I remember correctly... It has been
a while since I wrote the patch):

- Allow evrouter to handle devices that suddenly disappear while it is
  running. Previously, it probably just crashed.
- Write the PID to the lockfile. This allows us to handle
  stale lockfiles nicely, minimizing the need for user intervention.
