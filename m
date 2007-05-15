Return-Path: <cygwin-patches-return-6083-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12052 invoked by alias); 15 May 2007 01:28:42 -0000
Received: (qmail 12025 invoked by uid 22791); 15 May 2007 01:28:40 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-68.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 15 May 2007 01:28:37 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 9B3632B353; Mon, 14 May 2007 21:28:35 -0400 (EDT)
Date: Tue, 15 May 2007 01:28:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] getmntent()->mnt_type values that match Linux...
Message-ID: <20070515012835.GA12106@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <45FE2DF8.40709@icculus.org> <46136153.8030000@icculus.org> <20070404084930.GK20261@calimero.vinschen.de> <20070404160309.GB1672@calimero.vinschen.de> <20070404181833.GA17836@ednor.casa.cgf.cx> <20070404181907.GA17856@ednor.casa.cgf.cx> <46165DF3.6000503@icculus.org> <46169574.4020205@icculus.org> <20070416145004.GA13761@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070416145004.GA13761@trixie.casa.cgf.cx>
User-Agent: Mutt/1.5.14 (2007-02-12)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00029.txt.bz2

On Mon, Apr 16, 2007 at 10:50:04AM -0400, Christopher Faylor wrote:
>On Fri, Apr 06, 2007 at 02:46:12PM -0400, Ryan C. Gordon wrote:
>>>>Actually, I'd appreciate it if the patch could be resubmitted against
>>>>current CVS. 
>>>I'll do this shortly.
>>
>>I just checked...the patch still applies cleanly to the latest CVS...the 
>>changed files haven't been altered between when I wrote it and now.
>>
>>Let me know if you want me to resend it, but otherwise, the previous 
>>patch is still the one to use.
>
>I've applied the patch to my local sandbox.  It looks good except for a couple
>of very minor formatting problems (no spaces after a function name).  I'm in
>the process of a major computer revamp at my home so I can't test these things
>quickly but I hope to have this committed sometime in the next couple of days.

How embarrassing.  I completely forgot about this.  I noticed it after doing a
'cvs diff' while applying Eric's patch.

In any event, this is now checked in.  It will be in the next snapshot.

Thanks for the patch and apologies again for forgetting about it.

cgf
