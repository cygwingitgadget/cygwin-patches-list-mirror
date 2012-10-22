Return-Path: <cygwin-patches-return-7744-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16631 invoked by alias); 22 Oct 2012 12:00:42 -0000
Received: (qmail 16620 invoked by uid 22791); 22 Oct 2012 12:00:41 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-04-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.74)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 22 Oct 2012 12:00:37 +0000
Received: from pool-72-74-71-200.bstnma.fios.verizon.net ([72.74.71.200] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1TQGgO-0008Ke-TO	for cygwin-patches@cygwin.com; Mon, 22 Oct 2012 12:00:36 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id E52B613C005	for <cygwin-patches@cygwin.com>; Mon, 22 Oct 2012 08:00:35 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+uX59yTs4J2fmpZkpw/WWL
Date: Mon, 22 Oct 2012 12:00:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
Message-ID: <20121022120035.GA15284@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20121018083419.GC6221@calimero.vinschen.de> <1350580828.3492.73.camel@YAAKOV04> <20121019092135.GA22432@calimero.vinschen.de> <1350664438.3492.114.camel@YAAKOV04> <20121019184636.GZ25877@calimero.vinschen.de> <20121021113320.GA2469@calimero.vinschen.de> <20121021171053.GA24725@ednor.casa.cgf.cx> <1350844361.1244.54.camel@YAAKOV04> <20121022040942.GA9515@ednor.casa.cgf.cx> <20121022082913.GB2469@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121022082913.GB2469@calimero.vinschen.de>
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
X-SW-Source: 2012-q4/txt/msg00021.txt.bz2

On Mon, Oct 22, 2012 at 10:29:13AM +0200, Corinna Vinschen wrote:
>On Oct 22 00:09, Christopher Faylor wrote:
>Yeah, since the changes to the configury separate Cygwin from mingw and
>w32api, staying in src/winsup is no problem at all.  I always thought
>mingw is part of the src tree for gcc bootstrap reasons.

winsup is not part of the gcc source tree in SVN.  So, if it is
necessary for bootstrapping it must have to be pulled in separately
anyway.

And, if we're talking about moving cygwin entirely to w64api then I
don't see how it could be part of the gcc bootstrap.

But, even if it was, I don't see why we would have to limit our
directory layout for another project.

cgf
