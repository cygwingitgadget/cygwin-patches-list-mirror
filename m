Return-Path: <cygwin-patches-return-1818-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20319 invoked by alias); 29 Jan 2002 06:14:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20287 invoked from network); 29 Jan 2002 06:14:45 -0000
Message-ID: <066601c1a88c$43ae51b0$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Michael A Chase" <mchase@ix.netcom.com>,
	<cygwin-patches@cygwin.com>
References: <00c601c1a87f$a49a4090$0d00a8c0@mchasecompaq> <049701c1a881$399ea3b0$0200a8c0@lifelesswks> <015501c1a885$7aa4c520$0d00a8c0@mchasecompaq> <061001c1a887$1e5a4bd0$0200a8c0@lifelesswks> <01c101c1a88a$ba3763f0$0d00a8c0@mchasecompaq>
Subject: Re: [PATCH]Reduce messages in setup.log
Date: Mon, 28 Jan 2002 22:14:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 29 Jan 2002 06:14:44.0442 (UTC) FILETIME=[3EBB13A0:01C1A88C]
X-SW-Source: 2002-q1/txt/msg00175.txt.bz2

----- Original Message -----
From: "Michael A Chase" <mchase@ix.netcom.com>
> > Essentially, yes thats why they are there: incomplete methods. When
I
> > review your patch I'll be looking at the function status.
>
> There's no sense spending your time on the patch.  I need to change it
> drastically or withdraw it.

I appreciate this. I'll take you up on it as well :].

> If I understand the intent:
>
> 1.  If a method only returns a constant 0, the message should go to
> setup.log.full to make it easier to tell where more work may be
needed.

Yes, LOG_TIMESTAMP (so that a casual inspection will have it visible).
Likewise for any constant response, with a couple of exceptions:
* IF the method will *never* get implemented (ie, do we ever need
writeable archives?) Then the message level should be LOG_BABBLE, and it
should say something like "Foo::Bar - I wasn't expected to be
implemented OR used!"

> 2.  If a method does more than just return a constant 0, it should not
call
> log(), or if it does, the message is only needed in setup.log.

Yes, LOG_BABBLE for routine non-user-visible importance. Noting that a
function is called is usually not needed in fact - thus the // in the
compress_gz:: call we discussed earlier.

> Possible candidates:
>
>    Performs actual work: compress_bz::peek(), compress_gz::peek(),
> compress_gz::~compress_gz(), io_stream_cygfile::peek(), and
> io_stream_file::peek().

yah, drop to BABBLE, or just remove the logging completely.

>    Returns NULL: archive::next_file_name(),
compress::next_file_name(), and
> io_stream::factory().

factory is important, archive::next_file_name and
compress::next_file_name should never get called (ie LOG_TIMESTAMP
these) -  indicates a non-properly overriden sub class.

>    Returns -1: compress_bz::seek() and compress_gz::seek().

Right. Well, compress_* and seeking don't mix well IMO, so I'm happy for
these to become BABBLERS.

Rob
