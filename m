Return-Path: <cygwin-patches-return-6116-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20601 invoked by alias); 16 Jun 2007 19:47:47 -0000
Received: (qmail 20582 invoked by uid 22791); 16 Jun 2007 19:47:46 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Sat, 16 Jun 2007 19:47:44 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id DD8C56D47FF; Sat, 16 Jun 2007 21:47:41 +0200 (CEST)
Date: Sat, 16 Jun 2007 19:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: newlib@sources.redhat.com, cygwin-patches@cygwin.com
Subject: Re: Failure in rebuilding Cygwin-1.5.24-2 with recent newlib
Message-ID: <20070616194741.GB4179@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com, newlib@sourceware.org
Mail-Followup-To: newlib@sources.redhat.com, cygwin-patches@cygwin.com
References: <Pine.OSF.4.21.0706161607350.22962-100000@ax0rm1.roma1.infn.it> <467403F8.FDD06745@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <467403F8.FDD06745@dessent.net>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00062.txt.bz2

On Jun 16 08:38, Brian Dessent wrote:
> This is just due to __FBSDID not getting #defined to blank properly. 
> The file includes sys/cdefs.h and newlib's copy contains the required
> bit (#define __FBSDID(x) /* nothing */) however when building with
> Cygwin, the Cygwin headers are used and Cygwin's sys/cdefs.h doesn't
> contain this.  The appropriate fix is either to modify strcasestr.c or
> to fix Cygwin's sys/cdefs.h.  I think the latter is probably the better
> choice, since it seems that there is precedent already in newlib for
> being able to just #include <sys/cdefs.h> followed by use of __FBSDID
> without having to explicitly undefine it.  Patch attached which fixes
> the build for me.

Thanks for the patch.  However, when comparing newlib's and Cygwin's
sys/cdefs.h file, I'm wondering why Cygwin needs its own version of
sys/cdefs.h at all.

Chris, do you know why we maintain our own sys.cdefs.h?  It looks
like we could just delete it.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
