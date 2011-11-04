Return-Path: <cygwin-patches-return-7540-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28934 invoked by alias); 4 Nov 2011 16:44:25 -0000
Received: (qmail 28915 invoked by uid 22791); 4 Nov 2011 16:44:23 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm30-vm0.access.bullet.mail.mud.yahoo.com (HELO nm30-vm0.access.bullet.mail.mud.yahoo.com) (66.94.237.86)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Fri, 04 Nov 2011 16:44:09 +0000
Received: from [66.94.237.195] by nm30.access.bullet.mail.mud.yahoo.com with NNFMP; 04 Nov 2011 16:44:08 -0000
Received: from [66.94.237.103] by tm6.access.bullet.mail.mud.yahoo.com with NNFMP; 04 Nov 2011 16:44:08 -0000
Received: from [127.0.0.1] by omp1008.access.mail.mud.yahoo.com with NNFMP; 04 Nov 2011 16:44:08 -0000
Received: (qmail 37831 invoked from network); 4 Nov 2011 16:44:08 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@98.110.183.46 with login)        by smtp104.vzn.mail.bf1.yahoo.com with SMTP; 04 Nov 2011 09:44:08 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 97BAA13C0D3	for <cygwin-patches@cygwin.com>; Fri,  4 Nov 2011 12:44:07 -0400 (EDT)
Date: Fri, 04 Nov 2011 16:44:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Extend faq.using to discuss fork failures
Message-ID: <20111104164407.GA2586@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E570031.4080800@cs.utoronto.ca> <20110830090020.GE30452@calimero.vinschen.de> <4E5CE899.4030605@cs.utoronto.ca> <4EB2C2CD.1080400@dronecode.org.uk> <20111103210519.GA4294@ednor.casa.cgf.cx> <4EB3E9D1.5090203@dronecode.org.uk> <20111104162213.GA14697@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111104162213.GA14697@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q4/txt/msg00030.txt.bz2

On Fri, Nov 04, 2011 at 12:22:13PM -0400, Christopher Faylor wrote:
>On Fri, Nov 04, 2011 at 01:34:09PM +0000, Jon TURNEY wrote:
>>On 03/11/2011 21:05, Christopher Faylor wrote:
>>> I would still prefer eschewing actively negative words like "hostile" and just
>>> neutrally stating that Windows does not use a fork/exec model and does not offer
>>> any easy way to implement fork.
>>
>>Hmm, yes, I'll fix that.
>
>Thanks.
>
>>> I'd also like to see specific errors mentioned so that when people are searching for
>>> a solution to the problem they will be able to find it in the FAQ.
>>
>>Is there something wrong with the itemized list which follows that sentence?
>
>No, sorry.  I'm email challenged at the moment so I missed it.

Btw, since this is such a glaring omission from the FAQ I think you
should make the edits that Corinna and I suggested and just check it
in.  We can tweak it as needed when people express confusion.

Thanks to you and Ryan for doing this.  We really needed it.

cgf
