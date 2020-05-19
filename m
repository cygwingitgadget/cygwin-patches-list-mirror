Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 8B8E23851C04
 for <cygwin-patches@cygwin.com>; Tue, 19 May 2020 11:41:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8B8E23851C04
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MjSPq-1jCAS30ziE-00kwEy for <cygwin-patches@cygwin.com>; Tue, 19 May 2020
 13:41:29 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8D5ABA80F7E; Tue, 19 May 2020 13:41:27 +0200 (CEST)
Date: Tue, 19 May 2020 13:41:27 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: tzcode resync v2: details
Message-ID: <20200519114127.GV3947@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200519050229.28209-1-mark@maxrnd.com>
 <20200519050229.28209-4-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200519050229.28209-4-mark@maxrnd.com>
X-Provags-ID: V03:K1:QD1CPTnJenoxLuQ0tiXA/euZ2VnTfk/4Fg6BYTihxTNe9mzzKRG
 rIM/RzZaMupQ0V6EWRuUXnW1WmRRhuWVNKiZZufQ14Gwrmm0fsMRQNCFOholpKgFgNDrcQv
 VXTYyeI+s0dVggBx3G8mBifz6lwzhRUC9T5pqs4x8r0EcpQm2LYVSV1L9rWdoF/VnemKLsG
 cIFtzmD2mBBzj3BpdgBjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NXNnglM2M8k=:pKDq1NHWWbMUEYHz4idLE8
 lknyiAbnr9XmzIfXZdozv/qSqa604nMABSBq9pk8T8l1zJlspHLzZ8pgKIbS/sJA2mwZMDQWv
 BHXSendfbQoJQS2q/4O6GeMBNMrAoGjjpawG/6ol8G3If3/KjMDMGjU5btXcm/EoB9JUCmCqZ
 0hWoQhiGG48scgFphCLk2ujXa7CDVr+Gy/n9XH1Czk2sJqxkHQO7tCTmnYsTDOyZRkRloWj1P
 ys/f3xfgxHBsKC+p5OMqF6Xt++u8zPXyu/dqRchDxTvtxKDaMMByNHYS4B3B5+vAL1qJgC3VT
 kJJ/fYO+FNASxP2+uAmhdc45lFZQIDZ6X6S4/EaCMKhnwZs3rdHUCRPNNZG3DPp/e00PpFSCF
 NiBhCj0X1uXd7I1oOC38EUPeq2uEuB6vD8WbQBPAqJgUEd0Q/oJ/cRz1SFrY5JLARGgzkDsAd
 yezI94WJKFmH8Ip5ahHfETB3OvBoS4cup1cFXu7e/xFykl1anFDAPctAsap8IlwcsrFsk1L++
 IZBywRYiZLthvk0VnafOvY9zbdK6ZbMJF4eh08R5c/D9PryonwGXagT6G6YMLhc9f+yE0fS7j
 MaiQE6hqpEAIiY2sbfuN13At3T8ykUjfZzl/52eoMlI1IWp4GQ/SEaR4iYl3C0v0nm17fShCs
 S3OcodbwLxQgeBHJ08mf+uB2uuyolal+9pwkI/cgLnnKVkbo3vc5kAXbkBZ1MZewi1ZDS+h44
 PRS1mcQiun/6o1q8ViPj1+VG4EeTLcLu75UtasxbzLv71kE69gQOv0y0J3FSU0cGpkGL3gvmq
 91g8DMwquoj0Xfv9d0Rg9maX8N83l02CKiKJ3kmM2zw4TcMchgsK2cemFDEWpQ6BTqoHGU/
X-Spam-Status: No, score=-103.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 19 May 2020 11:41:32 -0000

Hi Mark,

On May 18 22:02, Mark Geisert wrote:
> Add tz_posixrules.h with data generated from most recent Cygwin tzdata
> package.  Establish localtime.cc as primarily a wrapper around a patched
> copy of localtime.c.  See README for more information.

