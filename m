Return-Path: <cygwin-patches-return-7902-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8379 invoked by alias); 25 Sep 2013 14:46:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 8367 invoked by uid 89); 25 Sep 2013 14:46:46 -0000
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Wed, 25 Sep 2013 14:46:46 +0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: Yes, score=5.2 required=5.0 tests=AWL,BAYES_00,FSL_HELO_NON_FQDN_1,HELO_LOCALHOST,RCVD_IN_PBL,RCVD_IN_RP_RNBL,RCVD_IN_SORBS_DUL,RP_MATCHES_RCVD autolearn=no version=3.3.2
X-HELO: mho-01-ewr.mailhop.org
Received: from pool-98-110-183-21.bstnma.fios.verizon.net ([98.110.183.21] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1VOqMW-0002mS-94	for cygwin-patches@cygwin.com; Wed, 25 Sep 2013 14:46:44 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 7A429600F3	for <cygwin-patches@cygwin.com>; Wed, 25 Sep 2013 10:46:43 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/wwjpNwZo9+seU/QQGOg0P
Date: Wed, 25 Sep 2013 14:46:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix sem_getvalue
Message-ID: <20130925144643.GA3361@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <52389689.1030801@emsys.de> <5242BDCD.6090003@emsys.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5242BDCD.6090003@emsys.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2013-q3/txt/msg00009.txt.bz2

On Wed, Sep 25, 2013 at 12:41:17PM +0200, Paul Kunysch wrote:
>> That looks like a reasonable fix.  Did you trace through all of the
>> callers of semaphore::_getvalue to make sure that some of them aren't
>> relying on the old behavior?
>
>I did not look for other callers.
>
>I just wrote a very simple test for sem_getvalue() and copied different 
>cygwin1.dll versions to my test-application.

I was being too vague here.  You made what looks like a reasonable
change but it is to a low-level function which is called by more than
one place.  I was hoping that, since you wanted to see this fixed, you
might also be willing to make sure that your change doesn't break
anything else.  But, I didn't say that so, my bad.

I've checked in a modified version of your patch along with a ChangeLog.

Thanks.

cgf
