Return-Path: <cygwin-patches-return-3979-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23283 invoked by alias); 30 Jun 2003 16:24:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23274 invoked from network); 30 Jun 2003 16:24:55 -0000
X-Originating-IP: [68.80.118.176]
X-Originating-Email: [rkitover@hotmail.com]
From: "Rafael Kitover" <caelum@debian.org>
To: <cygwin-patches@cygwin.com>
Subject: Re: EIO error on background tty reads
Date: Mon, 30 Jun 2003 16:24:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <Law9-OE473haqXoPTz100053e84@hotmail.com>
X-OriginalArrivalTime: 30 Jun 2003 16:24:51.0250 (UTC) FILETIME=[21A77120:01C33F24]
X-SW-Source: 2003-q2/txt/msg00206.txt.bz2

>This isn't a cygwin internals special case knowledge type of thing.  A grep
>of cygwin sources shows that bg_check is called with one of two arguments:
>either SIGTTOU or SIGTTIN is used.  So, your change effectively makes the
>final "goto seEIO" a no-op since it specifically checks for both inputs and
>bypasses the final goto.>
>Sorry, but if this fixes the problem it is a band-aid.
>
>cgfHere's what I understand about this function, fhandler_termios::bg_check
