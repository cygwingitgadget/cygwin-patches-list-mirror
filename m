Return-Path: <cygwin-patches-return-6743-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16679 invoked by alias); 7 Oct 2009 15:50:07 -0000
Received: (qmail 16660 invoked by uid 22791); 7 Oct 2009 15:50:06 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 07 Oct 2009 15:50:02 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 3BA8E8B4F6 	for <cygwin-patches@cygwin.com>; Wed,  7 Oct 2009 11:50:01 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute2.internal (MEProxy); Wed, 07 Oct 2009 11:50:01 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id B70FC67544; 	Wed,  7 Oct 2009 11:50:00 -0400 (EDT)
Message-ID: <4ACCB89D.4010602@cwilson.fastmail.fm>
Date: Wed, 07 Oct 2009 15:50:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Merge pseudo-reloc-v2 support from mingw/pseudo-reloc.c
References: <4ACBD892.5040508@cwilson.fastmail.fm>  <4ACBDD83.6080307@cwilson.fastmail.fm>  <20091007030342.GA13923@ednor.casa.cgf.cx>  <20091007074946.GA27186@calimero.vinschen.de>  <4ACC985A.4020502@cwilson.fastmail.fm> <20091007150712.GA16435@ednor.casa.cgf.cx>
In-Reply-To: <20091007150712.GA16435@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q4/txt/msg00074.txt.bz2

Christopher Faylor wrote:

>> OK. But now...do we need any additional discussion of the patch itself,
>> or did we cover that sufficiently on cygwin-developers?
> 
> If you've, as you say "tested" this,

Yep, and no scare-quotes needed <g>.

> I think we should get this in ASAP.

OK.  Committed as posted (in one lump), with the following change log

2009-10-06  Charles Wilson  <...>

	Additional pseudo-reloc-v2 support
	* ntdll.h: Add custom NTSTATUS value for pseudo-reloc
	errors STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION.
	* pinfo.cc (status_exit): Map custom pseudo-reloc
	error value STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION to 127.
	* sigproc.cc (child_info::proc_retry): Return exit code when
        STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION.

	Cygwin modifications to pseudo-reloc.c
	* lib/pseudo-reloc.c: Added comments throughout and various
	whitespace fixes. Exploit cygwin_internal(CW_EXIT_PROCESS,...)
	for fatal error handling that is consistent with cygwin process
	life-cycle. Ensure state variable (in _pei386_runtime_relocator)
	is unique to each address space, across fork().
	(__print_reloc_error): New function for reporting errors in a
	manner supported by cygwin at this early stage of the process
	life-cycle.
	(_pei386_runtime_relocator): Ensure relocations performed
	only once for each address space, but are repeated after fork()
	in the new address space.
	only once for each address space (e.g. across fork()).
	(__write_memory) [MINGW]: Ensure that b is always initialized
	by call to VirtualQuery, even if -DNDEBUG.

	* lib/pseudo-reloc.c: Import new implementation to support
	v2 pseudo-relocs implemented by Kai Tietz from mingw.

--
Chuck



