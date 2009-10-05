Return-Path: <cygwin-patches-return-6700-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31710 invoked by alias); 5 Oct 2009 19:27:15 -0000
Received: (qmail 31698 invoked by uid 22791); 5 Oct 2009 19:27:14 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Oct 2009 19:27:09 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 5BD3583850 	for <cygwin-patches@cygwin.com>; Mon,  5 Oct 2009 15:27:08 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute1.internal (MEProxy); Mon, 05 Oct 2009 15:27:08 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id CF8EE74AAA; 	Mon,  5 Oct 2009 15:27:07 -0400 (EDT)
Message-ID: <4ACA4888.8020507@cwilson.fastmail.fm>
Date: Mon, 05 Oct 2009 19:27:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
References: <4ACA4323.5080103@cwilson.fastmail.fm> <4ACA47AF.7070703@gmail.com>
In-Reply-To: <4ACA47AF.7070703@gmail.com>
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
X-SW-Source: 2009-q4/txt/msg00031.txt.bz2

Dave Korn wrote:
> Charles Wilson wrote:
>> //cygwin_terminate_process (GetCurrentProcess(),
>>                             STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION);
>   Heh.  I see what you did there!

Oops.  Never cut-n-paste, and then edit.

--
Chuck
