Return-Path: <cygwin-patches-return-1793-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8563 invoked by alias); 25 Jan 2002 22:34:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8549 invoked from network); 25 Jan 2002 22:34:09 -0000
Message-ID: <008b01c1a5f0$65c9e9b0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
References: <02b901c1a58d$11e86820$a100a8c0@mchasecompaq> <1011955697.18203.27.camel@lifelesswks> <000901c1a58f$58a46640$a100a8c0@mchasecompaq> <20020125172432.GD27965@redhat.com>
Subject: Re: [PATCH]Package extention recognition (revision 2)
Date: Fri, 25 Jan 2002 14:34:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 25 Jan 2002 22:34:08.0573 (UTC) FILETIME=[673ADED0:01C1A5F0]
X-SW-Source: 2002-q1/txt/msg00150.txt.bz2

My fault, we discussed this on cygwin-apps when you where adding package
support to cygcheck.

I was looking for a clear and easy to read solution ;}. I don't think
that supporting foo.tar.bz2.tar.bz2 needs to be an objective though :}.

Rob
===
----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Saturday, January 26, 2002 4:24 AM
Subject: Re: [PATCH]Package extention recognition (revision 2)


> On Fri, Jan 25, 2002 at 02:59:17AM -0800, Michael A Chase wrote:
> >And that test is still there, I moved it into the if () so something
like
> >".tar.bz2" wouldn't trigger the return .... : 0;  If all the ifs
fail,
> >return 0; still occurs.
>
> Hmm.  Seems like someone has "improved" this code from when I wrote
it.
>
> My version checked for a trailing component.  If it existed, it
returned
> the index into the string.
>
> This version sort of does the same thing but if there is a .tar.bz2
> anywhere in the string prior to trailing component, it will fail
> regardless of whether the filename ends with .tar .tar.gz or .tar.bz2.
>
> Perhaps that is an acceptable risk but it puzzles me why anyone would
> move from an algorithm that was foolproof to one that wasn't.
>
> cgf
>
