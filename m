Return-Path: <cygwin-patches-return-5468-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8921 invoked by alias); 18 May 2005 17:20:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8823 invoked from network); 18 May 2005 17:20:00 -0000
Received: from unknown (HELO dessent.net) (66.17.244.20)
  by sourceware.org with SMTP; 18 May 2005 17:20:00 -0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.44)
	id 1DYSD6-0002r5-J2
	for cygwin-patches@cygwin.com; Wed, 18 May 2005 17:19:56 +0000
Message-ID: <428B7979.4CB169BC@dessent.net>
Date: Wed, 18 May 2005 17:20:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] gcc4 fixes
References: <428A7520.7FD9925C@dessent.net> <20050518080133.GA25438@calimero.vinschen.de> <20050518133417.GB19793@trixie.casa.cgf.cx> <428B480D.E465C6E8@dessent.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q2/txt/msg00064.txt.bz2

Brian Dessent wrote:

> entirely in their build scripts due to compiler problems.  So who knows,
> maybe I should try with a release build.

With the release version of gcc 4.0.0 and without the mmap() kludge I
get the same thing:

FAIL: mmaptest01.c (execute)
FAIL: mmaptest03.c (execute)
FAIL: mmaptest04.c (execute)
FAIL: ltp/mmap001.c (execute)
FAIL: ltp/mmap02.c (execute)
FAIL: ltp/mmap03.c (execute)
FAIL: ltp/mmap04.c (execute)
FAIL: ltp/mmap05.c (execute)
FAIL: ltp/mmap06.c (execute)
FAIL: ltp/mmap07.c (execute)
FAIL: ltp/munmap01.c (execute)
FAIL: ltp/munmap02.c (execute)
FAIL: pthread/cancel11.c (execute)

So, it's not that.

Brian
