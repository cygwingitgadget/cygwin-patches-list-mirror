Return-Path: <cygwin-patches-return-5149-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3589 invoked by alias); 20 Nov 2004 19:19:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3550 invoked from network); 20 Nov 2004 19:19:26 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 20 Nov 2004 19:19:26 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id CDB161B3E5; Sat, 20 Nov 2004 14:20:02 -0500 (EST)
Date: Sat, 20 Nov 2004 19:19:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] debug_printf edits
Message-ID: <20041120192002.GB2765@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041120135116.007e8ae0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041120135116.007e8ae0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00150.txt.bz2

On Sat, Nov 20, 2004 at 01:51:16PM -0500, Pierre A. Humblet wrote:
>Here are minor changes that facilitate grepping traces. 
>
>Pierre
>
>2004-11-20  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* fhandler.cc (fhandler::write): Remove debug_printf.
>	* pipe.cc (fhandler_pipe::create): Edit syscall_printf format.

What does the inclusion of the word "pipe" add for grepping traces?
So, you can do a grep on '[0-9]+ = [a-z]'?

cgf
