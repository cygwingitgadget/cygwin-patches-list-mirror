From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: close-on-exec handles are left open by exec parent
Date: Fri, 03 Aug 2001 08:31:00 -0000
Message-id: <20010803113109.D26623@redhat.com>
References: <71194343130.20010802183838@logos-m.ru>
X-SW-Source: 2001-q3/msg00047.html

On Thu, Aug 02, 2001 at 06:38:38PM +0400, egor duda wrote:
>Hi!
>
>  here's the proposed patch. it also contains a fix FreeConsole ()
>related bug -- when cygwin application frees its console,
>"process_input" thread may be still running. When console is closed,
>WaitForMultipleObjects () with console handle returns WAIT_FAILED, so
>"process_input" thread starts cycling and eating CPU.

Ack! I don't understand why you've introduced another synchronization
event.  Why not just close all of the fds after the program has been
successfully executed?  Once CreateProcess has executed, the handles will
be opened by the new process.

I really don't want to have YA synchronization point between the parent
and the child.  It seems like that will cause a hang with spawn P_NOWAIT
of a non-cygwin process which is something that I'm currently trying to
fix.

Now that I think of it, removed a close_all_files call from spawn.cc a
while ago.  I think that I thought that it was slowing things down.  Or,
maybe it was causing api_fatal to stop printing anything.  However, I'd
rather have a correctly working program for now and worry about api_fatal
later, so, I propose the (untested) patch below which puts the close_all_files
back.

Doesn't this solve the problem?

cgf
