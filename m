Return-Path: <cygwin-patches-return-5150-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17925 invoked by alias); 20 Nov 2004 19:32:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17914 invoked from network); 20 Nov 2004 19:32:34 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.190.188)
  by sourceware.org with SMTP; 20 Nov 2004 19:32:34 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I7HT3M-001JND-DW
	for cygwin-patches@cygwin.com; Sat, 20 Nov 2004 14:35:46 -0500
Message-Id: <3.0.5.32.20041120142737.0081a430@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 20 Nov 2004 19:32:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] debug_printf edits
In-Reply-To: <20041120192002.GB2765@trixie.casa.cgf.cx>
References: <3.0.5.32.20041120135116.007e8ae0@incoming.verizon.net>
 <3.0.5.32.20041120135116.007e8ae0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q4/txt/msg00151.txt.bz2

At 02:20 PM 11/20/2004 -0500, Christopher Faylor wrote:
>On Sat, Nov 20, 2004 at 01:51:16PM -0500, Pierre A. Humblet wrote:
>>Here are minor changes that facilitate grepping traces. 
>>
>>Pierre
>>
>>2004-11-20  Pierre Humblet <pierre.humblet@ieee.org>
>>
>>	* fhandler.cc (fhandler::write): Remove debug_printf.
>>	* pipe.cc (fhandler_pipe::create): Edit syscall_printf format.
>
>What does the inclusion of the word "pipe" add for grepping traces?
>So, you can do a grep on '[0-9]+ = [a-z]'?

Most syscall_printf have the form "res = function (args)",
but the one in pipe.cc is missing "function". 
So the change facilitates grepping, in particular when looking
for many functions at once.

Pierre
