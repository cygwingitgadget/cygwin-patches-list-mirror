Return-Path: <cygwin-patches-return-7640-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16430 invoked by alias); 17 Apr 2012 14:20:05 -0000
Received: (qmail 16283 invoked by uid 22791); 17 Apr 2012 14:20:02 -0000
X-SWARE-Spam-Status: No, hits=-0.5 required=5.0	tests=AWL,BAYES_50,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 17 Apr 2012 14:19:49 +0000
Received: from pool-98-110-186-28.bstnma.fios.verizon.net ([98.110.186.28] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1SK9G0-00093C-Ne	for cygwin-patches@cygwin.com; Tue, 17 Apr 2012 14:19:48 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id D0BA413C076	for <cygwin-patches@cygwin.com>; Tue, 17 Apr 2012 10:19:47 -0400 (EDT)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19B1RFL7yH5LhmYssWx44ka
Date: Tue, 17 Apr 2012 14:20:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Setting TZ may break time() in non-Cygwin programs
Message-ID: <20120417141947.GB15491@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4F4FD8C6.5000807@t-online.de> <20120302091317.GD14404@calimero.vinschen.de> <4F513D11.2080203@t-online.de> <20120304115232.GC18852@calimero.vinschen.de> <4F53B791.2090709@t-online.de> <20120304204938.GL18852@calimero.vinschen.de> <4F85D2F4.8090204@t-online.de> <20120417070615.GA22155@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120417070615.GA22155@calimero.vinschen.de>
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
X-SW-Source: 2012-q2/txt/msg00009.txt.bz2

On Tue, Apr 17, 2012 at 09:06:15AM +0200, Corinna Vinschen wrote:
>On Apr 11 20:52, Christian Franke wrote:
>> Yes. Patch is attached.
>> 
>> Christian
>> 
>
>Thanks for the patch.  I'm just wondering if we shouldn't generalize
>this right from the start by keeping an array of variables to skip
>when starting native apps and a function to handle this, along the
>lines of the getwinenv function and the conv_envvars array.
>It might only contain TZ now, but there's always a chance we suddenly
>stumble over a similar problem, isn't it?

I really hate having Cygwin be "smart" like this.  It seems like it's
asking for a follow-on "How do I set TZ for my Windoze program???"
email, followed by a "We need a CYGWIN environment variable option!"

What's the problem with just unsetting TZ again?  Yes, I know you
have to remember to do it but does this affect enough programs that
we need to add even more head standing code in Cygwin to accommodate
it.

cgf
