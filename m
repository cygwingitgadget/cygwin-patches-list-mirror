Return-Path: <cygwin-patches-return-6670-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1899 invoked by alias); 2 Oct 2009 22:19:49 -0000
Received: (qmail 1886 invoked by uid 22791); 2 Oct 2009 22:19:48 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-151.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.151)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 02 Oct 2009 22:19:43 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 8CCE613C003 	for <cygwin-patches@cygwin.com>; Fri,  2 Oct 2009 18:19:33 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 8C5532B352; Fri,  2 Oct 2009 18:19:33 -0400 (EDT)
Date: Fri, 02 Oct 2009 22:19:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Update build flags for new compiler feature
Message-ID: <20091002221933.GB12372@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC66C72.7070102@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AC66C72.7070102@gmail.com>
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
X-SW-Source: 2009-q4/txt/msg00001.txt.bz2

On Fri, Oct 02, 2009 at 10:11:14PM +0100, Dave Korn wrote:
>
>  So, nobody did ask for a compiler version check(*), so here's the patch plus
>changelog, and I'd like to get separate OKs from both cgf and cv to say that
>you've each either updated your cross-build environments or don't mind
>patching the flag back out locally until you can.
>
>winsup/cygwin/ChangeLog:
>
>	* Makefile.in (CFLAGS): Add -mno-use-libstdc-wrappers
>
>  (In case anyone was wondering, I think CFLAGS, rather than CXXFLAGS, is the
>right place to add it; it applies to cross-language mixed linking situations
>as much as it does to C++ alone).

I think we've confirmed that this is a good fix.  Please check it in.

Thanks.

cgf
