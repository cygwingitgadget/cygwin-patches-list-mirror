Return-Path: <cygwin-patches-return-6717-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21716 invoked by alias); 6 Oct 2009 15:49:49 -0000
Received: (qmail 21706 invoked by uid 22791); 6 Oct 2009 15:49:48 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 15:49:43 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id D83448311F 	for <cygwin-patches@cygwin.com>; Tue,  6 Oct 2009 11:49:41 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute2.internal (MEProxy); Tue, 06 Oct 2009 11:49:41 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 6CBE443AE; 	Tue,  6 Oct 2009 11:49:41 -0400 (EDT)
Message-ID: <4ACB670F.2070209@cwilson.fastmail.fm>
Date: Tue, 06 Oct 2009 15:49:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
References: <4ACA4323.5080103@cwilson.fastmail.fm> <20091005202722.GG12789@calimero.vinschen.de> <4ACA5BC7.6090908@cwilson.fastmail.fm> <20091006034229.GA12172@ednor.casa.cgf.cx> <4ACAC079.2020105@cwilson.fastmail.fm> <20091006074620.GA13712@calimero.vinschen.de> <4ACB56D5.4060606@cwilson.fastmail.fm>
In-Reply-To: <4ACB56D5.4060606@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00048.txt.bz2

Charles Wilson wrote:
>> I can live with both variations, though I like the one entry point idea
>> as in `cygwin_internal (CW_EXIT_PROCESS, UINT, bool)'  more.
> 
> As re-implemented, attached. (I used the windows BOOL type, rather than
> the C99/C++ bool type).  Test case:

AND...regenerated the patch against this morning's CVS, in which the
sigExeced stuff was committed. (Patch unchanged except exceptions.cc ang
globals.cc stuff removed from patch).

2009-10-05  Charles Wilson  <...>

	Add cygwin wrapper for ExitProcess and TerminateProcess.
	* include/sys/cygwin.h: Declare new cygwin_getinfo_type
	CW_EXIT_PROCESS.
	* external.cc (exit_process): New function.
	(cygwin_internal): Handle CW_EXIT_PROCESS.
	* pinfo.h (pinfo::set_exit_code): New method.
	* pinfo.cc (pinfo::set_exit_code): New, refactored from...
	(pinfo::maybe_set_exit_code_from_windows): here. Call it.

--
Chuck
