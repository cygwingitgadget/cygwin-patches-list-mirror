Return-Path: <cygwin-patches-return-6528-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26683 invoked by alias); 3 Jun 2009 18:51:25 -0000
Received: (qmail 26672 invoked by uid 22791); 3 Jun 2009 18:51:25 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-121.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.121)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 03 Jun 2009 18:51:18 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id EAE9313C0C3 	for <cygwin-patches@cygwin.com>; Wed,  3 Jun 2009 14:51:06 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id DB80C11A02C; Wed,  3 Jun 2009 14:51:06 -0400 (EDT)
Date: Wed, 03 Jun 2009 18:51:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Pthread fixes arising.
Message-ID: <20090603185106.GA2158@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4A26BDE4.5060308@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A26BDE4.5060308@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00070.txt.bz2

On Wed, Jun 03, 2009 at 07:16:04PM +0100, Dave Korn wrote:
>winsup/cygwin/ChangeLog
>
>	* thread.cc (__cygwin_lock_lock):  Delete racy optimisation.
>	(__cygwin_lock_unlock):  Likewise.
>
>	* winbase.h (ilockexch):  Fix asm constraints.
>	(ilockcmpexch):  Likewise.
>
>  OK for head?

Which version of the asm constraints are these?  If this is the "I'm
pretty sure I know what I'm doing" version then no.  If these are the
versions from some tried-and-true OS/library then yes.

Actually maybe this should be two checkins since the __cygwin_lock_lock
stuff is uncontroversial.

cgf
