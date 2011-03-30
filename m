Return-Path: <cygwin-patches-return-7230-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26247 invoked by alias); 30 Mar 2011 21:30:00 -0000
Received: (qmail 26237 invoked by uid 22791); 30 Mar 2011 21:29:59 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm5.bullet.mail.ne1.yahoo.com (HELO nm5.bullet.mail.ne1.yahoo.com) (98.138.90.68)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 30 Mar 2011 21:29:54 +0000
Received: from [98.138.90.51] by nm5.bullet.mail.ne1.yahoo.com with NNFMP; 30 Mar 2011 21:29:53 -0000
Received: from [98.138.87.1] by tm4.bullet.mail.ne1.yahoo.com with NNFMP; 30 Mar 2011 21:29:53 -0000
Received: from [127.0.0.1] by omp1001.mail.ne1.yahoo.com with NNFMP; 30 Mar 2011 21:29:53 -0000
Received: (qmail 29705 invoked from network); 30 Mar 2011 21:29:53 -0000
Received: from cgf.cx (cgf@72.70.43.165 with login)        by smtp148.mail.mud.yahoo.com with SMTP; 30 Mar 2011 14:29:53 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 91F384A801A	for <cygwin-patches@cygwin.com>; Wed, 30 Mar 2011 17:29:51 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 8FC052B35F; Wed, 30 Mar 2011 17:29:51 -0400 (EDT)
Date: Wed, 30 Mar 2011 21:30:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add an additional relocation attempt pass to load_after_fork()
Message-ID: <20110330212951.GC28494@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4D7CDDC7.5060708@dronecode.org.uk> <20110313152111.GA7064@calimero.vinschen.de> <4D7E908B.4010004@dronecode.org.uk> <20110315075313.GA5722@calimero.vinschen.de> <20110315150412.GA18662@ednor.casa.cgf.cx> <20110315154609.GE4320@calimero.vinschen.de> <20110330211556.GE13484@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110330211556.GE13484@calimero.vinschen.de>
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
X-SW-Source: 2011-q1/txt/msg00085.txt.bz2

On Wed, Mar 30, 2011 at 11:15:56PM +0200, Corinna Vinschen wrote:
>Hi Jon,
>
>On Mar 15 16:46, Corinna Vinschen wrote:
>> On Mar 15 11:04, Christopher Faylor wrote:
>> > On Tue, Mar 15, 2011 at 08:53:13AM +0100, Corinna Vinschen wrote:
>> > >On Mar 14 22:02, Jon TURNEY wrote:
>> > >> On 13/03/2011 15:21, Corinna Vinschen wrote:
>> > >> > Thanks for the patch, but afaics you don't have a copyright assignment
>> > >> > on file with Red Hat.  It's unfortunately required for substantial
>> > >> > patches.  Please see http://cygwin.com/contrib.html, especially the
>> > >> > "Before you get started" section.
>> > >> 
>> > >> No problem, I have signed and posted an assignment, although I'm not sure I
>> > >> consider this patch 'substantial' :-)
>> > >
>> > >Thanks.  I'm looking forward to get it.
>> > >
>> > >I think your patch is a good idea, but apart from the fact that I have
>> > >to wait for your copyright assignment, I'm reluctant to add it to 1.7.9.
>> > >As you probably have seen in CVS, I'm adding new stuff only to a
>> > >post-1.7.9 branch right now.
>> > 
>> > And, since this is my code, I'd like to have the final approval on whether
>> > it goes in or not.
>> 
>> Sure.
>
>Your copyright assignment has been ountersigned by my manager today.
>Chris, are you going to take a look into this patch?

yep.

cgf
