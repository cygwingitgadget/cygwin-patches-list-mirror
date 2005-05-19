Return-Path: <cygwin-patches-return-5478-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23503 invoked by alias); 19 May 2005 19:46:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8365 invoked from network); 19 May 2005 19:36:24 -0000
Received: from unknown (HELO dessent.net) (66.17.244.20)
  by sourceware.org with SMTP; 19 May 2005 19:36:24 -0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.44)
	id 1DYqod-0000W8-8E
	for cygwin-patches@cygwin.com; Thu, 19 May 2005 19:36:19 +0000
Message-ID: <428CEABB.A1E6E2E5@dessent.net>
Date: Thu, 19 May 2005 19:46:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] several new features for cygrunsrv
References: <428CE837.C00E288B@dessent.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q2/txt/msg00074.txt.bz2

Brian Dessent wrote:

> -controlsToString(DWORD controls)
> +  char *base, *end;
> +  static char buf[34];
> +  int used = 0, dsiz = strlen (delim);

Crap, that is a mistake.  buf[34] should be something more generous like
128 or 256.  I had it set small to test to make sure it couldn't
overflow and forgot to put it back.

Brian
