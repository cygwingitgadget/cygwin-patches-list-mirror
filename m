Return-Path: <cygwin-patches-return-7898-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20464 invoked by alias); 16 Sep 2013 17:40:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 20452 invoked by uid 89); 16 Sep 2013 17:40:26 -0000
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Mon, 16 Sep 2013 17:40:26 +0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=4.9 required=5.0 tests=AWL,BAYES_40,FSL_HELO_NON_FQDN_1,HELO_LOCALHOST,RCVD_IN_PBL,RCVD_IN_RP_RNBL,RCVD_IN_SORBS_DUL,RP_MATCHES_RCVD autolearn=no version=3.3.2
X-HELO: mho-02-ewr.mailhop.org
Received: from pool-173-76-44-83.bstnma.fios.verizon.net ([173.76.44.83] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1VLcme-0006jK-BJ	for cygwin-patches@cygwin.com; Mon, 16 Sep 2013 17:40:24 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 677CB600E9	for <cygwin-patches@cygwin.com>; Mon, 16 Sep 2013 13:40:23 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/ARczI8hazHeQuo3PKkAAu
Date: Mon, 16 Sep 2013 17:40:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: xz packages
Message-ID: <20130916174023.GA3279@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <52334717.6070803@users.sourceforge.net> <20130913180619.GB7571@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130913180619.GB7571@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2013-q3/txt/msg00005.txt.bz2

On Fri, Sep 13, 2013 at 02:06:19PM -0400, Christopher Faylor wrote:
>On Fri, Sep 13, 2013 at 12:10:47PM -0500, Yaakov (Cygwin/X) wrote:
>>cygcheck needs fixing wrt .tar.xz packages; patch attached.
>
>Thanks for noticing this but I think I'd like to see a more general
>fix.  In upset, I just completely relaxed the checking of .gz/.bz2/.xz
>in favor of just checking for .tar.  So, instead, something like the
>below.
>
>I can't confirm right now if this works or not so I won't check it in
>until I can.

I just confirmed: It doesn't work.  I did, however, check in a modified
version that has the salutary effect of not segv'ing.  It seems to work
but, now that I think of it, I haven't downloaded any new packages with
.xz extensions.  It is general enough that, if it works for .tar.bz2, it
should also work for .tar.xz.

Thanks again for noticing this Yaakov.

cgf