The idea is nice, but there are a few problems.

> diff --git a/winsup/cygwin/tzcode/localtime.c.patch b/winsup/cygwin/tzcode/localtime.c.patch
> new file mode 100644
> index 000000000..a17d9ee90
> --- /dev/null
> +++ b/winsup/cygwin/tzcode/localtime.c.patch
> @@ -0,0 +1,399 @@
> +*** localtime.c	2020-05-16 21:54:00.533111800 -0700
> +--- localtime.c.patched	2020-05-16 22:42:40.486924300 -0700
> +***************
> +*** 1,3 ****

Ideally this patch should be in unified (-u) diff format.

I also wonder if some of these patches may be dropped or made
less invasive, given that localtime.cc wraps localtime.c.

For example:

> +***************
> +*** 23,29 ****
> +  
> +  /*LINTLIBRARY*/
> +  
> +- #include "namespace.h"

Adding a local namesapce.h file?

> +  #include <assert.h>
> +  #define LOCALTIME_IMPLEMENTATION
> +  #include "private.h"
> +--- 24,29 ----
> +***************
> +*** 182,188 ****
> +  
> +  
> +  #if !defined(__LIBC12_SOURCE__)
> +! timezone_t __lclptr;
> +  #ifdef _REENTRANT
> +  rwlock_t __lcl_lock = RWLOCK_INITIALIZER;
> +  #endif
> +--- 182,188 ----
> +  
> +  
> +  #if !defined(__LIBC12_SOURCE__)
> +! static timezone_t __lclptr;

Do we really need this static?  Even if it's not static, it won't
be exported from the DLL anyway, so it seems we can drop this, no?

