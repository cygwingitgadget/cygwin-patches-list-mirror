Return-Path: <cygwin-patches-return-7126-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 943 invoked by alias); 18 Oct 2010 15:15:56 -0000
Received: (qmail 855 invoked by uid 22791); 18 Oct 2010 15:15:37 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-186-10.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.186.10)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 18 Oct 2010 15:15:31 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 1134A13C061	for <cygwin-patches@cygwin.com>; Mon, 18 Oct 2010 11:15:30 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 0F5A32B352; Mon, 18 Oct 2010 11:15:30 -0400 (EDT)
Date: Mon, 18 Oct 2010 15:15:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: missing math functions
Message-ID: <20101018151529.GA14912@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <282260.35125.qm@web25501.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <282260.35125.qm@web25501.mail.ukl.yahoo.com>
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
X-SW-Source: 2010-q4/txt/msg00005.txt.bz2

On Mon, Oct 18, 2010 at 04:07:59PM +0100, Marco Atzeri wrote:
>llround and llroundf are available in newlib but not
>exported in cygwin.
>
>http://www.cygwin.com/ml/cygwin/2010-10/msg00351.html
>
>simple path attached to solve the problem.
>
>changelog:
>
>*       winsup/cygwin/cygwin.din : added llround and llroundf
>
>--- src/winsup/cygwin/cygwin.din	2010-10-08 20:25:00.875000000 +0200
>+++ src_new/winsup/cygwin/cygwin.din	2010-10-18 14:31:36.453125000 +0200
>@@ -960,6 +960,8 @@
> llrint = _f_llrint NOSIGFE
> llrintf = _f_llrintf NOSIGFE
> llrintl = _f_llrintl NOSIGFE
>+llround NOSIGFE
>+llroundf NOSIGFE
> __locale_mb_cur_max NOSIGFE
> localeconv NOSIGFE
> _localeconv = localeconv NOSIGFE

Applied with a tweaked ChangeLog.

Thanks again for the patch.

cgf
