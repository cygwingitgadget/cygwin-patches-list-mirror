Return-Path: <cygwin-patches-return-7690-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18413 invoked by alias); 31 Jul 2012 21:27:36 -0000
Received: (qmail 18403 invoked by uid 22791); 31 Jul 2012 21:27:35 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-01-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.71)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 31 Jul 2012 21:27:20 +0000
Received: from pool-173-76-45-230.bstnma.fios.verizon.net ([173.76.45.230] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1SwJyJ-000JYR-Vr	for cygwin-patches@cygwin.com; Tue, 31 Jul 2012 21:27:20 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 3BCB5429680	for <cygwin-patches@cygwin.com>; Tue, 31 Jul 2012 17:27:19 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+J0/oSWBvpsnmnotIis2L7
Date: Tue, 31 Jul 2012 21:27:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: rebaseall info out of date
Message-ID: <20120731212719.GA27642@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <5018478E.5080308@etr-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5018478E.5080308@etr-usa.com>
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
X-SW-Source: 2012-q3/txt/msg00011.txt.bz2

On Tue, Jul 31, 2012 at 03:01:02PM -0600, Warren Young wrote:
>This paragraph in the rebase package README:
>
>> Note that rebaseall is only a stop-gap measure.  Eventually the rebase
>> functionality will be added to Cygwin's setup.exe, so that rebasing will
>> happen automatically.
>
>...should be rewritten.  I propose: "You should not need to run 
>rebaseall by hand.  setup.exe has done so automatically at the end of 
>each installation since Mumble 2012."  (May?  April?)
>
>A similar thing is going on in FAQ item 4.44.  I think that FAQ item 
>should be split in two, with all the rebasing related stuff answering a 
>new FAQ item, "Why does Cygwin need rebasing?", refocused on talking 
>about what setup.exe/rebaseall now does automatically and why.  FAQ item 
>4.44 will then talk about the remaining reasons fork() can fail, and 
>their possible fixes.
>
>And while I'm proposing work for other people :) is there a better 
>reason program usage info is in the README instead of man pages, besides 
>lack of time or interest?  In trying to answer the question "Why do we 
>need rebasing?" for myself, I first tried "man rebase".  (Yes, I did 
>eventually answer the question to my satisfaction.)

That might be an interesting question to ask in the Cygwin mailing list.
We don't deal with rebase packaging here.

Since none of the rest of this message contains an actual patch it is
also off-topic.  If you'd like to provide a patch for the FAQ then we'd
gratefully accept it.  Otherwise, please take "it would be nice" musings
to the main list.

cgf
