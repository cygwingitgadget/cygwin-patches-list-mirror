Return-Path: <cygwin-patches-return-1819-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 20928 invoked by alias); 29 Jan 2002 06:17:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20903 invoked from network); 29 Jan 2002 06:17:30 -0000
Message-ID: <067a01c1a88c$a5eaa270$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Robert Collins" <robert.collins@itdomain.com.au>,
	"Michael A Chase" <mchase@ix.netcom.com>,
	<cygwin-patches@cygwin.com>
References: <00c601c1a87f$a49a4090$0d00a8c0@mchasecompaq> <049701c1a881$399ea3b0$0200a8c0@lifelesswks> <015501c1a885$7aa4c520$0d00a8c0@mchasecompaq> <061001c1a887$1e5a4bd0$0200a8c0@lifelesswks> <01c101c1a88a$ba3763f0$0d00a8c0@mchasecompaq> <066601c1a88c$43ae51b0$0200a8c0@lifelesswks>
Subject: Re: [PATCH]Reduce messages in setup.log
Date: Mon, 28 Jan 2002 22:17:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 29 Jan 2002 06:17:29.0259 (UTC) FILETIME=[A0F827B0:01C1A88C]
X-SW-Source: 2002-q1/txt/msg00176.txt.bz2


===
----- Original Message -----
From: "Robert Collins" <robert.collins@itdomain.com.au>
> > 1.  If a method only returns a constant 0, the message should go to
> > setup.log.full to make it easier to tell where more work may be
> needed.
>
> Yes, LOG_TIMESTAMP (so that a casual inspection will have it visible).
> Likewise for any constant response, with a couple of exceptions:
> * IF the method will *never* get implemented (ie, do we ever need
> writeable archives?) Then the message level should be LOG_BABBLE, and
it
> should say something like "Foo::Bar - I wasn't expected to be
> implemented OR used!"
* Or for virtual functions that should be abstract, but can't be (for
whatever reason). (ie io_stream::~io_stream()).

Rob
