Return-Path: <cygwin-patches-return-5802-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4173 invoked by alias); 6 Mar 2006 21:50:07 -0000
Received: (qmail 4161 invoked by uid 22791); 6 Mar 2006 21:50:06 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 06 Mar 2006 21:50:03 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.60) 	(envelope-from <brian@dessent.net>) 	id 1FGNab-0001cs-Dg 	for cygwin-patches@cygwin.com; Mon, 06 Mar 2006 21:50:01 +0000
Message-ID: <440CAE88.13DA9205@dessent.net>
Date: Mon, 06 Mar 2006 21:50:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Patch for silent crash with Cygwin1.dll v 1.5.19-4
References: <20060306141411.85092.qmail@web53001.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00111.txt.bz2

Gary Zablackis wrote:

> I did some more research over the weekend and my
> problem seems to only come when loading a dll via
> dlopen() and run_ctors() is called from dll:init() and
> pthread_key_create() is called during the time that
> run_ctors() is active. I still have not found who is
> calling pthread_key_create(), but will be working on
> this as time permits this week.

If you are trying to track down why you get a SIGSEGV in
pthread_key_create while running your app in gdb you are wasting your
time.  This is not a fault, it is expected and normal.  Search the
archives.

Brian
