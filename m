Return-Path: <cygwin-patches-return-1814-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12456 invoked by alias); 29 Jan 2002 05:26:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12440 invoked from network); 29 Jan 2002 05:26:46 -0000
Message-ID: <015501c1a885$7aa4c520$0d00a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
References: <00c601c1a87f$a49a4090$0d00a8c0@mchasecompaq> <049701c1a881$399ea3b0$0200a8c0@lifelesswks>
Subject: Re: [PATCH]Reduce messages in setup.log
Date: Mon, 28 Jan 2002 21:26:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00171.txt.bz2

----- Original Message -----
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Michael A Chase" <mchase@ix.netcom.com>; <cygwin-patches@cygwin.com>
Sent: Monday, January 28, 2002 20:55
Subject: Re: [PATCH]Reduce messages in setup.log


> I think you've missed the point of the messages. They indicate
> incomplete functions, so that the main log shows what the *program*
> should have detected.
>
> compress_gz::error returns an internal state error value.
> compress_bz::error returns 0!
>
> Likewise for everything that logs to setup.log - it should stay there IF
> and only IF it's not properly implemented.
>
> I will happily accept patches addressing the core issues, but not to
> hide them :}.
>
> I thought when you initially described this that there where a bunch of
> messages that *shouldn't* be going to the log, but until I review the
> body of your patches, I can't meaningfully confirm on a per function
> basis.


I didn't say they shouldn't go to a log, but I didn't think they were useful
in setup.log.

If the intention of those messages is to highlight methods that should have
been overridden but aren't, then setup.log is the right place.
--
Mac :})

** I normally forward private questions to the appropriate mail list. **
Ask Smarter: http://www.tuxedo.org/~esr/faqs/smart-questions.htm
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

