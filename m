Return-Path: <cygwin-patches-return-5824-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20430 invoked by alias); 16 Apr 2006 12:20:34 -0000
Received: (qmail 20405 invoked by uid 22791); 16 Apr 2006 12:20:33 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Sun, 16 Apr 2006 12:20:29 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id BD1AD6D4299; Sun, 16 Apr 2006 14:20:26 +0200 (CEST)
Date: Sun, 16 Apr 2006 12:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: limits.h missing constants
Message-ID: <20060416122026.GA11759@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <041520061631.27477.44411FEB00052FA500006B5522007348300A050E040D0C079D0A@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <041520061631.27477.44411FEB00052FA500006B5522007348300A050E040D0C079D0A@comcast.net>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00012.txt.bz2

On Apr 15 16:31, Eric Blake wrote:
> > 2006-04-15  Eric Blake  <ebb9@byu.net>
> > 
> > 	* include/limits.h (_POSIX_*, _POSIX2_*, _XOPEN_*): Define missing
> > 	standard constants, and correct invalid ones.
> > 	(CHARCLASS_NAME_MAX): Define.
> > 	(SYMLOOP_MAX): Define.
> > 	* path.h (MAX_LINK_DEPTH): Define in terms of SYMLOOP_MAX.
> > 	* regex/regcomp.c (p_b_cclass): Limit length of char class name.
> 
> Oops - wrong version of the patch (path.h needs to include limits.h
> as in this corrected version, for SYMLOOP_MAX to work).
> 
> Also, if you want to double-check my limits.h values, see
> http://www.opengroup.org/onlinepubs/009695399/basedefs/limits.h.html#tag_13_24

This patch is not covered under the trivial patch rule anymore.
Please consider to fill out a copyright assignment form as described
on http://cygwin.com/contrib.html


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
