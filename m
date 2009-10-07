Return-Path: <cygwin-patches-return-6741-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4408 invoked by alias); 7 Oct 2009 13:32:28 -0000
Received: (qmail 4394 invoked by uid 22791); 7 Oct 2009 13:32:27 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 07 Oct 2009 13:32:23 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 583008AD86 	for <cygwin-patches@cygwin.com>; Wed,  7 Oct 2009 09:32:21 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute1.internal (MEProxy); Wed, 07 Oct 2009 09:32:21 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id BC17F67487; 	Wed,  7 Oct 2009 09:32:20 -0400 (EDT)
Message-ID: <4ACC985A.4020502@cwilson.fastmail.fm>
Date: Wed, 07 Oct 2009 13:32:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Merge pseudo-reloc-v2 support from mingw/pseudo-reloc.c
References: <4ACBD892.5040508@cwilson.fastmail.fm> <4ACBDD83.6080307@cwilson.fastmail.fm> <20091007030342.GA13923@ednor.casa.cgf.cx> <20091007074946.GA27186@calimero.vinschen.de>
In-Reply-To: <20091007074946.GA27186@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00072.txt.bz2

Corinna Vinschen wrote:
> Make the checkin and the ChangeLog one lump.  The ChangeLog entry is
> about the work done to put this stuff into Cygwin, which was your work.
> Don't repeat the mingw entry, rather just say that you imported from
> there and credit Kai with that entry.
> 
> Something like this.  Just subsume three paragraphs in one single
> ChangeLog entry:

OK. But now...do we need any additional discussion of the patch itself,
or did we cover that sufficiently on cygwin-developers?

--
Chuck
