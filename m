Return-Path: <cygwin-patches-return-3167-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18869 invoked by alias); 14 Nov 2002 00:24:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18846 invoked from network); 14 Nov 2002 00:24:29 -0000
Message-ID: <033601c28b73$e12ce170$0201a8c0@sos>
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: <cygwin-patches@cygwin.com>
References: <001c01c28460$ca1e5eb0$0201a8c0@sos> <20021113223709.GA29682@redhat.com> <032c01c28b6d$e8daba60$0201a8c0@sos> <20021113234439.GB11400@redhat.com>
Subject: Re: ioctl.cc fix
Date: Wed, 13 Nov 2002 16:24:00 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
X-SW-Source: 2002-q4/txt/msg00118.txt.bz2

I think the recent changes in fhandler_serial uncovered some old bugs...
I'll try to investigate.

Sergey Okhapkin
Somerset, NJ
----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Wednesday, November 13, 2002 6:44 PM
Subject: Re: ioctl.cc fix


> On Wed, Nov 13, 2002 at 06:23:52PM -0500, Sergey Okhapkin wrote:
> >I remember only one message about a serial port troubles with W98.  Did
> >you see something else?
>
> That was it.
>
> Subject: Serial port problems with cygwin1.dll 1.3.15 on Win98SE
>
> cgf

