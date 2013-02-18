Return-Path: <cygwin-patches-return-7810-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9368 invoked by alias); 18 Feb 2013 15:45:04 -0000
Received: (qmail 9168 invoked by uid 22791); 18 Feb 2013 15:44:52 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,TW_KK,TW_MK
X-Spam-Check-By: sourceware.org
Received: from mho-04-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.74)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 18 Feb 2013 15:44:44 +0000
Received: from pool-173-76-49-193.bstnma.fios.verizon.net ([173.76.49.193] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1U7StY-0002xu-2q	for cygwin-patches@cygwin.com; Mon, 18 Feb 2013 15:44:44 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 3EDF988038F	for <cygwin-patches@cygwin.com>; Mon, 18 Feb 2013 10:44:43 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+FE0dXnHAtXcPJ9u+Lo0Cm
Date: Mon, 18 Feb 2013 15:45:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix speclib for x86_64
Message-ID: <20130218154443.GA2682@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130217044622.1034ae22@YAAKOV04> <20130217165159.GA2177@ednor.casa.cgf.cx> <20130218041917.7fd9498d@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130218041917.7fd9498d@YAAKOV04>
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
X-SW-Source: 2013-q1/txt/msg00021.txt.bz2

On Mon, Feb 18, 2013 at 04:19:17AM -0600, Yaakov wrote:
>On Sun, 17 Feb 2013 11:51:59 -0500, Christopher Faylor wrote:
>> >+my $uscore = ($target =~ /^x86_64\-/ ? undef : '_');
>> 
>> There is no reason to quote the dash here.  But, I would actually prefer
>> a substr check since that is a little faster.
>> 
>> my $uscore = (substr($target, 0, 7) eq 'x86_64-') ? ...
>
>I was just following the syntax already in mkimport:
>
>> my $is64bit = ($target =~ /^x86_64\-/ ? 1 : 0);

I haven't reviewed very many 64-bit changes to code that I wrote, like
mkimport or speclib.  However, my comment applies equally to mkkmport if
it is using a similar mechanism.
