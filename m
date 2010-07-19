Return-Path: <cygwin-patches-return-7043-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12100 invoked by alias); 19 Jul 2010 19:44:07 -0000
Received: (qmail 12082 invoked by uid 22791); 19 Jul 2010 19:44:06 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 19 Jul 2010 19:43:59 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 35B756D435C; Mon, 19 Jul 2010 21:43:56 +0200 (CEST)
Date: Mon, 19 Jul 2010 19:44:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: newlib@sourceware.org, cygwin-patches@cygwin.com
Subject: Re: add mkostemp
Message-ID: <20100719194355.GP6944@calimero.vinschen.de>
Reply-To: newlib@sourceware.org, cygwin-patches@cygwin.com
Mail-Followup-To: newlib@sourceware.org, cygwin-patches@cygwin.com
References: <4C447CE5.4040808@redhat.com> <20100719164558.GN6944@calimero.vinschen.de> <4C449381.9040508@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4C449381.9040508@redhat.com>
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
X-SW-Source: 2010-q3/txt/msg00003.txt.bz2

On Jul 19 12:03, Eric Blake wrote:
> On 07/19/2010 10:45 AM, Corinna Vinschen wrote:
> >> Okay to commit, along with a corresponding patch to doc/new-features.sgml
> >> and a cygwin-specific patch to newlib's stdlib.h?
> > 
> > Yep.  Thanks for the patch.  I CCed the newlib list.  The change to
> > newlib's stdlib.h is preapproved (#ifndef __STRICT_ANSI__ just like
> > mkstemp et al).
> 
> For the record, here's the (pre-approved) patches for newlib and cygwin
> documentation that I'm pushing in tandem with the original cygwin patch.
>  It also fixes a couple of minor problems I noticed while in the area -
> cygwin's cat has been binary-only for some time now, and newlib's
> stdlib.h was not robust to a user file that used #define warning prior
> to including the system header.
> 
> > 
> > Btw., would you mind to enhance newlib's libc/stdio/mktemp.c in the same
> > manner (_ELIX_LEVEL >= 4)?
> 
> The mkostemp[s] additions are guarded by the same levels as mkstemps,
> since all three interfaces are equally non-portable.

Thanks very much for the patch.


Corinna

-- 
Corinna Vinschen
Cygwin Project Co-Leader
Red Hat
