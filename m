Return-Path: <cygwin-patches-return-7866-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26641 invoked by alias); 30 Apr 2013 17:31:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26626 invoked by uid 89); 30 Apr 2013 17:31:20 -0000
X-Spam-SWARE-Status: No, score=-0.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,RCVD_IN_SEMBACKSCATTER autolearn=no version=3.3.1
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Tue, 30 Apr 2013 17:31:19 +0000
Received: from pool-173-76-41-247.bstnma.fios.verizon.net ([173.76.41.247] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1UXEOb-000Fwx-P6	for cygwin-patches@cygwin.com; Tue, 30 Apr 2013 17:31:17 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id E652B60117	for <cygwin-patches@cygwin.com>; Tue, 30 Apr 2013 13:31:16 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+9U7rfabvjfv2LkqM/8lE2
Date: Tue, 30 Apr 2013 17:31:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix GCC 4.7 warnings
Message-ID: <20130430173116.GA6865@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <517F3122.8080609@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <517F3122.8080609@users.sourceforge.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2013-q2/txt/msg00004.txt.bz2

On Mon, Apr 29, 2013 at 09:49:06PM -0500, Yaakov (Cygwin/X) wrote:
>The attached patch fixes the remaining warnings in HEAD with GCC 4.7.3. 
>  OK to apply?

Thanks for doing this.  As you may have seen I started doing this earlier
and Corinna told me to stop because it interfered with the 64-bit branch.

Just a couple of changelog clarifications.

>2013-04-29  Yaakov Selkowitz  <yselkowitz@...>
>
>	Throughout, (mainly in fhandler*) fix remaining gcc 4.7 mismatch
>	warnings between regparm definitions and declarations.
>	* smallprint.cc (__small_vswprintf): Fix unused-but-set-variable
>	warning.

Conditionalize declaration and setting of l_opt for only the
__x86_64__ case.

>	* spawn.cc (child_info_spawn::worker): Ditto.

Remove unused 'pid' variable.

cgf
