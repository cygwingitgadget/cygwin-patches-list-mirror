From: Christopher Faylor <cgf@redhat.com>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: Cut and paste problem with cygwin 1.3.1
Date: Fri, 27 Apr 2001 08:27:00 -0000
Message-id: <20010427112742.D5680@redhat.com>
References: <3AE76EC4.EF0FFA66@lucent.com> <20010425222146.D3536@redhat.com> <3AE79346.6E761199@bbn.com> <20010425232756.A4338@redhat.com> <33191091635.20010426165929@logos-m.ru> <20010426142044.B6609@redhat.com> <90270851323.20010427150850@logos-m.ru>
X-SW-Source: 2001-q2/msg00174.html

On Fri, Apr 27, 2001 at 03:08:50PM +0400, egor duda wrote:
>Hi!
>
>Thursday, 26 April, 2001 Christopher Faylor cgf@redhat.com wrote:
>
>CF> If you've reproduced it and this patch fixes it, then please check
>CF> this in.
>
>CF> I wonder why I can't duplicate it...
>
>it's race condition, so i'm not surprised. . if reader is fast enough
>to not allow writer to fill the pipe, everything's ok. but imagine
>that reader is very slow and writer is very fast. Writer fills the pipe
>up, and blocks in WriteFile (), owning input_mutex, hence the freeze.

Makes sense.  My dual processor machine is sometimes a good way to detect
races and sometimes a good way to bypass them...

cgf
