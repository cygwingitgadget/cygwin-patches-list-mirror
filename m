Return-Path: <cygwin-patches-return-3821-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21631 invoked by alias); 16 Apr 2003 03:06:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21622 invoked from network); 16 Apr 2003 03:06:25 -0000
Date: Wed, 16 Apr 2003 03:06:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFA] enable finline-functions optimization
Message-ID: <20030416030635.GA21371@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0304151046400.259-200000@algeria.intern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.44.0304151046400.259-200000@algeria.intern.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00048.txt.bz2

On Tue, Apr 15, 2003 at 10:59:13AM +0200, Thomas Pfaff wrote:
>
>It seems that  __attribute__(used) does not work in conjunction with
>__asm__ ("function name without _"). If i remove the  __asm__ stuff it
>works as expected.
>This patch will keep the functions static.

Ok.  Feel free to checkin, in that case.  Out of curiousity, what version
of gcc are you using?  3.2?

cgf

>2003-04-15  Thomas Pfaff  <tpfaff@gmx.net>
>
>	* Makefile.in: Add finline-functions optimization to CXXFLAGS.
>	* autoload.cc (LoadDLLprime): Rename std_dll_init to
>	_std_dll_init.
>	(std_dll_init): Remove name mangling prototype. Add attributes
>	used and noinline.
>	(wsock_init): Ditto.
>	Change wsock_init to _wsock_init in wsock32 and ws2_32
>	LoadDLLprime.
>	* exceptions.cc (unused_sig_wrapper): Remove prototype. Add
>	attributes used and noinline.
>	* pwdgrp.h ((pwdgrp (passwd *&)): Remove inline code.
>	(pwdgrp (__group32 *&)): Ditto.
>	* grp.cc (pwdgrp (passwd *&)): Outline constructor.
>	(pwdgrp (__group32 *&)): Ditto.
