Return-Path: <cygwin-patches-return-3992-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32766 invoked by alias); 3 Jul 2003 19:29:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32749 invoked from network); 3 Jul 2003 19:29:23 -0000
Date: Thu, 03 Jul 2003 19:29:00 -0000
From: Christopher Faylor <cgf-idd@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: TIOCSPGRP ioctl
Message-ID: <20030703192950.GA3503@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Law9-OE331O0bEvivGn00059d84@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law9-OE331O0bEvivGn00059d84@hotmail.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00008.txt.bz2

On Thu, Jul 03, 2003 at 02:20:14PM -0400, Rafael Kitover wrote:
>Still working on my screen port and am tantalizingly close. I noticed that
>there doesn't seem to be an implementation of the
>TIOCSPGRP ioctl (and consequently the tcsetpgrp function) to set the pgrp of
>the tty, I'm guessing this might be my problem,
>or one of them.
>
>There seems to be support for its existance in
>newlib/libc/sys/linux/termios.c and for the tcsetpgrp function.
>
>Would it be a good idea to write a patch to implement this ioctl? If so,
>could I have a couple suggestions on where to start?
>Does this go into fhandler_tty_slave::ioctl() ? Is it generally useful to
>work on adding other unimplemented tty ioctls?

tcsetpgrp should do what you want.  It is the modern way to accomplish
this.  I'm surprised that screen doesn't already have some way of using
this call.  Or is it using it and something is wrong in cygwin's
implementation?

cgf
--
Please use the resources at cygwin.com rather than sending personal email.
Special for spam email harvesters: send email to aaaspam@sourceware.org
and be permanently blocked from mailing lists at sources.redhat.com
