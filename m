Return-Path: <cygwin-patches-return-6712-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1642 invoked by alias); 6 Oct 2009 03:59:02 -0000
Received: (qmail 1631 invoked by uid 22791); 6 Oct 2009 03:59:02 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 03:58:56 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 66BF28385B 	for <cygwin-patches@cygwin.com>; Mon,  5 Oct 2009 23:58:55 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute2.internal (MEProxy); Mon, 05 Oct 2009 23:58:55 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 0693A3860; 	Mon,  5 Oct 2009 23:58:54 -0400 (EDT)
Message-ID: <4ACAC079.2020105@cwilson.fastmail.fm>
Date: Tue, 06 Oct 2009 03:59:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
References: <4ACA4323.5080103@cwilson.fastmail.fm>  <20091005202722.GG12789@calimero.vinschen.de>  <4ACA5BC7.6090908@cwilson.fastmail.fm> <20091006034229.GA12172@ednor.casa.cgf.cx>
In-Reply-To: <20091006034229.GA12172@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q4/txt/msg00043.txt.bz2

Christopher Faylor wrote:
> On Mon, Oct 05, 2009 at 04:49:11PM -0400, Charles Wilson wrote:
>> hmm...probably
>>     cygwin_internal (CW_TERMINATE_PROCESS, HANDLE, UINT)
>>     cygwin_internal (CW_EXIT_PROCESS, UINT)
>> right?
> 
> Do we really have to provide the ability to kill some other process?
> Maybe we really only need one call with two arguments - one which is the
> exit value and one which indicates whether to exit with prejudice.
> 
> cygwin_internal (CW_EXIT_PROCESS, UINT, bool);
> 
> where the bool argument is true if we want to call TerminateProcess on
> this process.

Fine with me. The two-function version was just a derivative of my
earlier "just wrap [Exit|Terminate]Process" approach, trying to mimic
the w32api.

However

by going the cgywin_internal route, there's really no point in slavishly
following the w32api. And besides, the implementation of
cygwin_internal(CW_TERMINATE_PROCESS,...) really does nothing special if
called with a HANDLE to a different process -- you might as well call
TerminateProcess() itself, in that case.

I'll wait for other comments, before taking any additional action, tho.

--
Chuck
