Return-Path: <cygwin-patches-return-3165-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1888 invoked by alias); 13 Nov 2002 23:41:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1878 invoked from network); 13 Nov 2002 23:41:44 -0000
Message-ID: <032c01c28b6d$e8daba60$0201a8c0@sos>
From: "Sergey Okhapkin" <sos@prospect.com.ru>
To: <cygwin-patches@cygwin.com>
References: <001c01c28460$ca1e5eb0$0201a8c0@sos> <20021113223709.GA29682@redhat.com>
Subject: Re: ioctl.cc fix
Date: Wed, 13 Nov 2002 15:41:00 -0000
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Virus-Scanned: by amavisd-milter (http://amavis.org/)
X-SW-Source: 2002-q4/txt/msg00116.txt.bz2

I remember only one message about a serial port troubles with W98. Did you
see something else?

Sergey Okhapkin
Somerset, NJ
----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Wednesday, November 13, 2002 5:37 PM
Subject: Re: ioctl.cc fix


> On Mon, Nov 04, 2002 at 07:17:51PM -0500, Sergey Okhapkin wrote:
> >I see no output from "debug_printf ("returning %d", res);" in trace file
> >without this fix... gcc bug?
> >
> >2002-11-04  Sergey Okhapkin  <sos@prospect.com.ru>
> >
> >        * ioctl.cc (ioctl): Add default case.
>
> I reorganized this function slightly into something I think makes
> a little more sense.  It should solve this problem.
>
> Thanks for the heads up.
>
> Did you see the serial issues that were reported in the cygwin mailing
> list, btw?
>
> cgf