> +  #ifdef _REENTRANT
> +  rwlock_t __lcl_lock = RWLOCK_INITIALIZER;
> +  #endif
> +***************
> +*** 198,204 ****
> +  
> +  static struct tm	tm;
> +  
> +! #if !HAVE_POSIX_DECLS || TZ_TIME_T || defined(__NetBSD__)
> +  # if !defined(__LIBC12_SOURCE__)
> +  
> +  __aconst char *		tzname[2] = {
> +--- 198,204 ----
> +  
> +  static struct tm	tm;
> +  
> +! #if !HAVE_POSIX_DECLS || TZ_TIME_T || defined(__NetBSD__) || defined(__CYGWIN__)

What about just #defining TZ_TIME_T or HAVE_POSIX_DECLS in localtime.cc
or even (see above) namespace.h?

> +  # if !defined(__LIBC12_SOURCE__)
> +  
> +  __aconst char *		tzname[2] = {
> +***************
> +*** 413,419 ****
> +  };
> +  
> +  /* TZDIR with a trailing '/' rather than a trailing '\0'.  */
> +! static char const tzdirslash[sizeof TZDIR] = TZDIR "/";

Yay, this one is tricky (and soooo dumb)

> +  
> +  /* Local storage needed for 'tzloadbody'.  */
> +  union local_storage {
> +--- 413,420 ----
> +  };
> +  
> +  /* TZDIR with a trailing '/' rather than a trailing '\0'.  */
> +! static char const tzdirslash[] = TZDIR "/";
> +! #define sizeof_tzdirslash (sizeof tzdirslash - 1)

What about this instead:

  - static char const tzdirslash[sizeof TZDIR] = TZDIR "/";
  + static char const tzdirslash[sizeof TZDIR + 1] = TZDIR "/";

checking what "sizeof tzdirslash" is used for, it doesn't matter
at all:

> +***************
> +*** 428,434 ****
> +  
> +  	/* The file name to be opened.  */
> +  	char fullname[/*CONSTCOND*/BIGGEST(sizeof (struct file_analysis),
> +! 	    sizeof tzdirslash + 1024)];

This makes fullname one byte longer than in NetBSD...

> +*** 466,479 ****
> +  	if (!doaccess) {
> +  		char const *dot;
> +  		size_t namelen = strlen(name);
> +! 		if (sizeof lsp->fullname - sizeof tzdirslash <= namelen)

lsp->fullname is one byte longer, tzdirslash is one byte longer,
therefore

  Cygwin:  sizeof lsp->fullname - sizeof tzdirslash

is equivalent to 

  NetBSD: (sizeof lsp->fullname + 1) - (sizeof tzdirslash + 1)
  ==       sizeof lsp->fullname + 1 - sizeof tzdirslash - 1
  ==       sizeof lsp->fullname - sizeof tzdirslash

So it's in fact the same expression and no change is required.

> +  			return ENAMETOOLONG;
> +  
> +  		/* Create a string "TZDIR/NAME".  Using sprintf here
> +  		   would pull in stdio (and would fail if the
> +  		   resulting string length exceeded INT_MAX!).  */
> +! 		memcpy(lsp->fullname, tzdirslash, sizeof tzdirslash);
> +! 		strcpy(lsp->fullname + sizeof tzdirslash, name);

This could then be changed to just

  -		strcpy(lsp->fullname + sizeof tzdirslash, name);
  +		strcpy(lsp->fullname + sizeof tzdirslash - 1, name);

> +***************
> +*** 488,498 ****
> +  		name = lsp->fullname;
> +  	}
> +  	if (doaccess && access(name, R_OK) != 0)
> +! 		return errno;
> +  
> +  	fid = open(name, OPEN_MODE);
> +  	if (fid < 0)
> +! 		return errno;
> +  	nread = read(fid, up->buf, sizeof up->buf);
> +  	if (nread < (ssize_t)tzheadsize) {
> +  		int err = nread < 0 ? errno : EINVAL;
> +--- 489,499 ----
> +  		name = lsp->fullname;
> +  	}
> +  	if (doaccess && access(name, R_OK) != 0)
> +! 		goto trydefrules;
> +  
> +  	fid = open(name, OPEN_MODE);
> +  	if (fid < 0)
> +! 		goto trydefrules;
> +  	nread = read(fid, up->buf, sizeof up->buf);
> +  	if (nread < (ssize_t)tzheadsize) {
> +  		int err = nread < 0 ? errno : EINVAL;
> +***************
> +*** 501,506 ****
> +--- 502,516 ----
> +  	}
> +  	if (close(fid) < 0)
> +  		return errno;
> ++ 	if (0) {
> ++ trydefrules:
> ++ 		const char *base = strrchr(name, '/');
> ++ 		base = base ? base + 1 : name;
> ++ 		if (strcmp(base, TZDEFRULES))
> ++ 		    return errno;
> ++ 		nread = sizeof _posixrules_data;
> ++ 		memcpy(up->buf, _posixrules_data, nread);
> ++ 	}

Couldn't this be wrapped in localtime.cc?  If this function in
localtime.c returns an error, just do the trydefrules stuff?
Just an idea, that may be too tricky depending on context.

> +*** 793,799 ****
> +  static int
> +  tzload(char const *name, struct state *sp, bool doextend)
> +  {
> +! 	union local_storage *lsp = malloc(sizeof *lsp);
> +  	if (!lsp)
> +  		return errno;
> +  	else {
> +--- 803,809 ----
> +  static int
> +  tzload(char const *name, struct state *sp, bool doextend)
> +  {
> +! 	union local_storage *lsp = (union local_storage *) calloc(1, sizeof *lsp);

This is where -Wall -Werror is getting annoying.  We should contemplate
to drop -Werror for localtime.cc, or better to drop certain warnings by
using `#pragma GCC diagnostic ignored "..." from within localtime.cc to
allow certain warnings to go unpunished.

I'm also not quite sure anymore why we use calloc instead of malloc
where malloc is sufficient for the original code.  We should probably
just drop this (but better check every call).


These are just examples, but the idea is clear I guess.  The less
changes in localtime.c, the better for maintenance.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
