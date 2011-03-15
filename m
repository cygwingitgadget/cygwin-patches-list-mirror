Return-Path: <cygwin-patches-return-7205-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11648 invoked by alias); 15 Mar 2011 15:04:25 -0000
Received: (qmail 11633 invoked by uid 22791); 15 Mar 2011 15:04:23 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm18-vm0.bullet.mail.sp2.yahoo.com (HELO nm18-vm0.bullet.mail.sp2.yahoo.com) (98.139.91.214)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Tue, 15 Mar 2011 15:04:17 +0000
Received: from [98.139.91.64] by nm18.bullet.mail.sp2.yahoo.com with NNFMP; 15 Mar 2011 15:04:15 -0000
Received: from [98.136.185.44] by tm4.bullet.mail.sp2.yahoo.com with NNFMP; 15 Mar 2011 15:04:15 -0000
Received: from [127.0.0.1] by smtp105.mail.gq1.yahoo.com with NNFMP; 15 Mar 2011 15:04:15 -0000
Received: from cgf.cx (cgf@98.110.183.159 with login)        by smtp105.mail.gq1.yahoo.com with SMTP; 15 Mar 2011 08:04:15 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 2EF0113C0C4	for <cygwin-patches@cygwin.com>; Tue, 15 Mar 2011 11:04:13 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id DDBE02B352; Tue, 15 Mar 2011 11:04:12 -0400 (EDT)
Date: Tue, 15 Mar 2011 15:04:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add an additional relocation attempt pass to load_after_fork()
Message-ID: <20110315150412.GA18662@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D7CDDC7.5060708@dronecode.org.uk> <20110313152111.GA7064@calimero.vinschen.de> <4D7E908B.4010004@dronecode.org.uk> <20110315075313.GA5722@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110315075313.GA5722@calimero.vinschen.de>
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
X-SW-Source: 2011-q1/txt/msg00060.txt.bz2

On Tue, Mar 15, 2011 at 08:53:13AM +0100, Corinna Vinschen wrote:
>On Mar 14 22:02, Jon TURNEY wrote:
>> On 13/03/2011 15:21, Corinna Vinschen wrote:
>> > Thanks for the patch, but afaics you don't have a copyright assignment
>> > on file with Red Hat.  It's unfortunately required for substantial
>> > patches.  Please see http://cygwin.com/contrib.html, especially the
>> > "Before you get started" section.
>> 
>> No problem, I have signed and posted an assignment, although I'm not sure I
>> consider this patch 'substantial' :-)
>
>Thanks.  I'm looking forward to get it.
>
>I think your patch is a good idea, but apart from the fact that I have
>to wait for your copyright assignment, I'm reluctant to add it to 1.7.9.
>As you probably have seen in CVS, I'm adding new stuff only to a
>post-1.7.9 branch right now.

And, since this is my code, I'd like to have the final approval on whether
it goes in or not.

cgf
