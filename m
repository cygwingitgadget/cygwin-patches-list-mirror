Return-Path: <cygwin-patches-return-7096-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13159 invoked by alias); 11 Sep 2010 06:49:10 -0000
Received: (qmail 13147 invoked by uid 22791); 11 Sep 2010 06:49:09 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-ww0-f41.google.com (HELO mail-ww0-f41.google.com) (74.125.82.41)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 11 Sep 2010 06:49:04 +0000
Received: by wwe15 with SMTP id 15so282526wwe.2        for <cygwin-patches@cygwin.com>; Fri, 10 Sep 2010 23:49:02 -0700 (PDT)
Received: by 10.216.25.16 with SMTP id y16mr220127wey.25.1284187742494;        Fri, 10 Sep 2010 23:49:02 -0700 (PDT)
Received: from [192.168.2.99] (cpc2-cmbg8-0-0-cust61.5-4.cable.virginmedia.com [82.6.108.62])        by mx.google.com with ESMTPS id k46sm2252664weq.10.2010.09.10.23.49.01        (version=SSLv3 cipher=RC4-MD5);        Fri, 10 Sep 2010 23:49:01 -0700 (PDT)
Message-ID: <4C8B2B9B.8060801@gmail.com>
Date: Sat, 11 Sep 2010 06:49:00 -0000
From: Dave Korn <dave.korn.cygwin@gmail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add fenv.h and support.
References: <4C8A9AC8.7070904@gmail.com> <20100910214347.GA23700@ednor.casa.cgf.cx> <4C8AD089.9000605@gmail.com> <20100911051009.GA25209@ednor.casa.cgf.cx>
In-Reply-To: <20100911051009.GA25209@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00056.txt.bz2

On 11/09/2010 06:10, Christopher Faylor wrote:
> On Sat, Sep 11, 2010 at 01:42:49AM +0100, Dave Korn wrote:
>> On 10/09/2010 22:43, Christopher Faylor wrote:
>>
>>> Looks nice to me with one HUGE caveat:  Please maintain the pseudo-sorted
>>> order in cygwin.din.  Sorry to have to impose this burden on you.
>>  No, that's fine; I've never been sure whether we need to care about the
>> ordinal numbers or not in that file.  (AFAIK, we don't have any realistic
>> scenarios where anyone would be linking against the Cygwin DLL by ordinal
>> imports, but I hate making assumptions based only on my own limited experience...)
> 
> It never even occurred to me about ordinal numbers but since I've been
> reorganizing that file for years I guess it hasn't been a problem.

  I checked.  Something somewhere sorts all the exports it turns out, so they
all get ordinals assigned in alphanumeric sort order anyway, regardless of
cygwin.din order.  So, I ended up committing it like so:

> Index: winsup/cygwin/cygwin.din
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
> retrieving revision 1.224
> diff -p -u -r1.224 cygwin.din
> --- winsup/cygwin/cygwin.din	19 Jul 2010 18:22:40 -0000	1.224
> +++ winsup/cygwin/cygwin.din	11 Sep 2010 06:44:11 -0000
> @@ -453,10 +453,29 @@ fdopen SIGFE
>  _fdopen = fdopen SIGFE
>  _fdopen64 = fdopen64 SIGFE
>  fdopendir SIGFE
> +_fe_dfl_env DATA
> +_fe_nomask_env DATA
> +feclearexcept NOSIGFE
> +fedisableexcept NOSIGFE
> +feenableexcept SIGFE
> +fegetenv NOSIGFE
> +fegetexcept NOSIGFE
> +fegetexceptflag NOSIGFE
> +fegetprec NOSIGFE
> +fegetround NOSIGFE
> +feholdexcept SIGFE
> +_feinitialise NOSIGFE
>  feof SIGFE
>  _feof = feof SIGFE
> +feraiseexcept SIGFE
>  ferror SIGFE
>  _ferror = ferror SIGFE
> +fesetenv SIGFE
> +fesetexceptflag SIGFE
> +fesetprec NOSIGFE
> +fesetround NOSIGFE
> +fetestexcept NOSIGFE
> +feupdateenv SIGFE
>  fexecve SIGFE
>  fflush SIGFE
>  _fflush = fflush SIGFE

  Otherwise, committed as posted.

    cheers,
      DaveK
