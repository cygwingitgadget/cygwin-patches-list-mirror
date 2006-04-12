Return-Path: <cygwin-patches-return-5819-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31356 invoked by alias); 12 Apr 2006 15:41:13 -0000
Received: (qmail 31346 invoked by uid 22791); 12 Apr 2006 15:41:13 -0000
X-Spam-Check-By: sourceware.org
Received: from fios.cgf.cx (HELO cgf.cx) (71.248.179.247)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 12 Apr 2006 15:41:11 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id E772213C01E; Wed, 12 Apr 2006 11:41:09 -0400 (EDT)
Date: Wed, 12 Apr 2006 15:41:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: Cygwin Patches <cygwin-patches@cygwin.com>, 	Bernhard Loos <bernloos@web.de>
Subject: Re: Patch for silent crash with Cygwin1.dll v 1.5.19-4
Message-ID: <20060412154109.GA13171@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Cygwin Patches <cygwin-patches@cygwin.com>, 	Bernhard Loos <bernloos@web.de>
References: <20060412135333.72244.qmail@web53003.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060412135333.72244.qmail@web53003.mail.yahoo.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00007.txt.bz2

On Wed, Apr 12, 2006 at 06:53:33AM -0700, Gary Zablackis wrote:
>The code below corrects this problem. 
>
>CHANGELOG:
>2006-04-11 Gary Zablackis gzabl@yahoo.com
> * (Thanks to Bernhard Loos for pointing the way)
> * dll_init.cc (dll_dllcrt0()): install Cygwin
>exception handler so that Cygwin can handle checking
>for invalid pointers in dlopen()'ed dlls.

The exception handler is supposed to be initialized in
_cygtls::init_thread which is called from initialize_main_tls.
Why is that not happening?

cgf
