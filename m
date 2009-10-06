Return-Path: <cygwin-patches-return-6720-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26196 invoked by alias); 6 Oct 2009 18:22:36 -0000
Received: (qmail 26185 invoked by uid 22791); 6 Oct 2009 18:22:35 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-48-2.bstnma.east.verizon.net (HELO cgf.cx) (173.76.48.2)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 18:22:31 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id DC9893B000F 	for <cygwin-patches@cygwin.com>; Tue,  6 Oct 2009 14:22:21 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id DC00C2B352; Tue,  6 Oct 2009 14:22:21 -0400 (EDT)
Date: Tue, 06 Oct 2009 18:22:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
Message-ID: <20091006182221.GD18135@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4ACA4323.5080103@cwilson.fastmail.fm>  <20091005202722.GG12789@calimero.vinschen.de>  <4ACA5BC7.6090908@cwilson.fastmail.fm>  <20091006034229.GA12172@ednor.casa.cgf.cx>  <4ACAC079.2020105@cwilson.fastmail.fm>  <20091006074620.GA13712@calimero.vinschen.de>  <4ACB56D5.4060606@cwilson.fastmail.fm>  <4ACB670F.2070209@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ACB670F.2070209@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00051.txt.bz2

On Tue, Oct 06, 2009 at 11:49:35AM -0400, Charles Wilson wrote:
>Charles Wilson wrote:
>>> I can live with both variations, though I like the one entry point idea
>>> as in `cygwin_internal (CW_EXIT_PROCESS, UINT, bool)'  more.
>> 
>> As re-implemented, attached. (I used the windows BOOL type, rather than
>> the C99/C++ bool type).  Test case:
>
>AND...regenerated the patch against this morning's CVS, in which the
>sigExeced stuff was committed. (Patch unchanged except exceptions.cc ang
>globals.cc stuff removed from patch).
>
>2009-10-05  Charles Wilson  <...>
>
>	Add cygwin wrapper for ExitProcess and TerminateProcess.
>	* include/sys/cygwin.h: Declare new cygwin_getinfo_type
>	CW_EXIT_PROCESS.
>	* external.cc (exit_process): New function.
>	(cygwin_internal): Handle CW_EXIT_PROCESS.
>	* pinfo.h (pinfo::set_exit_code): New method.
>	* pinfo.cc (pinfo::set_exit_code): New, refactored from...
>	(pinfo::maybe_set_exit_code_from_windows): here. Call it.

Looks good with a minor kvetch: Could you use "bool" instead of "BOOL"
for variables that don't have to be passed to a Windows function that
takes a BOOL argument?

If you make that change, I'm fine with this change.  And thanks, once again,
for seeing this through.

cgf
