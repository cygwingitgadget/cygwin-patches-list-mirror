From: Christopher Faylor <cgf@redhat.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: New terminal capability in fhandler_console.cc
Date: Fri, 30 Mar 2001 16:36:00 -0000
Message-id: <20010330193658.F31805@redhat.com>
References: <20010330131541.P16622@cygbert.vinschen.de> <20010330104728.E12718@redhat.com> <20010330192244.X16622@cygbert.vinschen.de> <20010330170201.A29301@redhat.com> <20010331015252.A16622@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00276.html

On Sat, Mar 31, 2001 at 01:52:52AM +0200, Corinna Vinschen wrote:
>> I don't think it works that way, does it?  I just tried this.  There
>> is no wrapping.  Characters at the end of the line are truncated.
>
>Did you try that under linux? Hmm, I'm perhaps misleaded by the
>behaviour of the shell.

Yes.  I still have a little bit of state left on this from when I wrote
an editor years ago.  I was also involved in the project which eventually
became ncurses many years ago.

Anyway, I was pretty sure that there was no wrapping involved.  I have a
test file, if you're interested.

cgf
