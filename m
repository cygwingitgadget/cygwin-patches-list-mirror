Return-Path: <cygwin-patches-return-7033-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25023 invoked by alias); 7 May 2010 04:57:35 -0000
Received: (qmail 25010 invoked by uid 22791); 7 May 2010 04:57:34 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_LOW,TW_CG
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 07 May 2010 04:57:31 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41])	by gateway1.messagingengine.com (Postfix) with ESMTP id 9A0C3F20C5	for <cygwin-patches@cygwin.com>; Fri,  7 May 2010 00:57:29 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])  by compute1.internal (MEProxy); Fri, 07 May 2010 00:57:29 -0400
Received: from [192.168.1.3] (unknown [24.110.45.162])	by mail.messagingengine.com (Postfix) with ESMTPSA id 3A30E1EBAB;	Fri,  7 May 2010 00:57:29 -0400 (EDT)
Message-ID: <4BE39DA9.1080902@cwilson.fastmail.fm>
Date: Fri, 07 May 2010 04:57:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: CFA: pseudo-reloc v2
References: <1273170255.10571.1373764557@webmail.messagingengine.com> <4BE316D7.3070806@gmail.com>
In-Reply-To: <4BE316D7.3070806@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q2/txt/msg00016.txt.bz2

On 5/6/2010 3:21 PM, Dave Korn wrote:
> On 06/05/2010 19:24, Charles Wilson wrote:
> 
>> But...if I understand correctly, doing this moves the "fix" for the
>> problem Dave identified into that internal code -- which means that the
>> mingw guys won't benefit from it, unless they re-implement it in the
>> "outside" code.  
> 
>   The mingw guys won't benefit from this fix until they implement fork
> semantics, i.e. never...

Oh, right. You even mentioned the "forkee" right there in the first
message after resurrecting this thread.  OK, I'll wait to see what cgf
cooks up before commenting further.


==Aside:
After all my talk about keeping pseudo_reloc.c synchronized, I'm
considering adapting Dave's implementation for MSYS, because I'm pretty
sure that whatever cgf comes up with for "inside cygwin-1.7.6" isn't
going to work very well "inside msys which is kinda sorta cygwin-1.3.4"
-- although I could be lucky I suppose.  Oh well.  There are only a few
msys applications/dlls which are built with pseudo-relocs turned on
anyway -- just guile and autogen AFAICT -- so "rebuild all of them to
obtain new fixes" is not very onerous.

--
Chuck
