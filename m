Return-Path: <cygwin-patches-return-1813-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22021 invoked by alias); 29 Jan 2002 04:55:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21944 invoked from network); 29 Jan 2002 04:55:44 -0000
Message-ID: <049701c1a881$399ea3b0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Michael A Chase" <mchase@ix.netcom.com>,
	<cygwin-patches@cygwin.com>
References: <00c601c1a87f$a49a4090$0d00a8c0@mchasecompaq>
Subject: Re: [PATCH]Reduce messages in setup.log
Date: Mon, 28 Jan 2002 20:55:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 29 Jan 2002 04:55:43.0145 (UTC) FILETIME=[34B29190:01C1A881]
X-SW-Source: 2002-q1/txt/msg00170.txt.bz2


===
----- Original Message -----
From: "Michael A Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
Sent: Tuesday, January 29, 2002 3:41 PM
Subject: Re: [PATCH]Reduce messages in setup.log


> ----- Original Message -----
> From: "Robert Collins" <robert.collins@itdomain.com.au>
> To: <cygwin-patches@cygwin.com>
> Sent: Monday, January 28, 2002 20:25
> Subject: Re: [PATCH]Reduce messages in setup.log
>
> > ----- Original Message -----
> > From: "Christopher Faylor" <cgf@redhat.com>
> > To: <cygwin-patches@cygwin.com>
> > Sent: Tuesday, January 29, 2002 3:14 PM
> > Subject: Re: [PATCH]Reduce messages in setup.log
> >
> >
> > > On Mon, Jan 28, 2002 at 08:00:36PM -0800, Michael A Chase wrote:
> > >
> > > I don't know how Robert prefers this, but it is customary to
provide a
> > > single patch file not a bunch of separate attachments.  With one
patch
> > > file you can just say
> >
> > Yes please, one  patch is nicer.
>
> Sorry.  I got confused and thought it was the other way around.

No probs. If you have mulitple patchs for _different_things- newlib +
cinstall, or w32api + cinstall, then, yes, multiple files are needed.

> What about the compress_gz.error() and compress_bz.error() messages.
The gz
> one is commented out and the bz one isn't.  Should they be the same?
If so,
> which is preferred?  I lean toward writing both as long as they are
going to
> setup.log.full.

I think you've missed the point of the messages. They indicate
incomplete functions, so that the main log shows what the *program*
should have detected.

compress_gz::error returns an internal state error value.
compress_bz::error returns 0!

Likewise for everything that logs to setup.log - it should stay there IF
and only IF it's not properly implemented.

I will happily accept patches addressing the core issues, but not to
hide them :}.

I thought when you initially described this that there where a bunch of
messages that *shouldn't* be going to the log, but until I review the
body of your patches, I can't meaningfully confirm on a per function
basis.

Rob
