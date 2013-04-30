Return-Path: <cygwin-patches-return-7871-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32575 invoked by alias); 30 Apr 2013 20:27:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 32562 invoked by uid 89); 30 Apr 2013 20:27:40 -0000
X-Spam-SWARE-Status: No, score=-1.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE autolearn=ham version=3.3.1
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Tue, 30 Apr 2013 20:27:39 +0000
Received: from pool-173-76-41-247.bstnma.fios.verizon.net ([173.76.41.247] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1UXH9G-000Byq-6V	for cygwin-patches@cygwin.com; Tue, 30 Apr 2013 20:27:38 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 817D860117	for <cygwin-patches@cygwin.com>; Tue, 30 Apr 2013 16:27:37 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19WlLGM2CMUNOi9xXOJiTv7
Date: Tue, 30 Apr 2013 20:27:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] DocBook XML toolchain modernization
Message-ID: <20130430202737.GA1858@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130424172039.GA27256@calimero.vinschen.de> <51782505.5020502@etr-usa.com> <20130424185210.GE26397@calimero.vinschen.de> <51783EBC.30409@etr-usa.com> <20130425084305.GA29270@calimero.vinschen.de> <517F15AF.5080307@etr-usa.com> <20130430184703.GB6865@ednor.casa.cgf.cx> <51801469.9070606@etr-usa.com> <20130430190706.GC6865@ednor.casa.cgf.cx> <51802510.5000803@etr-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51802510.5000803@etr-usa.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2013-q2/txt/msg00009.txt.bz2

On Tue, Apr 30, 2013 at 02:09:52PM -0600, Warren Young wrote:
>On 4/30/2013 13:07, Christopher Faylor wrote:
>> On Tue, Apr 30, 2013 at 12:58:49PM -0600, Warren Young wrote:
>>
>>> Do you mean for me to check these changes in when I get my sourceware
>>> account?
>>
>> Yes, with the implied assumption that you won't be breaking anything.
>
>Of course.
>
>Some questions from the original post:
>
>- When a change is checked in to the docs, does it immediately propagate 
>to the public web site, or is there a manual publication process?  I 
>mean, if the build is technically broken for a few seconds while I check 
>in a batch of changes, does it immediately break cygwin.com?  If so, 
>that would require that I check in only self-contained change sets even 
>if it means long CVS log messages.

No, it has to be published but you now have that ability.  The CVS path
is:  :ext:sourceware.org:/cvs/cygwin .

>- Am I right that we no longer need the second FAQ output format?

I think the single page form is the only thing required now.

>- http://cygwin.com/faq.html appears to be assembled from a site-wide 
>style/navigation file and winsup/doc/faq/faq.html.  Is that right, and 
>if so, do you mind if I add a target to the Makefile that gets you a 
>secondary variant of faq.html containing just the <body> tag's contents? 
>  Embedding <html> within <html> is eeevil.

faq.html is a pretty simple file and it seems to work.  Are there any
non-religious advantages to doing this?

>- Do you want me to do the proposed doctool to Doxygen conversion, so we 
>can get rid of doctool?

This was something that Corinna wanted so I can't comment but since she
asked you to be the maintainer, I'd say that whatever you want is
acceptable as long as we still have a readable FAQ.

>- If I get rid of doctool, do you agree that we no longer need Autoconf 
>for the docs?
>
>- Is someone using the @srcdir@ feature of the current doc build system 
>to build outside the source tree?

We always build everything in Cygwin outside of the source tree so I'd
rather keep autoconf around.  In theory you should be able to just type
"make doc" from wherever you're building cygwin and it should just work.

>- Any comments about the other items in my FUTURE WORK section? 
>Unconditional green light, or do you want to approve them one by one?

You have the right to change anything in the doc directory.  Anything
outside of that will require approval.

cgf
