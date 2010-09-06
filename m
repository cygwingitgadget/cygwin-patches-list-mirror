Return-Path: <cygwin-patches-return-7077-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3403 invoked by alias); 6 Sep 2010 15:25:55 -0000
Received: (qmail 3385 invoked by uid 22791); 6 Sep 2010 15:25:54 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-46-163.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.46.163)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 06 Sep 2010 15:25:49 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 425D013C061	for <cygwin-patches@cygwin.com>; Mon,  6 Sep 2010 11:25:47 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 01DE12B352; Mon,  6 Sep 2010 11:25:46 -0400 (EDT)
Date: Mon, 06 Sep 2010 15:25:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Cygwin Filesystem Performance degradation 1.7.5 vs 1.7.7, and methods for improving performance
Message-ID: <20100906152546.GA9157@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4C84B9EF.9030109@gmail.com> <20100906132409.GB14327@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100906132409.GB14327@calimero.vinschen.de>
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
X-SW-Source: 2010-q3/txt/msg00037.txt.bz2

Thanks for the patch and for all of the work you put into it.

On Mon, Sep 06, 2010 at 03:24:09PM +0200, Corinna Vinschen wrote:
>The patch is also missing a ChangeLog entry.  I only took a quick glance
>over the patch itself.  The code doesn't look correctly formatted in GNU
>style.  Also, using the diff -up flags would be helpful.

And, this is the type of patch which would be better served if submitted
in small chunks.  You have multiple changes in your 1158 line patch and
they don't seem to all be interrelated.

Also, in addition to formatting concerns, you don't seem to have used
comments very much.  Corinna and I have been making a concerted effort
to comment changes more thoroughly so it would be nice if your patch
contained more of those.

I didn't look at the patch very closely either since there are copyright
issues but some of your conclusions don't seem right to me.  I agree
with Corinna's response.

cgf
