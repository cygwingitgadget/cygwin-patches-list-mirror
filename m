Return-Path: <cygwin-patches-return-6065-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5338 invoked by alias); 16 Apr 2007 14:50:15 -0000
Received: (qmail 5326 invoked by uid 22791); 16 Apr 2007 14:50:14 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-70-61-13.bstnma.fios.verizon.net (HELO cgf.cx) (72.70.61.13)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 16 Apr 2007 15:50:06 +0100
Received: by cgf.cx (Postfix, from userid 201) 	id 9F88A13C0AC; Mon, 16 Apr 2007 10:50:04 -0400 (EDT)
Date: Mon, 16 Apr 2007 14:50:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] getmntent()->mnt_type values that match Linux...
Message-ID: <20070416145004.GA13761@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <45FE2DF8.40709@icculus.org> <46136153.8030000@icculus.org> <20070404084930.GK20261@calimero.vinschen.de> <20070404160309.GB1672@calimero.vinschen.de> <20070404181833.GA17836@ednor.casa.cgf.cx> <20070404181907.GA17856@ednor.casa.cgf.cx> <46165DF3.6000503@icculus.org> <46169574.4020205@icculus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46169574.4020205@icculus.org>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00011.txt.bz2

On Fri, Apr 06, 2007 at 02:46:12PM -0400, Ryan C. Gordon wrote:
>>>Actually, I'd appreciate it if the patch could be resubmitted against
>>>current CVS. 
>>I'll do this shortly.
>
>I just checked...the patch still applies cleanly to the latest CVS...the 
>changed files haven't been altered between when I wrote it and now.
>
>Let me know if you want me to resend it, but otherwise, the previous 
>patch is still the one to use.

I've applied the patch to my local sandbox.  It looks good except for a couple
of very minor formatting problems (no spaces after a function name).  I'm in
the process of a major computer revamp at my home so I can't test these things
quickly but I hope to have this committed sometime in the next couple of days.

FYI,
cgf
