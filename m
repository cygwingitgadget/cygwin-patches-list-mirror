Return-Path: <cygwin-patches-return-1816-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13964 invoked by alias); 29 Jan 2002 06:04:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13940 invoked from network); 29 Jan 2002 06:04:21 -0000
Message-ID: <01c101c1a88a$ba3763f0$0d00a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: "Robert Collins" <robert.collins@itdomain.com.au>,
	<cygwin-patches@cygwin.com>
References: <00c601c1a87f$a49a4090$0d00a8c0@mchasecompaq> <049701c1a881$399ea3b0$0200a8c0@lifelesswks> <015501c1a885$7aa4c520$0d00a8c0@mchasecompaq> <061001c1a887$1e5a4bd0$0200a8c0@lifelesswks>
Subject: Re: [PATCH]Reduce messages in setup.log
Date: Mon, 28 Jan 2002 22:04:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00173.txt.bz2

----- Original Message -----
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Michael A Chase" <mchase@ix.netcom.com>; <cygwin-patches@cygwin.com>
Sent: Monday, January 28, 2002 21:38
Subject: Re: [PATCH]Reduce messages in setup.log


> ----- Original Message -----
> From: "Michael A Chase" <mchase@ix.netcom.com>
>
> > If the intention of those messages is to highlight methods that should
> have
> > been overridden but aren't, then setup.log is the right place.
>
> Essentially, yes thats why they are there: incomplete methods. When I
> review your patch I'll be looking at the function status.

There's no sense spending your time on the patch.  I need to change it
drastically or withdraw it.

If I understand the intent:

1.  If a method only returns a constant 0, the message should go to
setup.log.full to make it easier to tell where more work may be needed.

2.  If a method does more than just return a constant 0, it should not call
log(), or if it does, the message is only needed in setup.log.

Possible candidates:

   Performs actual work: compress_bz::peek(), compress_gz::peek(),
compress_gz::~compress_gz(), io_stream_cygfile::peek(), and
io_stream_file::peek().

   Returns NULL: archive::next_file_name(), compress::next_file_name(), and
io_stream::factory().

   Returns -1: compress_bz::seek() and compress_gz::seek().
--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Ask Smarter: http://www.tuxedo.org/~esr/faqs/smart-questions.htm
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

