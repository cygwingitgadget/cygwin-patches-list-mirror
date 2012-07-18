Return-Path: <cygwin-patches-return-7680-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28820 invoked by alias); 18 Jul 2012 01:37:47 -0000
Received: (qmail 28810 invoked by uid 22791); 18 Jul 2012 01:37:47 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 18 Jul 2012 01:37:32 +0000
Received: from pool-173-76-45-230.bstnma.fios.verizon.net ([173.76.45.230] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1SrJCm-000LwW-BE	for cygwin-patches@cygwin.com; Wed, 18 Jul 2012 01:37:32 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 682EE429680	for <cygwin-patches@cygwin.com>; Tue, 17 Jul 2012 21:37:31 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+8juVRzpwligsX1fulvPRP
Date: Wed, 18 Jul 2012 01:37:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: *Very* outdated FAQ entry
Message-ID: <20120718013731.GA4570@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20120717190842.GF31055@calimero.vinschen.de> <500603C6.1000708@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <500603C6.1000708@users.sourceforge.net>
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
X-SW-Source: 2012-q3/txt/msg00001.txt.bz2

On Tue, Jul 17, 2012 at 07:31:02PM -0500, Yaakov (Cygwin/X) wrote:
>On 2012-07-17 14:08, Corinna Vinschen wrote:
>> due to Aram's request for permission to translate the FAQ, I accidentally
>> stumbled over FAQ entry 6.40, "How should I port my Unix GUI to Windows?",
>> http://cygwin.com/faq-nochunks.html#faq.programming.unix-gui
>>
>> Per cvs annotate, this text is at least 7 years old but probably older.
>> As such, it is hopelessly outdated.
>>
>> Given that we have X, the X server, and a lot of extra libs like GTK
>> Qt, etc, does anybody have a good idea how to rewrite the FAQ entry
>> so that it makes sense in our modern times?  Kind of like "only
>> marginal porting necessary"?  Patches are welcome.
>
>How about the attached?

Looks good to me.

cgf
