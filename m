Return-Path: <cygwin-patches-return-5883-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3597 invoked by alias); 31 May 2006 02:18:04 -0000
Received: (qmail 3587 invoked by uid 22791); 31 May 2006 02:18:03 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-19.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.19)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 31 May 2006 02:18:02 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id D82B013C01F; Tue, 30 May 2006 22:18:00 -0400 (EDT)
Date: Wed, 31 May 2006 02:18:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Updating cygwin_dll_init()
Message-ID: <20060531021800.GB20182@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1149023542.4152.29.camel@fulgurite>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149023542.4152.29.camel@fulgurite>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00071.txt.bz2

On Tue, May 30, 2006 at 02:12:22PM -0700, Max Kaehn wrote:
>The recent change (on 2006-05-24) to _dll_crt0() calls dll_crt0_1()
>via _cygtls::call() instead of calling it directly.  The call in
>_cygtls::call2() to ExitThread() means that anyone using
>cygwin_dll_init() will find that their main thread suddenly exits
>instead of returning control to the caller of cygwin_dll_init().
>
>This fix unrolls _dll_crt0 into cygwin_dll_init() and leaves it up
>to the caller of cygwin_dll_init() to provide a pointer to the
>padding.

Thanks for the patch but I just checked in a fix to cygtls::call2 which
seems to be much less intrusive.

I had also bumped the padding size in cygload.h in my sandbox but had
forgotten to check it in.  It's checked in now.

cgf
