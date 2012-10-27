Return-Path: <cygwin-patches-return-7767-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26741 invoked by alias); 27 Oct 2012 04:47:41 -0000
Received: (qmail 26721 invoked by uid 22791); 27 Oct 2012 04:47:40 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 27 Oct 2012 04:47:31 +0000
Received: from pool-173-76-43-156.bstnma.fios.verizon.net ([173.76.43.156] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1TRyJ0-0003Gc-QK	for cygwin-patches@cygwin.com; Sat, 27 Oct 2012 04:47:30 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 2A5CA13C0C7	for <cygwin-patches@cygwin.com>; Sat, 27 Oct 2012 00:47:30 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/RGbjgc+vbppQTc6l4O0pc
Date: Sat, 27 Oct 2012 04:47:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch cygwin]: Rename strechr to strchrnul
Message-ID: <20121027044730.GD27148@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAEwic4Yw5AQVMk_wCyru5oZw7z-ghowc1Yu_mj_Z9Z5rmuHPqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEwic4Yw5AQVMk_wCyru5oZw7z-ghowc1Yu_mj_Z9Z5rmuHPqg@mail.gmail.com>
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
X-SW-Source: 2012-q4/txt/msg00044.txt.bz2

On Fri, Oct 26, 2012 at 10:13:07PM +0200, Kai Tietz wrote:
>Hello,
>
>this patch replaces strechr by strchrnul symbol-name.  The strchrnul
>name is that one also present in new-libc for this function behavior.
>ChangeLog
>
>2012-10-26  Kai Tietz
>
>	* dcrt0.cc (quoted): Renamed strechr to strchrnul.
>	* environ.cc (environ_init): Likewise.
>	* sec_acl.cc (aclfromtext32): Likewise.
>	* sec_auth.cc (extract_nt_dom_user): Likewise.
>	* uinfo.cc (pwdgrp::next_str): Likewise.
>	* string.h (strechr): Likewise.
>
>Ok for apply?

Yes.  Thanks.

cgf
