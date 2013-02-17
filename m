Return-Path: <cygwin-patches-return-7805-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24148 invoked by alias); 17 Feb 2013 16:52:35 -0000
Received: (qmail 24136 invoked by uid 22791); 17 Feb 2013 16:52:34 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 17 Feb 2013 16:52:29 +0000
Received: from pool-173-76-49-193.bstnma.fios.verizon.net ([173.76.49.193] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1U77TY-000LWL-De	for cygwin-patches@cygwin.com; Sun, 17 Feb 2013 16:52:28 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 56971880422	for <cygwin-patches@cygwin.com>; Sun, 17 Feb 2013 11:52:27 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18zUffGS6wJULdz9CLMlnX6
Date: Sun, 17 Feb 2013 16:52:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix speclib for x86_64
Message-ID: <20130217165227.GB2177@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130217044622.1034ae22@YAAKOV04> <20130217134141.GA12844@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130217134141.GA12844@calimero.vinschen.de>
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
X-SW-Source: 2013-q1/txt/msg00016.txt.bz2

On Sun, Feb 17, 2013 at 02:41:41PM +0100, Corinna Vinschen wrote:
>On Feb 17 04:46, Yaakov wrote:
>
>> 2013-02-16  Yaakov Selkowitz  <yselkowitz@...>
>> 
>> 	* Makefile.in (libcygwin.a): Move --target flag from here...
>> 	(toolopts): to here, to be used by both mkimport and speclib.
>> 	* speclib: Omit leading underscore in symbol names on x86_64.
>
>The Makefile patch is fine, but for the speclib change I wonder why
>we should omit the leading underscore.  If you remove the underscore,
>you're polluting the application namespace.  Is there really a good
>reason to do that?  Did I miss something?

Doesn't the x86_64 target forego leading underscores on normal variable
names?

cgf
