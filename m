From: Christopher Faylor <cgf@redhat.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: New terminal capability in fhandler_console.cc
Date: Sat, 31 Mar 2001 13:06:00 -0000
Message-id: <20010331160650.C3440@redhat.com>
References: <20010330131541.P16622@cygbert.vinschen.de> <20010330104728.E12718@redhat.com> <20010330192244.X16622@cygbert.vinschen.de> <20010330170201.A29301@redhat.com> <20010331015252.A16622@cygbert.vinschen.de> <20010330193658.F31805@redhat.com> <20010331113118.A8711@cygbert.vinschen.de> <20010331124602.A2693@redhat.com> <20010331201712.G16622@cygbert.vinschen.de> <20010331204205.I16622@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00284.html

On Sat, Mar 31, 2001 at 08:42:05PM +0200, Corinna Vinschen wrote:
>Wait. They don't seem to be implemented as you describe them above.
>They are like
>
>	\E[%d@ and \E[%dP
>
>And I don't understand the sense of an additional parameter. While
>\E[%p1%d@ would make sense, I think "ic" is only for moving to make
>place for additional characters. Inserting N * char c is provided by
>switching to insert mode (im) and then repeating char c N times (rp).
>Do I miss something?

I don't think so.  The \E[%p1%d@ essentially means to use the first
parameter for the next %d.  This just causes %d the line to be moved
over %d characters to the right.

cgf
