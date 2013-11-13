Return-Path: <cygwin-patches-return-7909-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23883 invoked by alias); 13 Nov 2013 15:15:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 23867 invoked by uid 89); 13 Nov 2013 15:15:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.2 required=5.0 tests=AWL,BAYES_50,RDNS_NONE,URIBL_BLOCKED autolearn=no version=3.3.2
X-HELO: mho-01-ewr.mailhop.org
Received: from Unknown (HELO mho-01-ewr.mailhop.org) (204.13.248.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Wed, 13 Nov 2013 15:15:38 +0000
Received: from pool-98-110-183-69.bstnma.fios.verizon.net ([98.110.183.69] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1VgcAE-000JlX-PU	for cygwin-patches@cygwin.com; Wed, 13 Nov 2013 15:15:30 +0000
Received: from cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 0607960105	for <cygwin-patches@cygwin.com>; Wed, 13 Nov 2013 10:15:30 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+OC4mOyLhZWCKKqvaioQ27
Date: Wed, 13 Nov 2013 15:15:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Prototype initstate() etc. if _XOPEN_SOURCE is defined appropriately
Message-ID: <20131113151529.GA743@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <52838E8C.5060708@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52838E8C.5060708@dronecode.org.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2013-q4/txt/msg00005.txt.bz2

On Wed, Nov 13, 2013 at 02:37:00PM +0000, Jon TURNEY wrote:
>
>Not sure if this is wanted, but mesa likes to compile with '-std=c99
>D_XOPEN_SOURCE=500', which leads to exciting crashes on x86_64 because
>initstate() is not prototyped.
>
>2013-11-13  Jon TURNEY  <jon.turney@dronecode.org.uk>
>
>	* include/cygwin/stdlib.h(initstate, random, setstate, srandom) :
>	Prototype if not __STRICT_ANSI__ or _XOPEN_SOURCE is defined appropriately.

Looks good to me.  Please commit.

cgf

>Index: cygwin/include/cygwin/stdlib.h
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/stdlib.h,v
>retrieving revision 1.13
>diff -u -u -p -r1.13 stdlib.h
>--- cygwin/include/cygwin/stdlib.h	21 May 2013 19:04:49 -0000	1.13
>+++ cygwin/include/cygwin/stdlib.h	13 Nov 2013 14:28:35 -0000
>@@ -31,10 +31,14 @@ void	setprogname (const char *);
> char *realpath (const char *, char *);
> char *canonicalize_file_name (const char *);
> int unsetenv (const char *);
>+#endif /*__STRICT_ANSI__*/
>+#if !defined(__STRICT_ANSI__) || (_XOPEN_SOURCE >= 500) || (defined(_XOPEN_SOURCE) && defined(_XOPEN_SOURCE_EXTENDED))
> char *initstate (unsigned seed, char *state, size_t size);
> long random (void);
> char *setstate (const char *state);
> void srandom (unsigned);
>+#endif
>+#ifndef __STRICT_ANSI__
> char *ptsname (int);
> int ptsname_r(int, char *, size_t);
> int getpt (void);
