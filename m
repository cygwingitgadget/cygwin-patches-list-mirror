Return-Path: <cygwin-patches-return-7612-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14600 invoked by alias); 1 Mar 2012 06:01:43 -0000
Received: (qmail 14320 invoked by uid 22791); 1 Mar 2012 06:01:42 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 01 Mar 2012 06:01:27 +0000
Received: from pool-173-76-50-248.bstnma.fios.verizon.net ([173.76.50.248] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1S2z4w-000LIO-IT	for cygwin-patches@cygwin.com; Thu, 01 Mar 2012 06:01:26 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 1BCAC13C0CD	for <cygwin-patches@cygwin.com>; Thu,  1 Mar 2012 01:01:26 -0500 (EST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/vK9xPeymrfhVHTmEBDcum
Date: Thu, 01 Mar 2012 06:01:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] doc: update tcl/tk FAQ
Message-ID: <20120301060126.GA21611@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <70952A932255A2489522275A628B97C3129F4A01@xmb-sjc-233.amer.cisco.com> <1330563447.7632.19.camel@YAAKOV04> <20120301011504.GA19191@ednor.casa.cgf.cx> <1330581398.7632.35.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1330581398.7632.35.camel@YAAKOV04>
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
X-SW-Source: 2012-q1/txt/msg00035.txt.bz2

On Wed, Feb 29, 2012 at 11:56:38PM -0600, Yaakov (Cygwin/X) wrote:
>On Wed, 2012-02-29 at 20:15 -0500, Christopher Faylor wrote:
>> On Wed, Feb 29, 2012 at 06:57:27PM -0600, Yaakov (Cygwin/X) wrote:
>> >Using X requires user intervention to start an X server first.  No
>> >amount of automatic dependencies will change this, and therefore I don't
>> >expect that the number of questions would change one iota.
>> 
>> I agree 100% but this now qualifies as a FAQ so maybe we should add an
>> entry about tcl/tk.
>
>Patch attached.

>2012-02-??  Yaakov Selkowitz  <yselkowitz@...>
>
>	* faq-programming.xml (faq.programming.make-execvp): Remove obsolete
>	information about Tcl/Tk.
>	(faq.programming.dll-relocatable): Ditto.
>	* faq-using.xml (faq.using.tcl-tk): Rewrite to reflect switch to
>	X11 Tcl/Tk.

Thanks very much for this, Yaakov.  I appreciate that you removed the obsolete
stuff as well as adding new wording.

Please apply.

cgf
