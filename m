From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Sergey Okhapkin <sos@prospect.com.ru>
Cc: cygwin-patches@sourceware.cygnus.com
Subject: Re: shutdown sockets on exit patch
Date: Tue, 27 Nov 2001 10:32:00 -0000
Message-ID: <20011127193031.Q14975@cygbert.vinschen.de>
References: <001b01c1776b$0ad3c020$02af6080@cc.telcordia.com>
X-SW-Source: 2001-q4/msg00254.html
Message-ID: <20011127103200.WIPRANFaEmTplckz5MouN5Bw9-K2mXYasTeIaAoGxlA@z>

On Tue, Nov 27, 2001 at 12:43:36PM -0500, Sergey Okhapkin wrote:
> Hi!
> 
> The patch attached implements gracefull socket shutdown on application exit.
> Rexecd from inetutils package do not print an annoying message now. Corinna,
> I didn't test the fix with rshd, test it please!

I tried it.  Rexecd, rshd, sshd (and scp) seem to work fine but the
following new errors occur now:

- Calling `dir' in an ftp connection to the Windows box works but
  after finishing the connection is closed and the message
  "421 Service not available, remote server has closed connection."
  is printed.

- Connecting from the Windows box to a host using ssh with X11
  forwarding activated fails with error
  "Write failed: errno ESHUTDOWN triggered"

This is probably due to the child processes calling shutdown on the
socket on exit.

Corinna
  
-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
