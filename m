Return-Path: <cygwin-patches-return-3103-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18044 invoked by alias); 4 Nov 2002 00:52:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17972 invoked from network); 4 Nov 2002 00:52:50 -0000
Message-ID: <003c01c2839c$355bf130$0201a8c0@sos>
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: <cygwin-patches@cygwin.com>
References: <002701c28394$ce2fc1f0$0201a8c0@sos> <20021104003759.GA22976@redhat.com>
Subject: Re: fhandler_tty patch
Date: Sun, 03 Nov 2002 16:52:00 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
X-SW-Source: 2002-q4/txt/msg00054.txt.bz2


----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Sunday, November 03, 2002 7:37 PM
Subject: Re: fhandler_tty patch

> > * fhandler_tty.cc (fhandler_tty_slave::ioctl): Do nothing if the new
> > window size is equal to the old one.  Send SIGWINCH if slave connected
> > to a pseudo tty.
> > (fhandler_pty_master::ioctl): Do nothing if the new window size is
> > equal to the old one.
>
> Is this according to some standard?  It seems like we're sending too many
> SIGWINCHes with your patch.
>

Without the patch we're not sending SIGWINCH at all. ioctl(tty, TIOSWINSZ,
...) supposed to send SIGWINCH if the window size changed. The ioctl() call
should work in the same way for both master and slave ends of pseudo tty,
without the patch the ioctl works for master end only, but many unix
programs (screen for example) change the window size of the slave end.

Sergey Okhapkin
Somerset, NJ

