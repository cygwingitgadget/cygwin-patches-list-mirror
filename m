From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: sched_* functions
Date: Sat, 17 Mar 2001 20:08:00 -0000
Message-id: <20010317230848.B6751@redhat.com>
References: <018c01c0af5c$fe559ed0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q1/msg00204.html

On Sun, Mar 18, 2001 at 02:39:08PM +1100, Robert Collins wrote:
>Don't fall out of your chair chris, here's a second contribution...
>again, probably not perfect right out of the gate, but it works quite
>well.

More comments:

- You can't add fields to external_pinfo.  That's pretty much set in
  stone.  I probably should have added a version number to this structure,
  but... I didn't.

- Please just add appropriate copyrights using other files as guidelines:

	Copyright 2001 Red Hat, Inc.

  is fine.

- Please use GNU coding standards.  I forgot to check this with your previous
  patch.  This one has varying styles for spaces before parentheses and around
  arithmatic operators.  If you run your code through 'indent' it should do
  an ok job.  You'll probably have to hand inspect it afterwards, though.

- Why are you setting the thread priority as well as the process priority?
  Cygwin's nice implementation sticks to just setting the process priority.
  I try not to add to the pinfo structure if I can help it since it lives in
  shared memory, so if the addition of a thread id can be eliminated then
  I think we should do so.

- What's MEOR2000only?  It seems to be used around w2k-only stuff and,
  like OpenThread.

- I don't like the sched.cc/schedule.cc file names.  The names are too similar.
  Can they be put into one file or renamed?

- Do these fall under the category of pthreads routines?  If so, the cygwin.din
  lines should be prefixed with @PTH_ALLOW@.

- Earnie, if you're reading this, please note the w32api change.  It adds the
  w2k/winme OpenThread() function to winbase.h

cgf
