Return-Path: <cygwin-patches-return-6744-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31183 invoked by alias); 7 Oct 2009 17:05:34 -0000
Received: (qmail 31173 invoked by uid 22791); 7 Oct 2009 17:05:33 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-2.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.2)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 07 Oct 2009 17:05:29 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id BADD03B0002 	for <cygwin-patches@cygwin.com>; Wed,  7 Oct 2009 13:05:19 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id B31FE2B352; Wed,  7 Oct 2009 13:05:19 -0400 (EDT)
Date: Wed, 07 Oct 2009 17:05:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Merge pseudo-reloc-v2 support from mingw/pseudo-reloc.c
Message-ID: <20091007170519.GA21247@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4ACBD892.5040508@cwilson.fastmail.fm>  <4ACBDD83.6080307@cwilson.fastmail.fm>  <20091007030342.GA13923@ednor.casa.cgf.cx>  <20091007074946.GA27186@calimero.vinschen.de>  <4ACC985A.4020502@cwilson.fastmail.fm>  <20091007150712.GA16435@ednor.casa.cgf.cx>  <4ACCB89D.4010602@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACCB89D.4010602@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00075.txt.bz2

On Wed, Oct 07, 2009 at 11:49:49AM -0400, Charles Wilson wrote:
>Christopher Faylor wrote:
>
>>> OK. But now...do we need any additional discussion of the patch itself,
>>> or did we cover that sufficiently on cygwin-developers?
>> 
>> If you've, as you say "tested" this,
>
>Yep, and no scare-quotes needed <g>.
>
>> I think we should get this in ASAP.
>
>OK.  Committed as posted (in one lump), with the following change log
>
>2009-10-06  Charles Wilson  <...>
>
>	Additional pseudo-reloc-v2 support
>	* ntdll.h: Add custom NTSTATUS value for pseudo-reloc
>	errors STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION.
>	* pinfo.cc (status_exit): Map custom pseudo-reloc
>	error value STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION to 127.
>	* sigproc.cc (child_info::proc_retry): Return exit code when
>        STATUS_ILLEGAL_DLL_PSEUDO_RELOCATION.
>
>	Cygwin modifications to pseudo-reloc.c
>	* lib/pseudo-reloc.c: Added comments throughout and various
>	whitespace fixes. Exploit cygwin_internal(CW_EXIT_PROCESS,...)
>	for fatal error handling that is consistent with cygwin process
>	life-cycle. Ensure state variable (in _pei386_runtime_relocator)
>	is unique to each address space, across fork().
>	(__print_reloc_error): New function for reporting errors in a
>	manner supported by cygwin at this early stage of the process
>	life-cycle.
>	(_pei386_runtime_relocator): Ensure relocations performed
>	only once for each address space, but are repeated after fork()
>	in the new address space.
>	only once for each address space (e.g. across fork()).
>	(__write_memory) [MINGW]: Ensure that b is always initialized
>	by call to VirtualQuery, even if -DNDEBUG.
>
>	* lib/pseudo-reloc.c: Import new implementation to support
>	v2 pseudo-relocs implemented by Kai Tietz from mingw.

Thanks.

FYI, I just generated a snapshot with this change.

cgf
