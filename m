Return-Path: <cygwin-patches-return-3991-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19319 invoked by alias); 3 Jul 2003 18:20:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19309 invoked from network); 3 Jul 2003 18:20:17 -0000
X-Originating-IP: [68.80.102.63]
X-Originating-Email: [rkitover@hotmail.com]
From: "Rafael Kitover" <caelum@debian.org>
To: <cygwin-patches@cygwin.com>
Subject: TIOCSPGRP ioctl
Date: Thu, 03 Jul 2003 18:20:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <Law9-OE331O0bEvivGn00059d84@hotmail.com>
X-OriginalArrivalTime: 03 Jul 2003 18:20:16.0679 (UTC) FILETIME=[C0C54B70:01C3418F]
X-SW-Source: 2003-q3/txt/msg00007.txt.bz2

Still working on my screen port and am tantalizingly close. I noticed that
there doesn't seem to be an implementation of the
TIOCSPGRP ioctl (and consequently the tcsetpgrp function) to set the pgrp of
the tty, I'm guessing this might be my problem,
or one of them.

There seems to be support for its existance in
newlib/libc/sys/linux/termios.c and for the tcsetpgrp function.

Would it be a good idea to write a patch to implement this ioctl? If so,
could I have a couple suggestions on where to start?
Does this go into fhandler_tty_slave::ioctl() ? Is it generally useful to
work on adding other unimplemented tty ioctls?

-- 
Rafael
