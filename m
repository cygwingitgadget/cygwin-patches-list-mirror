From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
Cc: <cygwin-patches@sourceware.cygnus.com>
Subject: Re: shutdown sockets on exit patch
Date: Tue, 27 Nov 2001 10:49:00 -0000
Message-ID: <002601c17773$53f23090$02af6080@cc.telcordia.com>
References: <001b01c1776b$0ad3c020$02af6080@cc.telcordia.com> <20011127193031.Q14975@cygbert.vinschen.de>
X-SW-Source: 2001-q4/msg00257.html
Message-ID: <20011127104900.VsUJBlIwNm73IFOla24-DWx9CSSlsOS91RkcVB5bk1s@z>

> I tried it.  Rexecd, rshd, sshd (and scp) seem to work fine but the
> following new errors occur now:
>
> - Calling `dir' in an ftp connection to the Windows box works but
>   after finishing the connection is closed and the message
>   "421 Service not available, remote server has closed connection."
>   is printed.
>
> - Connecting from the Windows box to a host using ssh with X11
>   forwarding activated fails with error
>   "Write failed: errno ESHUTDOWN triggered"
>
> This is probably due to the child processes calling shutdown on the
> socket on exit.
>

You're right, child process shuts down parent's socket... I'll try to find
some other solution.

Sergey Okhapkin
Piscataway, NJ

