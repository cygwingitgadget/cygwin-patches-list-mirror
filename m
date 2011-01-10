Return-Path: <cygwin-patches-return-7147-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31638 invoked by alias); 10 Jan 2011 17:53:00 -0000
Received: (qmail 31593 invoked by uid 22791); 10 Jan 2011 17:52:50 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-93-220-155.bstnma.fios.verizon.net (HELO cgf.cx) (72.93.220.155)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 10 Jan 2011 17:52:45 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 4ED4D13C0C9	for <cygwin-patches@cygwin.com>; Mon, 10 Jan 2011 12:52:44 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 3E4562B352; Mon, 10 Jan 2011 12:52:44 -0500 (EST)
Date: Mon, 10 Jan 2011 17:53:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck -s should not imply -d
Message-ID: <20110110175244.GC10806@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D24CB9A.2030906@dronecode.org.uk> <20110110125102.GA14789@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110110125102.GA14789@calimero.vinschen.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00002.txt.bz2

On Mon, Jan 10, 2011 at 01:51:02PM +0100, Corinna Vinschen wrote:
>On Jan  5 19:50, Jon TURNEY wrote:
>> 
>> Currently, for cygcheck -s implies -d.  This seems rather unhelpful.
>> 
>> I'm afraid I've lost the thread which inspired this, but in it the reporter
>> provided cygcheck -svr output as requested, but this did not help diagnose
>> what ultimately turned out to be the problem, that a DLL was actually an older
>> version (presumably due to replace-in-use problems)
>> 
>> Attached a patch to modify cygcheck so -s no longer implies -d (although -d
>> can still be used).
>> 
>
>> 
>> 2011-01-05  Jon TURNEY
>> 
>> 	* cygcheck.cc (main): don't imply -d from -s option to cygcheck
>
>Looks good to me.  Applied.

Sorry that I didn't reply to this.  I wasn't 100% convinced that this
was a good idea since some of the packages show up as having problems
when they are ok.  I was wondering if that would end up generating more
(understandably) confused mailing list traffic but I guess, in the end,
it probably is better to check the validity of the packages for the
prescribed error reporting technique.

cgf
