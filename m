Return-Path: <cygwin-patches-return-1653-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 23819 invoked by alias); 3 Jan 2002 10:13:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23804 invoked from network); 3 Jan 2002 10:13:30 -0000
Message-ID: <091e01c1943f$501e7b70$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
Cc: <cygwin-patches@cygwin.com>
References: <NCBBIHCHBLCMLBLOBONKOEDJCIAA.g.r.vansickle@worldnet.att.net>
Subject: Re: setup.exe remove scripts [Was: Re: experimental texmf packages]
Date: Thu, 03 Jan 2002 02:13:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 03 Jan 2002 10:13:28.0866 (UTC) FILETIME=[4A033820:01C1943F]
X-SW-Source: 2002-q1/txt/msg00010.txt.bz2


===
----- Original Message -----
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: "Robert Collins" <robert.collins@itdomain.com.au>
Cc: <cygwin-patches@cygwin.com>
Sent: Thursday, January 03, 2002 9:11 PM
Subject: RE: setup.exe remove scripts [Was: Re: experimental texmf
packages]


> > I'd love a patch with the following:
> >
>
> Ok, that's what I'm talking about.  Give me a few minutes to update
the
> changelog and make sure I actually did that already and I'll get that
to you.
>
> > As for your Makefile.in iniparse Change, I think that's wrong (at
first
> > glance) as Chris already patched that to allow both new and old
bisons.
>
> Yeah, I'm not 100% convinced it's right either, but I get a ".hh" out
of "bison
> (GNU Bison) 1.30", not a ".cc.h".  Maybe give me an extra minute or
two on that
> one, but what do you want if I find nothing?

Nothing - "Chris has already patched this"

(it should look like this in your sandbox)
    @mv iniparse.cc.h iniparse.h 2>/dev/null || mv iniparse.hh
iniparse.h

Rob
