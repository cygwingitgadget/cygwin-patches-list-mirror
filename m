Return-Path: <cygwin-patches-return-7900-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6144 invoked by alias); 18 Sep 2013 18:12:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6125 invoked by uid 89); 18 Sep 2013 18:12:52 -0000
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Wed, 18 Sep 2013 18:12:52 +0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: Yes, score=5.4 required=5.0 tests=AWL,BAYES_50,FSL_HELO_NON_FQDN_1,HELO_LOCALHOST,RCVD_IN_PBL,RCVD_IN_RP_RNBL,RCVD_IN_SORBS_DUL,RP_MATCHES_RCVD autolearn=no version=3.3.2
X-HELO: mho-01-ewr.mailhop.org
Received: from pool-173-76-44-83.bstnma.fios.verizon.net ([173.76.44.83] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1VMMF4-000586-Q2	for cygwin-patches@cygwin.com; Wed, 18 Sep 2013 18:12:46 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 0197B600F9	for <cygwin-patches@cygwin.com>; Wed, 18 Sep 2013 14:12:45 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+mixTuxMI6s2w/JOcOXxHv
Date: Wed, 18 Sep 2013 18:12:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix sem_getvalue
Message-ID: <20130918181245.GC2351@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <52397810.1070600@emsys.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52397810.1070600@emsys.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2013-q3/txt/msg00007.txt.bz2

On Wed, Sep 18, 2013 at 11:53:20AM +0200, Paul Kunysch wrote:
>Hello
>
>In 1.7.24 and 1.7.25 sem_getvalue() returns the current value instead of 
>setting the out-parameter and returning 0/-1 for success/error.
>
>I attached a simple fix.

That looks like a reasonable fix.  Did you trace through all of the
callers of semaphore::_getvalue to make sure that some of them aren't
relying on the old behavior?

>I don't know if this should be further improved by setting errno to 
>EINVAL if STATUS_INVALID_HANDLE == status.

That sounds reasonable too.

>Unfortunately I wasn't able to run and extend the unit tests.  Running 
>"make check" fails with "No rule to make target `dataascii.o', needed by 
>`libltp.a'".  The VPATH seems to be extended correctly.

The tests are in a severe case of bit rot unfortunately.  It would be nice
if someone made it a mission to improve Cygwin's testing from nonexistent to
something but that is a very unrewarding a job.

cgf
