Return-Path: <cygwin-patches-return-6198-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 812 invoked by alias); 20 Dec 2007 10:11:59 -0000
Received: (qmail 802 invoked by uid 22791); 20 Dec 2007 10:11:59 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 20 Dec 2007 10:11:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id A073D6D4811; Thu, 20 Dec 2007 11:11:43 +0100 (CET)
Date: Thu, 20 Dec 2007 10:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: memmem issues
Message-ID: <20071220101143.GA8291@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20071219T210928-910@post.gmane.org> <4769E90D.5090908@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4769E90D.5090908@byu.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00050.txt.bz2

On Dec 19 21:01, Eric Blake wrote:
> Index: libc/memmem.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/libc/memmem.cc,v
> retrieving revision 1.1
> diff -u -p -r1.1 memmem.cc
> --- libc/memmem.cc	8 Nov 2005 22:08:39 -0000	1.1
> +++ libc/memmem.cc	20 Dec 2007 03:56:35 -0000
> @@ -45,8 +45,8 @@ memmem (const void *l, size_t l_len,
>    const char *cs = (const char *)s;
>  
>    /* we need something to compare */
> -  if (l_len == 0 || s_len == 0)
> -    return NULL;
> +  if (s_len == 0)
> +    return l;

Looks like this is actually more correct.  Glibc and NetBSD both
agree with you, while only the FreeBSD function seems to return NULL
in this case.  However, it's not quite ok.  l is const void * while the
function returns void *.  I applied this part of your patch with the
obvious cast.

> +  /* FIXME - this algorithm is worst-case O(l_len*s_len), but using
> +     Knuth-Morris-Pratt would be O(l_len+s_len) at the expense of a
> +     memory allocation of s_len bytes.  Consider rewriting this to
> +     swap over the KMP if the first few iterations fail, and back to
> +     this if KMP can't allocate enough memory.  */
>    for (cur = (char *) cl; cur <= last; cur++)
>      if (cur[0] == cs[0] && memcmp (cur, cs, s_len) == 0)
>        return cur;

What about just using documented example code, for instance from here:

  http://www-igm.univ-mlv.fr/~lecroq/string/node8.html

or here:

  http://de.wikipedia.org/wiki/Knuth-Morris-Pratt-Algorithmus (in German)

or what about Boyer-Moore instead:

  http://de.wikipedia.org/wiki/Boyer-Moore-Algorithmus (in German)

Using one of them is certainly not a licensing violation since all code
examples are more or less the published examples from well-known
textbooks (Knuth, Sedgewick, et al.).  Given that, I don't think you're
actually "tainted".  An actual implementation would be much better than
a forlorn comment in an unimpressive file in some subdirectory.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
