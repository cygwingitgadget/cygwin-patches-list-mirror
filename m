From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: re: sched *
Date: Mon, 19 Mar 2001 13:06:00 -0000
Message-id: <015201c0b0b8$4734d650$0200a8c0@lifelesswks>
X-SW-Source: 2001-q1/msg00213.html

Sorry this isn't a threaded replie... wasn't on the list.

==
I'm interested in this patch but the ChangeLog needs work.  Please read
the Contributing link on the Cygwin web page and make suitable
corrections.
The problems you had with this ChangeLog are the same as your previous
submission.

cgf
==
crossed email - this went in before way you needed the changelog was
clear in my mind. (I had read the guidlines.. but somehow :?)

===
More comments:

- You can't add fields to external_pinfo.  That's pretty much set in
  stone.  I probably should have added a version number to this
structure,
  but... I didn't.

- Please just add appropriate copyrights using other files as
guidelines:

	Copyright 2001 Red Hat, Inc.

  is fine.

- Please use GNU coding standards.  I forgot to check this with your
previous
  patch.  This one has varying styles for spaces before parentheses and
around
  arithmatic operators.  If you run your code through 'indent' it should
do
  an ok job.  You'll probably have to hand inspect it afterwards,
though.

- Why are you setting the thread priority as well as the process
priority?
  Cygwin's nice implementation sticks to just setting the process
priority.
  I try not to add to the pinfo structure if I can help it since it
lives in
  shared memory, so if the addition of a thread id can be eliminated
then
  I think we should do so.

- What's MEOR2000only?  It seems to be used around w2k-only stuff and,
  like OpenThread.

- I don't like the sched.cc/schedule.cc file names.  The names are too
similar.
  Can they be put into one file or renamed?

- Do these fall under the category of pthreads routines?  If so, the
cygwin.din
  lines should be prefixed with @PTH_ALLOW@.

- Earnie, if you're reading this, please note the w32api change.  It
adds the
  w2k/winme OpenThread() function to winbase.h

cgf
===
external_pinfo doesn't have to change now. (Thanks to pinfo).
copyright: thanks will do.
indent - sure. What version, and what parameters? (I've been bitten
before :] )
thread priority - because down the track I hope to implement the posix
pthread_attr_*sched* functions. What  they do is set the priority of
threads at creation time. .... and I've just taken the time to reread
all the detail.. We don't _need_ to set the thread priority, I was just
trying to get a better map function (32 priorities to 15 rather than 4 )
MEOR2000only - it was a prompt for you to go "what is this". It was to
compile the cygwin1.dll on non win2k or Me machines as I realised late
in the piece that Openthread was 2k only. If we can bind the functions
in cygwin1.dll only when we need them that could be a test for what os
we are running on. but as that code now goes away, it's not an issue.
Again we've crossed paths. I'll merge sched.cc and schedule.cc as I was
just following existing code layout (ironically you then asked me why
it's done that way!).
Pthreads routines? Uhmm no the are realtime routines but they operate
independently of threaded code. If I start to use threaded code features
in them then I'll code an appropriate check ?
The w32api change was written of the MS Documentation at msdn... It
won't be needed now, but I figure completeness is a good thing.

Rob
