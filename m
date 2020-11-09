Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id D1321385780E
 for <cygwin-patches@cygwin.com>; Mon,  9 Nov 2020 10:04:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D1321385780E
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MTzve-1klWDt3xdS-00QxIu; Mon, 09 Nov 2020 11:04:55 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D4019A80BFB; Mon,  9 Nov 2020 11:04:54 +0100 (CET)
Date: Mon, 9 Nov 2020 11:04:54 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mingye Wang <arthur2e5@aosc.io>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: rewrite cmdline parser
Message-ID: <20201109100454.GX33165@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mingye Wang <arthur2e5@aosc.io>,
	cygwin-patches@cygwin.com
References: <20200905052711.13008-3-arthur2e5@aosc.io>
 <20201107121221.6668-1-arthur2e5@aosc.io>
 <20201107121221.6668-2-arthur2e5@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201107121221.6668-2-arthur2e5@aosc.io>
X-Provags-ID: V03:K1:WHeOwkVScAasKthnfxjRSWPUqmYim1VQctjyuSIGYi0gjb8tMN4
 aJRUCr5n1RoFaD27p+QvMFdlROqLGqVgSYpz+ZG4Ata+7DkJ6OHaA9Myj+ApbBw6XNH/Hqp
 NDdjSTere7XhFigWo/zK+hEfv+g+AwuVMvWHXw2yuRxDHZUX/4KAoF/ElZHEcWSjSGAhiRW
 HIPOtOAjVximkVxQjdUgQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JBiEEU9lPUw=:NUmKIAkfXUP4nhebQTSh6u
 GYe5K3ryGSswlX4qFYdi+GlnqNLJgbuvaOVYOyJBe2dtV8LFRh/YgSKYTIh/1cxF/C8FsOUD9
 ZLmVKgXI/Cr8tMKHjMrofyT9xlozbx8SUorrmo870+suVNwn+wYKs0inL4t7dx1MfD4RVQANV
 tGoUmCpFKQqCjxUskVxOU8nlQNjP0/HrrLhmTTBEQksM3cayGyVlGf6gg9AKUgZ1PbTf9UbMV
 Wcd5amVGjzGkIIskLNhC/PPqJVlz2TEIDwOvH5jpkNc8ihi3c6g0mXT+1azecdpWbm2wdKbPX
 IQfgahyiP8GCsXCB7DG/PVv1bwSQmFJgoqtJuCZwncJhjtNHE8f2yp4gHQP1/q44F6b5qBZfC
 nOmPH8ZVKT4ci3VS0uYnc5He7mURpvF1VteJcd4ThU3exFQgE7cB378cycrwZrYNqkPax79y3
 ic/duzYlEg==
X-Spam-Status: No, score=-100.9 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 09 Nov 2020 10:05:00 -0000

Hi Mingye,

On Nov  7 20:12, Mingye Wang wrote:
> This commit rewrites the cmdline parser to achieve the following:
> * MSVCRT compatibility. Except for the single-quote handling (an
>   extension for compatibility with old Cygwin), the parser now
>   interprets option boundaries exactly like MSVCR since 2008. This fixes
>   the issue where our escaping does not work with our own parsing.
> * Clarity. Since globify() is no longer responsible for handling the
>   opening and closing of quotes, the code is much simpler.
> * Sanity. The GLOB_NOCHECK flag is removed, so a failed glob correctly
>   returns the literal value. Without the change, anything path-like
>   would be garbled by globify's escaping.
> * A memory leak in the @file expansion is removed by rewriting it to use
>   a stack of buffers. This also simplifies the code since we no longer
>   have to move stuff. The "downside" is that tokens can no longer cross
>   file boundaries.
> 
> Some clarifications are made in the documentation for when globs are not
> expanded.
> 
> The change fixes two complaints of mine:
> * That cygwin is incompatible with its own escape.[1]
> * That there is no way to echo `C:\"` from win32.[2]
>   [1]: https://cygwin.com/pipermail/cygwin/2020-June/245162.html
>   [2]: https://cygwin.com/pipermail/cygwin/2019-October/242790.html
> 
> (It's never the point to spawn cygwin32 from cygwin64. Consistency
> matters: with yourself always, and with the outside world when you are
> supposed to.)

This looks already pretty good now, but there's a problem when building:

  winsup/cygwin/winf.cc:67:1: error: no declaration matches ‘bool linebuf::fromargv(av&, const char*, bool, bool)’
     67 | linebuf::fromargv (av& newargv, const char *real_path, bool trunc_for_cygwin, bool forcequote)
	| ^~~~~~~
  In file included from winsup/cygwin/winf.cc:16:
  winsup/cygwin/winf.h:76:15: note: candidate is: ‘bool linebuf::fromargv(av&, const char*, bool)’
     76 |   bool __reg3 fromargv(av&, const char *, bool);;
	|               ^~~~~~~~
  winsup/cygwin/winf.h:64:7: note: ‘class linebuf’ defined here
     64 | class linebuf
	|       ^~~~~~~

The declaration in winf.h is actually missing the "forcequote" arg.  Is
"forcequote" supposed to be a default parameter?  If so, defaulting to
true or false? 

However, given that *both* calls to fromargv() don't set forcequote at
all, it will be the same value for all callers and thus it's entirely
redundant.  So why not just drop it?

Also, this change

> +#if defined (__x86_64__) || defined (__CYGMAGIC__) || !defined (__GNUC__)

is entirely unrelated and should go into it's own patch explaining
why it's necessary.  After all, we're building Cygwin with gcc only...


Thanks,
Corinna
