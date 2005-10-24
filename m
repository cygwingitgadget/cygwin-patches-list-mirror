Return-Path: <cygwin-patches-return-5668-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23838 invoked by alias); 24 Oct 2005 09:48:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23776 invoked by uid 22791); 24 Oct 2005 09:48:07 -0000
Received: from mail-n.franken.de (HELO ilsa.franken.de) (193.175.24.27)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 24 Oct 2005 09:48:07 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])
	by ilsa.franken.de (Postfix) with ESMTP id 2994F245C5
	for <cygwin-patches@cygwin.com>; Mon, 24 Oct 2005 11:48:03 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])
	by aqua.hirmke.de (Postfix) with ESMTP id 585D4AAFF6
	for <cygwin-patches@cygwin.com>; Mon, 24 Oct 2005 11:48:03 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 43103544122; Mon, 24 Oct 2005 11:48:03 +0200 (CEST)
Date: Mon, 24 Oct 2005 09:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: expose creating windows-style envblock from current environment
Message-ID: <20051024094803.GA21196@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20051024010823.GA648@efn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024010823.GA648@efn.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q4/txt/msg00010.txt.bz2

On Oct 23 18:08, Yitzchak Scott-Thoennes wrote:
> I need to translate the current environment in a cygwin C program to
> an envblock suitable for calling CreateProcess directly, and couldn't
> think of a better way than the following patch.

I'm wondering why that's necessary at all.  You have access to the app's
POSIX environment and you know by a simple look into Cygwin which
variables have to be path converted and which not.  That can be done
using cygwin_conv_to_win32_path/cygwin_posix_to_win32_path_list.  Looks
like a task easily accomplished inside of the application.

> But I think there's something I'm not understanding; with the free()
> calls in place, it coredumps, though checking the code in environ.cc
> seems to show that all the freed chunks should have been properly
> allocated.

envp and the envp members are allocated on the cygheap using cmalloc()
and cstrdup() so you must free them with cfree().

> As an aside, does the build_env call in spawn.cc leak?

How?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat, Inc.
