Return-Path: <cygwin-patches-return-3109-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24543 invoked by alias); 4 Nov 2002 02:32:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24488 invoked from network); 4 Nov 2002 02:32:02 -0000
Message-ID: <005f01c283aa$104f8100$0201a8c0@sos>
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: <cygwin-patches@cygwin.com>
References: <002701c28394$ce2fc1f0$0201a8c0@sos> <20021104003759.GA22976@redhat.com> <003c01c2839c$355bf130$0201a8c0@sos> <20021104011150.GA23246@redhat.com> <004501c283a2$0b263870$0201a8c0@sos> <20021104021537.GB28851@redhat.com>
Subject: Re: fhandler_tty patch
Date: Sun, 03 Nov 2002 18:32:00 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
X-SW-Source: 2002-q4/txt/msg00060.txt.bz2

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Sunday, November 03, 2002 9:15 PM
Subject: Re: fhandler_tty patch


>
> I don't mean SIGWINCH.  I thought the master was supposed to be able
> to arbitrate slave window size requests somehow.
>

Sure. To implement the right behavior we need to develop some kind of
streams module insertable between pty slave and raw fhandler (console,
serial, tty master).

Sergey Okhapkin
Somerset, NJ

