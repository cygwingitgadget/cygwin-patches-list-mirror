From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: close-on-exec handles are left open by exec parent
Date: Sat, 04 Aug 2001 11:48:00 -0000
Message-id: <20010804144730.B3038@redhat.com>
References: <71194343130.20010802183838@logos-m.ru> <20010803113109.D26623@redhat.com> <34115428587.20010804205546@logos-m.ru>
X-SW-Source: 2001-q3/msg00051.html

On Sat, Aug 04, 2001 at 08:55:46PM +0400, egor duda wrote:
>Hi!
>
>Friday, 03 August, 2001 Christopher Faylor cgf@redhat.com wrote:
>
>>>  here's the proposed patch. it also contains a fix FreeConsole ()
>>>related bug -- when cygwin application frees its console,
>>>"process_input" thread may be still running. When console is closed,
>>>WaitForMultipleObjects () with console handle returns WAIT_FAILED, so
>>>"process_input" thread starts cycling and eating CPU.
>
>CF> Ack! I don't understand why you've introduced another synchronization
>CF> event.  Why not just close all of the fds after the program has been
>CF> successfully executed?  Once CreateProcess has executed, the handles will
>CF> be opened by the new process.
>
>they do, but we care not only about win32 handles. when /dev/tty0 is
>closed, some new process (for example) which opens /dev/tty, allocates
>new tty, an it will be /dev/tty0, won't it?

Not if the inuse event is operating correctly, no.

>without synchronization i got all kinds of strange lockups and
>crashes, which disappear when synchronization is added. i didn't
>investigate those crashes, but they probably do need some closer
>investigation. i'll try to look at them.

Yes.  As I said, this is the way that (shudder) B20 used to do it, I think.
If there are crashes I'd like to understand why.

>your point about non-cygwin apps is absolutely valid, though :( i have
>to think it over a bit more. maybe we need to add some kind of
>"pre-close" that closes win32 handles, but left cygwin-specific data,
>such as tty slot, intact. or just utilize fixup_before_exec ()

As I said, I don't think that the tty slot thing should be an issue.  If
it is, that's a bug.

cgf
