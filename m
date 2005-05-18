Return-Path: <cygwin-patches-return-5454-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11598 invoked by alias); 18 May 2005 01:14:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11487 invoked from network); 18 May 2005 01:14:27 -0000
Received: from unknown (HELO dessent.net) (66.17.244.20)
  by sourceware.org with SMTP; 18 May 2005 01:14:27 -0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.44)
	id 1DYD8e-0007bB-1g
	for cygwin-patches@cygwin.com; Wed, 18 May 2005 01:14:20 +0000
Message-ID: <428A971C.C5610F59@dessent.net>
Date: Wed, 18 May 2005 01:14:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] gcc4 fixes
References: <428A7520.7FD9925C@dessent.net> <20050517233150.GB9001@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q2/txt/msg00050.txt.bz2

Christopher Faylor wrote:

> Go ahead and check these in but please use GNU formatting conventions,
> i.e., it's (char *) NULL, not (char *)NULL.  Actually, isn't just NULL
> sufficient?

I must have had C++ on the mind, thinking that the cast was necessary.

> Sorry but no.  This is a workaround.  We need to fix the actual problem.

Certainly.  I fully admit I have no real idea what the 'actual' problem
is yet.

Brian
