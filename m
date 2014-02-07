Return-Path: <cygwin-patches-return-7959-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24268 invoked by alias); 7 Feb 2014 17:44:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 24256 invoked by uid 89); 7 Feb 2014 17:44:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.2 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: mho-01-ewr.mailhop.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Fri, 07 Feb 2014 17:44:35 +0000
Received: from pool-71-126-240-215.bstnma.fios.verizon.net ([71.126.240.215] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf-use-the-mailinglist-please@cygwin.com>)	id 1WBpTd-000N8n-Gj	for cygwin-patches@cygwin.com; Fri, 07 Feb 2014 17:44:33 +0000
Received: from ednor (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with SMTP id BD59E60114	for <cygwin-patches@cygwin.com>; Fri,  7 Feb 2014 12:44:31 -0500 (EST)
Received: by ednor (sSMTP sendmail emulation); Fri, 07 Feb 2014 12:44:31 -0500
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+ieDf7zU+Uk7yzFAfdEUho
Date: Fri, 07 Feb 2014 17:44:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add minidump write utility
Message-ID: <20140207174431.GA1640@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <52F50B71.8030608@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52F50B71.8030608@dronecode.org.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2014-q1/txt/msg00032.txt.bz2

On Fri, Feb 07, 2014 at 04:36:01PM +0000, Jon TURNEY wrote:
>
>This patch adds a 'minidumper' utility, which functions identically to
>'dumper' except it writes a Windows minidump, rather than a core file.
>	
>I'm not sure if this is of use to anyone but me, but since I've had the patch
>sitting around for a couple of years, here it is...
>
>2014-02-07  Jon TURNEY  <jon.turney@dronecode.org.uk>
>
>	* minidumper.cc: New file.
>	* Makefile.in (CYGWIN_BINS): Add minidumper.
>	* utils.xml (minidumper): New section.

This is awesome.  Thanks.

Could you add Red Hat as the copyright holder, like dumper.cc?

You can feel free to check this in and update it as you see fit.

Thanks for doing this.

cgf
