Return-Path: <cygwin-patches-return-7687-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20621 invoked by alias); 27 Jul 2012 09:33:34 -0000
Received: (qmail 20492 invoked by uid 22791); 27 Jul 2012 09:33:00 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 27 Jul 2012 09:32:47 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 1EE0B2C00A9; Fri, 27 Jul 2012 11:32:45 +0200 (CEST)
Date: Fri, 27 Jul 2012 09:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: New modes for cygpath that terminate path with null byte, nothing
Message-ID: <20120727093245.GB30208@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <50124C62.9080405@dancol.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50124C62.9080405@dancol.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q3/txt/msg00008.txt.bz2

Hi Daniel,

On Jul 27 01:08, Daniel Colascione wrote:
> I wrote this patch because I often write this:
> 
> $ cygpath -aw foo > /dev/clipboard
> 
> Today, cygpath always appends a newline to the information in the
> clipboard, which is annoying when trying to paste into a program that
> interprets newlines specially. This patch implements two new options:
> -0/--null and -n/--no-newline. The former separates all paths output by
> cygpath with a null byte; the latter separates them with nothing at all.
> With -n, my example above works more smoothly and pastes don't include a
> newline.

Thanks for the patch.  It looks good and is a nice idea.  What's missing
is a ChangeLog entry (just the plain entry, not as part of the patch
itself) and briefly adding the new options to utils.sgml.

There's just the problem of the copyright assignment.  If you want to
provide a non-obvious patch, or if the patch adds new functionality, we
need a copyright assignment from you.  Please see the section "Before
you get started" on http://cygwin.com/contrib.html and the assignment
form http://cygwin.com/assign.txt

As soon as my manager has the assignment, I'll apply your patch.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
