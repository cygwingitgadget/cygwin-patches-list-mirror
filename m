Return-Path: <cygwin-patches-return-1837-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31605 invoked by alias); 2 Feb 2002 06:36:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31591 invoked from network); 2 Feb 2002 06:36:19 -0000
Message-ID: <00b401c1abb3$e5ce9020$0d00a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: "Robert Collins" <robert.collins@itdomain.com.au>,
	<cygwin-patches@cygwin.com>
References: <FC169E059D1A0442A04C40F86D9BA760629F@itdomain003.itdomain.net.au> <006701c1aba4$4996cb50$0d00a8c0@mchasecompaq> <028a01c1aba5$ac391460$0200a8c0@lifelesswks>
Subject: Re: For the curious: Setup.exe char-> String patch
Date: Fri, 01 Feb 2002 22:36:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00194.txt.bz2

I have nearly eliminated concat.cc, concat() and vconcat().  I could
eliminate concat.h as well if I had a place to move SLASH_P() to.  The only
file that uses that SLASH_P() is mount.cc, so I'd like to copy the macro to
mount.h.  Is that acceptable?

--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Ask Smarter: http://www.tuxedo.org/~esr/faqs/smart-questions.htm
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

