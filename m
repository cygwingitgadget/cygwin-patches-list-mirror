Return-Path: <cygwin-patches-return-6141-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7898 invoked by alias); 6 Sep 2007 19:08:26 -0000
Received: (qmail 7887 invoked by uid 22791); 6 Sep 2007 19:08:25 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-174-251-188.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (71.174.251.188)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Sep 2007 19:08:21 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id BFFBF2B35A; Thu,  6 Sep 2007 15:08:19 -0400 (EDT)
Date: Thu, 06 Sep 2007 19:08:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Fix multithreaded snprintf
Message-ID: <20070906190819.GA19860@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <46E04739.F0B0D169@dessent.net> <20070906183325.GA19790@ednor.casa.cgf.cx> <46E04C8E.DF3755CC@dessent.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46E04C8E.DF3755CC@dessent.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00016.txt.bz2

On Thu, Sep 06, 2007 at 11:53:02AM -0700, Brian Dessent wrote:
>Christopher Faylor wrote:
>> Nice catch!
>
>I wish I could say I caught this by inspection but it was only by single
>stepping through python guts that it became apparent what was going on.

Better you than me.  :-)

cgf
