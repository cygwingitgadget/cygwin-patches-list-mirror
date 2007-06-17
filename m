Return-Path: <cygwin-patches-return-6118-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26129 invoked by alias); 17 Jun 2007 00:33:03 -0000
Received: (qmail 26119 invoked by uid 22791); 17 Jun 2007 00:33:03 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-245.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.245)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 17 Jun 2007 00:33:01 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 58C3D2B352; Sat, 16 Jun 2007 20:33:06 -0400 (EDT)
Date: Sun, 17 Jun 2007 00:33:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Failure in rebuilding Cygwin-1.5.24-2 with recent newlib
Message-ID: <20070617003306.GA26494@ednor.casa1.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.OSF.4.21.0706161607350.22962-100000@ax0rm1.roma1.infn.it> <467403F8.FDD06745@dessent.net> <20070616194741.GB4179@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070616194741.GB4179@calimero.vinschen.de>
User-Agent: Mutt/1.5.15 (2007-04-06)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00064.txt.bz2

On Sat, Jun 16, 2007 at 09:47:41PM +0200, Corinna Vinschen wrote:
>On Jun 16 08:38, Brian Dessent wrote:
>> This is just due to __FBSDID not getting #defined to blank properly. 
>> The file includes sys/cdefs.h and newlib's copy contains the required
>> bit (#define __FBSDID(x) /* nothing */) however when building with
>> Cygwin, the Cygwin headers are used and Cygwin's sys/cdefs.h doesn't
>> contain this.  The appropriate fix is either to modify strcasestr.c or
>> to fix Cygwin's sys/cdefs.h.  I think the latter is probably the better
>> choice, since it seems that there is precedent already in newlib for
>> being able to just #include <sys/cdefs.h> followed by use of __FBSDID
>> without having to explicitly undefine it.  Patch attached which fixes
>> the build for me.
>
>Thanks for the patch.  However, when comparing newlib's and Cygwin's
>sys/cdefs.h file, I'm wondering why Cygwin needs its own version of
>sys/cdefs.h at all.
>
>Chris, do you know why we maintain our own sys.cdefs.h?  It looks
>like we could just delete it.

Cygwin's cdefs.h predates the newlib version.  I've removed Cygwin's version.

cgf
