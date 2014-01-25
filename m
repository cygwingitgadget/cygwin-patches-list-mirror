Return-Path: <cygwin-patches-return-7953-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30632 invoked by alias); 25 Jan 2014 06:35:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 30616 invoked by uid 89); 25 Jan 2014 06:35:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,WEIRD_QUOTING autolearn=ham version=3.3.2
X-HELO: mho-02-ewr.mailhop.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Sat, 25 Jan 2014 06:35:07 +0000
Received: from pool-108-49-99-58.bstnma.fios.verizon.net ([108.49.99.58] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf-use-the-mailinglist-please@cygwin.com>)	id 1W6wpd-000HgU-4N	for cygwin-patches@cygwin.com; Sat, 25 Jan 2014 06:35:05 +0000
Received: from ednor (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with SMTP id 3EF82600DD	for <cygwin-patches@cygwin.com>; Sat, 25 Jan 2014 01:35:03 -0500 (EST)
Received: by ednor (sSMTP sendmail emulation); Sat, 25 Jan 2014 01:35:03 -0500
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+mrt2oHGLG6vOQxvL78GoX
Date: Sat, 25 Jan 2014 06:35:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix parameter passing containing quote/equal to Windows batch command
Message-ID: <20140125063503.GA4898@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CABDpyCh3VMDmd4Rb64Fz-cb2HzUwtZ0cY9T3xWUC8_O-eqKO6Q@mail.gmail.com> <20140124203415.GA6857@ednor.casa.cgf.cx> <CABDpyCg40oJeq=TJxFqidVsuVKRfZycLkK+kCz=Td-QgJafu4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABDpyCg40oJeq=TJxFqidVsuVKRfZycLkK+kCz=Td-QgJafu4g@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2014-q1/txt/msg00026.txt.bz2

On Fri, Jan 24, 2014 at 03:14:30PM -0800, Daniel Dai wrote:
>Hi, Christopher,
>
>The current logic is: if the parameter contains quote, then put a
>quote around the parameter (winf.cc:78). However, if the quote is in
>the beginning/end, cygwin will still quote it, and thus double quoted
>parameter (such as ""a=b"").

That is as intended.  It doesn't matter where the quote is.  This is an
argv list.  Quotes don't mean anything in a UNIX argv list.  They do
need to be quoted for Windows though.

So, if there is a quote at the beginning of argv[7], then the process
should see a quote in argv[7].

If I say pass "\"a=b\"", the subprocess should diligently report "a=b"
quotes and all.  That is what it does now after my change.

AFAICT, this is all working as it should.

cgf
