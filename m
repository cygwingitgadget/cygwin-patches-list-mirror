Return-Path: <cygwin-patches-return-6883-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30034 invoked by alias); 26 Dec 2009 05:32:21 -0000
Received: (qmail 30018 invoked by uid 22791); 26 Dec 2009 05:32:20 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-42-77.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.42.77)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 26 Dec 2009 05:32:16 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id E5C163B0003 	for <cygwin-patches@cygwin.com>; Sat, 26 Dec 2009 00:32:06 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id D2E0A2B352; Sat, 26 Dec 2009 00:32:06 -0500 (EST)
Date: Sat, 26 Dec 2009 05:32:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: match pty.h to glibc
Message-ID: <20091226053206.GA2274@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B359B91.1090109@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B359B91.1090109@byu.net>
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
X-SW-Source: 2009-q4/txt/msg00214.txt.bz2

On Fri, Dec 25, 2009 at 10:13:53PM -0700, Eric Blake wrote:
>-----BEGIN PGP SIGNED MESSAGE-----
>Hash: SHA1
>
>As of glibc 2.8, pty.h now marks the last two arguments of openpty and
>forkpty as const.  These functions are not standardized, and we aren't
>altering the parameters, so I see no reason why we can't also make the
>change.  OK to apply?
>
>2009-12-26  Eric Blake  <ebb9@byu.net>
>
>	* include/pty.h (openpty, forkpty): Mark last two arguments const,
>	to match glibc 2.8.
>	* libc/bsdlib.cc (openpty, forkpty): Likewise.

Looks good.  Please check in.

Thanks.

cgf
