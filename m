Return-Path: <cygwin-patches-return-6652-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9015 invoked by alias); 26 Sep 2009 20:37:55 -0000
Received: (qmail 9004 invoked by uid 22791); 26 Sep 2009 20:37:55 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-151.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.151)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 26 Sep 2009 20:37:50 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 4430C13C0C4 	for <cygwin-patches@cygwin.com>; Sat, 26 Sep 2009 16:37:40 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 33B572B352; Sat, 26 Sep 2009 16:37:40 -0400 (EDT)
Date: Sat, 26 Sep 2009 20:37:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fexecve, execvpe
Message-ID: <20090926203740.GA17538@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4ABE76F8.1050601@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ABE76F8.1050601@byu.net>
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
X-SW-Source: 2009-q3/txt/msg00106.txt.bz2

On Sat, Sep 26, 2009 at 02:18:00PM -0600, Eric Blake wrote:
>POSIX requires fexecve, and we had all the pieces ready to go.  And to
>my surprise, we've had execvpe in the sources for a long time, but just
>failed to export it (glibc just added execvpe in 2.10).  OK to apply,
>along with the corresponding patch to new-features.sgml and tweaking
>unistd.h in newlib?

Yes, thanks.

>P.S Any reason that "dtable.h" and "cygheap.h" aren't self-contained?

Since I don't know exactly what you're talking about I'll say "Yes".

cgf
