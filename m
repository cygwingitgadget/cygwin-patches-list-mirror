Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 28544385B805
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 11:33:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 28544385B805
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MRn0U-1lUWD03FgQ-00T9OQ for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 12:33:00 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1E23BA80988; Mon, 18 Jan 2021 12:33:00 +0100 (CET)
Date: Mon, 18 Jan 2021 12:33:00 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 06/11] cxx.cc: Fix dynamic initialization for static
 local variables
Message-ID: <20210118113300.GW59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-7-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115134534.13290-7-ben@wijen.net>
X-Provags-ID: V03:K1:luhPED9DhY5W09oqcZROO41tFBq69w3qj/z+k3v9TjT4Xg8pNCH
 hrYCPTM0yFwlWqginbN1BDafXa9L80WJnvOZ092KwjCbbHoISOdCesK+F6ErrPoEvH+Hl3w
 hL7nx0wEpFxPQXgCndr1yZAQDUkXBAQBaQKfpPsBLpgceEDEXZWW3DFgbzvtZjdjO0nMLuN
 g3pn7yZn++PEpuWRNHdsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3MLY0CwFq1w=:2vIRV9x/ygyrhB2dX0Ryad
 bac3/GO7kXENQ/TL5YIcTS0vmdDmNsNeHjODP5VfroTiaurZSi5EQ/NsDicY4oM9/Ww1MJRdK
 FT4e/PBumq4gi0zy5d91zJStOeMdODVzALm8raCLdwntjGUXXZQOGvqBE18PNzTisdgZC01YR
 5hRxHkuZe6jfZaJ9Q4X3R1Fy9L6am7PmHxrDc9qtnqLmfaG4Dkqy6z5vL12vbDPvFfOJ5Tqm8
 XoiC5KfOV2hk0fcDm3F1XLp5FAnIbVnH8CgOxc1CEl9XXlXqmxRjvYclY4kg4QaO3hLHquf3k
 0BiwIT16oJpQG1fNpv0R2KVcIydm/c3HQFPWecHCmEeVjUlrEjHVkbNOchPSsnq0CZCAv1AGW
 5ErD5VSvXD3RdgpTJb+LQcTXucMPXvdlEcoEvkVKegQcKGay0hUccHOu4h7cP7k1XKWEQdu5P
 aunkIwH4ZA==
X-Spam-Status: No, score=-106.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 18 Jan 2021 11:33:03 -0000

On Jan 15 14:45, Ben Wijen wrote:
> The old implementation for __cxa_guard_acquire did not return 1,
> therefore dynamic initialization was never performed.
> 
> If concurrent-safe dynamic initialisation is ever needed, CXX ABI
> must be followed when re-implementing __cxa_guard_acquire (et al.)
> ---
>  winsup/cygwin/Makefile.in |  2 +-
>  winsup/cygwin/cxx.cc      | 10 ----------
>  2 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
> index a840f2b83..73d9b37fd 100644
> --- a/winsup/cygwin/Makefile.in
> +++ b/winsup/cygwin/Makefile.in
> @@ -69,7 +69,7 @@ COMMON_CFLAGS=-MMD ${$(*F)_CFLAGS} -Wimplicit-fallthrough=5 -Werror -fmerge-cons
>  ifeq ($(target_cpu),x86_64)
>  COMMON_CFLAGS+=-mcmodel=small
>  endif
> -COMPILE.cc+=${COMMON_CFLAGS} # -std=gnu++14
> +COMPILE.cc+=${COMMON_CFLAGS} -fno-threadsafe-statics # -std=gnu++14
>  COMPILE.c+=${COMMON_CFLAGS}
>  
>  AR:=@AR@
> diff --git a/winsup/cygwin/cxx.cc b/winsup/cygwin/cxx.cc
> index be3268549..b69524aca 100644
> --- a/winsup/cygwin/cxx.cc
> +++ b/winsup/cygwin/cxx.cc
> @@ -83,16 +83,6 @@ __cxa_pure_virtual (void)
>    api_fatal ("pure virtual method called");
>  }
>  
> -extern "C" void
> -__cxa_guard_acquire ()
> -{
> -}
> -
> -extern "C" void
> -__cxa_guard_release ()
> -{
> -}
> -
>  /* These routines are made available as last-resort fallbacks
>     for the application.  Should not be used in practice; the
>     entries in this struct get overwritten by each DLL as it
> -- 
> 2.29.2

Pushed.


Thanks,
Corinna
