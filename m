Return-Path: <cygwin-patches-return-7146-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30113 invoked by alias); 10 Jan 2011 12:51:20 -0000
Received: (qmail 29733 invoked by uid 22791); 10 Jan 2011 12:51:09 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 10 Jan 2011 12:51:05 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 091E42CA58E; Mon, 10 Jan 2011 13:51:02 +0100 (CET)
Date: Mon, 10 Jan 2011 12:51:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck -s should not imply -d
Message-ID: <20110110125102.GA14789@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D24CB9A.2030906@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4D24CB9A.2030906@dronecode.org.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00001.txt.bz2

On Jan  5 19:50, Jon TURNEY wrote:
> 
> Currently, for cygcheck -s implies -d.  This seems rather unhelpful.
> 
> I'm afraid I've lost the thread which inspired this, but in it the reporter
> provided cygcheck -svr output as requested, but this did not help diagnose
> what ultimately turned out to be the problem, that a DLL was actually an older
> version (presumably due to replace-in-use problems)
> 
> Attached a patch to modify cygcheck so -s no longer implies -d (although -d
> can still be used).
> 

> 
> 2011-01-05  Jon TURNEY
> 
> 	* cygcheck.cc (main): don't imply -d from -s option to cygcheck

Looks good to me.  Applied.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
