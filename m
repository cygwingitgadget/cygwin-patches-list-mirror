Return-Path: <cygwin-patches-return-10147-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 76598 invoked by alias); 28 Feb 2020 22:57:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 76589 invoked by uid 89); 28 Feb 2020 22:57:14 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-14.9 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=
X-HELO: mout.gmx.net
Received: from mout.gmx.net (HELO mout.gmx.net) (212.227.17.22) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 28 Feb 2020 22:57:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;	s=badeba3b8450; t=1582930627;	bh=SfurnYKCbPsfZfsfAgTWtLT10IA4+QkMeORXA9NJF3c=;	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;	b=UcTV/euzoP4BBUqO74pb/xjBdYaBkTTZTfLfIyIt1gewlMzHUT/SRZcqkwEC8Z4m0	 z6GlhIRNUT4cIccp1yW1OVVOmeXYitgT01VadOzFEm1YM2EsncGd6xKQNygnWdJEpq	 k51amVDEsopiCIwslSmhmtUBA/YvWpHerxg9fAj4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAfUe-1jERLf0K7c-00B7GR; Fri, 28 Feb 2020 23:57:07 +0100
Date: Fri, 28 Feb 2020 22:57:00 -0000
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jon Turney <jon.turney@dronecode.org.uk>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: remove %esp from asm clobber list
In-Reply-To: <20200228120413.1560-1-jon.turney@dronecode.org.uk>
Message-ID: <nycvar.QRO.7.76.6.2002282355080.11433@tvgsbejvaqbjf.bet>
References: <20200228120413.1560-1-jon.turney@dronecode.org.uk>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00253.txt

Hi,

On Fri, 28 Feb 2020, Jon Turney wrote:

> Mentioning the stack pointer in the clobber list is now a gcc warning.
>
> We never wanted gcc to try to restore %esp after this (x86-specific)
> asm, since the whole point of the inline asm here is to adjust %esp to
> satisfy alignment, so remove %esp from the asm clobber list.
>
> Of more concern is the alleged requirement that %esp must be unchanged
> over an asm statement (which makes what this code is trying to do
> impossible to write as a C function), although on x86 we are probably ok
> in this particular instance.
>
> ../../../../winsup/cygwin/init.cc: In function 'void threadfunc_fe(void*)=
':
> ../../../../winsup/cygwin/init.cc:33:46: error: listing the stack pointer=
 register '%esp' in a clobber list is deprecated [-Werror=3Ddeprecated]
> ../../../../winsup/cygwin/init.cc:33:46: note: the value of the stack poi=
nter after an 'asm' statement must be the same as it was before the stateme=
nt
>
> Also, because we now using gcc's "basic" rather than "extended" asm
> syntax we don't need to escape the '%' in '%esp' as '%%esp'.
> ---
>
> Notes:
>     N.B: This comes with a 'this should be ok, but I haven't actually
>     tested that x86 Cygwin works after this' caveat.

We run with this patch in Git for Windows for quite a while, and I have
yet to hear complaints:

https://github.com/git-for-windows/msys2-runtime/commit/dd5aa267f6f28aef2a2=
41cc7a01bb71a434b403c

As far as I can tell, MSYS2 does the same.

So there is at least some confirmation to be had ;-)

Ciao,
Dscho

>
>  winsup/cygwin/crt0.c  | 2 +-
>  winsup/cygwin/init.cc | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/winsup/cygwin/crt0.c b/winsup/cygwin/crt0.c
> index fee4b2e24..9fcebd8fa 100644
> --- a/winsup/cygwin/crt0.c
> +++ b/winsup/cygwin/crt0.c
> @@ -27,7 +27,7 @@ mainCRTStartup ()
>  #if __GNUC_PREREQ(6,0)
>  #pragma GCC diagnostic pop
>  #endif
> -  asm volatile ("andl $-16,%%esp" ::: "%esp");
> +  asm volatile ("andl $-16,%esp");
>  #endif
>
>    cygwin_crt0 (main);
> diff --git a/winsup/cygwin/init.cc b/winsup/cygwin/init.cc
> index 851a7ffed..7ae7d08fe 100644
> --- a/winsup/cygwin/init.cc
> +++ b/winsup/cygwin/init.cc
> @@ -30,7 +30,7 @@ threadfunc_fe (VOID *arg)
>  #if __GNUC_PREREQ(6,0)
>  #pragma GCC diagnostic pop
>  #endif
> -  asm volatile ("andl $-16,%%esp" ::: "%esp");
> +  asm volatile ("andl $-16,%esp");
>  #endif
>    _cygtls::call ((DWORD (*)  (void *, void *)) TlsGetValue (_my_oldfunc)=
, arg);
>  }
> --
> 2.21.0
>
>
