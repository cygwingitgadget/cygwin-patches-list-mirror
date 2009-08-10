Return-Path: <cygwin-patches-return-6587-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5353 invoked by alias); 10 Aug 2009 00:52:16 -0000
Received: (qmail 5338 invoked by uid 22791); 10 Aug 2009 00:52:15 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-170.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.170)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 10 Aug 2009 00:52:10 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 0F8F013C0C5 	for <cygwin-patches@cygwin.com>; Sun,  9 Aug 2009 20:52:00 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 014D22B352; Sun,  9 Aug 2009 20:51:59 -0400 (EDT)
Date: Mon, 10 Aug 2009 00:52:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Find MinGW in more places
Message-ID: <20090810005159.GA610@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A7F269B.6070009@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A7F269B.6070009@gmail.com>
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
X-SW-Source: 2009-q3/txt/msg00041.txt.bz2

On Sun, Aug 09, 2009 at 08:42:19PM +0100, Dave Korn wrote:
>
>     Hi gang,
>
>  I often run into this problem when I'm using a compiler that I've installed in
>a non-standard $prefix: the utils/mingw script expects to find the MinGW sysroot
>in the same place the compiler's --print-prog-name= option finds ld.exe, which
>won't be the case if you've got a binutils in your non-standard $prefix as well.
>
>  The attached patch simply falls back to looking in the same set of directories
>relative to the root directory, which will locate anything installed with prefix
>/ or /usr.  It would also work if it only looked in /usr, but I decided to
>mirror the existing behaviour only in a different prefix just for consistency; I
>could always simplify it if wanted.
>
>winsup/utils/ChangeLog:
>
>	* mingw: Add fallbacks to search for MinGW components in standard
>	install locations if not found in compiler's $prefix.
>
>  Ok?

Yep.

Thanks.

cgf
