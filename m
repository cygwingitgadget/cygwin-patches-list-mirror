From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: control characters echoed incorrectly.
Date: Wed, 09 May 2001 11:55:00 -0000
Message-id: <20010509145355.A2089@redhat.com>
References: <s1spudixvai.fsf@jaist.ac.jp>
X-SW-Source: 2001-q2/msg00212.html

On Thu, May 10, 2001 at 02:54:29AM +0900, Kazuhiro Fujieda wrote:
>The terminal device echoes control characters even when the echo 
>flag is off.
>
>2001-05-10  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
>
>	* fhandler_termios.cc (fhandler_termios::line_edit): Check the echo
>	flag before echoing control characters.

Good catch.  I made a modification to your patch.  I put the echoing of
the erase characters into an "echo_erase" method.

I've checked your changes in, with some modification.  I'd appreciate it
if you'd double check my modifications to your changes.

Thanks.

cgf
