Return-Path: <cygwin-patches-return-5151-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19158 invoked by alias); 20 Nov 2004 19:36:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19132 invoked from network); 20 Nov 2004 19:36:02 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 20 Nov 2004 19:36:02 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 437F91B3E5; Sat, 20 Nov 2004 14:36:39 -0500 (EST)
Date: Sat, 20 Nov 2004 19:36:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] debug_printf edits
Message-ID: <20041120193639.GE2765@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041120135116.007e8ae0@incoming.verizon.net> <3.0.5.32.20041120135116.007e8ae0@incoming.verizon.net> <3.0.5.32.20041120142737.0081a430@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041120142737.0081a430@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00152.txt.bz2

On Sat, Nov 20, 2004 at 02:27:37PM -0500, Pierre A. Humblet wrote:
>At 02:20 PM 11/20/2004 -0500, Christopher Faylor wrote:
>>On Sat, Nov 20, 2004 at 01:51:16PM -0500, Pierre A. Humblet wrote:
>>>Here are minor changes that facilitate grepping traces. 
>>>
>>>Pierre
>>>
>>>2004-11-20  Pierre Humblet <pierre.humblet@ieee.org>
>>>
>>>	* fhandler.cc (fhandler::write): Remove debug_printf.
>>>	* pipe.cc (fhandler_pipe::create): Edit syscall_printf format.
>>
>>What does the inclusion of the word "pipe" add for grepping traces?
>>So, you can do a grep on '[0-9]+ = [a-z]'?
>
>Most syscall_printf have the form "res = function (args)",
>but the one in pipe.cc is missing "function". 
>So the change facilitates grepping, in particular when looking
>for many functions at once.

It didn't make sense to me that you were removing this usage in the case
of fhandler::write but tweaking it in the case of fhandler_pipe::create.

cgf
