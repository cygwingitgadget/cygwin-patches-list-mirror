Return-Path: <cygwin-patches-return-1841-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 29293 invoked by alias); 3 Feb 2002 08:00:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29278 invoked from network); 3 Feb 2002 08:00:13 -0000
Message-ID: <00bf01c1ac88$caa204f0$0d00a8c0@mchasecompaq>
From: "Michael A Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
Subject: setup.exe concats
Date: Tue, 05 Feb 2002 11:33:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q1/txt/msg00198.txt.bz2

I forgot to remove Strings::concat() and Strings::vconcat() in Strings++.cc
and Strings++.h.  They shouldn't be needed after my first patch is applied.
--
Mac :})
** I normally forward private questions to the appropriate mail list. **
Ask Smarter: http://www.tuxedo.org/~esr/faqs/smart-questions.htm
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

