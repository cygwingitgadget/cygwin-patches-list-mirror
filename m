Return-Path: <cygwin-patches-return-7904-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1796 invoked by alias); 15 Oct 2013 14:06:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1773 invoked by uid 89); 15 Oct 2013 14:06:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: mho-01-ewr.mailhop.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Tue, 15 Oct 2013 14:06:55 +0000
Received: from pool-98-110-183-69.bstnma.fios.verizon.net ([98.110.183.69] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1VW5Gv-000PES-0r	for cygwin-patches@cygwin.com; Tue, 15 Oct 2013 14:06:53 +0000
Received: from cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 3EA4360114	for <cygwin-patches@cygwin.com>; Tue, 15 Oct 2013 10:06:52 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/hMjktlgACb01B6V4tpszY
Date: Tue, 15 Oct 2013 14:06:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fix off-by-one in dup2
Message-ID: <20131015140652.GA2098@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <52437121.1070507@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52437121.1070507@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2013-q4/txt/msg00000.txt.bz2

On Wed, Sep 25, 2013 at 05:26:25PM -0600, Eric Blake wrote:
>Solves the segfault here: http://cygwin.com/ml/cygwin/2013-09/msg00397.html
>but does not address the fact that we are still screwy with regards to
>rlimit.

Corinna reminded me about this.

Sorry for the delay in responding.  I was investigating if setdtablesize
should set an errno on error but it is difficult to say if it should
since it seems not to be a POSIX or Linux.  So, I guess we can just say
that it should set EINVAL.  Would you mind making that minor change and
checking this in?

cgf
