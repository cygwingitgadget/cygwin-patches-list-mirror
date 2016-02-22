Return-Path: <cygwin-patches-return-8348-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 99151 invoked by alias); 22 Feb 2016 11:44:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 99102 invoked by uid 89); 22 Feb 2016 11:44:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.2 spammy=undocumented, file's, Hx-languages-length:2811, HTo:U*cygwin-patches
X-HELO: out4-smtp.messagingengine.com
Received: from out4-smtp.messagingengine.com (HELO out4-smtp.messagingengine.com) (66.111.4.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Mon, 22 Feb 2016 11:44:49 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])	by mailout.nyi.internal (Postfix) with ESMTP id 065FE20AD8	for <cygwin-patches@cygwin.com>; Mon, 22 Feb 2016 06:44:47 -0500 (EST)
Received: from frontend2 ([10.202.2.161])  by compute5.internal (MEProxy); Mon, 22 Feb 2016 06:44:47 -0500
Received: from [192.168.1.102] (host86-184-210-93.range86-184.btcentralplus.com [86.184.210.93])	by mail.messagingengine.com (Postfix) with ESMTPA id 84C556800F3;	Mon, 22 Feb 2016 06:44:46 -0500 (EST)
Subject: Re: [PATCH] gprof profiling of multi-threaded Cygwin programs, ver 2
References: <56C820D8.4010203@maxrnd.com>
Cc: Mark Geisert <mark@maxrnd.com>
To: Cygwin Patches <cygwin-patches@cygwin.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <56CAF4A3.5060806@dronecode.org.uk>
Date: Mon, 22 Feb 2016 11:44:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <56C820D8.4010203@maxrnd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2016-q1/txt/msg00054.txt.bz2

Thanks for this.  A few comments inline.

On 20/02/2016 08:16, Mark Geisert wrote:
> diff --git a/winsup/cygwin/cygheap.cc b/winsup/cygwin/cygheap.cc
> index 6493485..4932cf0 100644
> --- a/winsup/cygwin/cygheap.cc
> +++ b/winsup/cygwin/cygheap.cc
> @@ -744,3 +744,15 @@ init_cygheap::find_tls (int sig, bool& issig_wait)
>       WaitForSingleObject (t->mutex, INFINITE);
>     return t;
>   }
> +
> +/* Called from profil.c to sample all non-main thread PC values for profiling */
> +extern "C" void
> +cygheap_profthr_all (void (*profthr_byhandle) (HANDLE))
> +{
> +  for (uint32_t ix = 0; ix < nthreads; ix++)
> +    {
> +      _cygtls *tls = cygheap->threadlist[ix].thread;
> +      if (tls->tid)
> +	profthr_byhandle (tls->tid->win32_obj_id);
> +    }
> +}

There doesn't seem to be anything specific to profiling about this, so 
it could be written in a more generic way, as "call a callback function 
for each thread".

> diff --git a/winsup/cygwin/external.cc b/winsup/cygwin/external.cc
> index e379df1..02335eb 100644
> --- a/winsup/cygwin/external.cc
> +++ b/winsup/cygwin/external.cc
> @@ -702,6 +702,17 @@ cygwin_internal (cygwin_getinfo_types t, ...)
>   	}
>   	break;
>
> +      case CW_CYGHEAP_PROFTHR_ALL:
> +	{
> +	  typedef void (*func_t) (HANDLE);
> +	  extern void cygheap_profthr_all (func_t);
> +
> +	  func_t profthr_byhandle = va_arg(arg, func_t);
> +	  cygheap_profthr_all (profthr_byhandle);
> +	  res = 0;
> +	}
> +	break;
> +

Is this exposed via cygwin_internal() operation just for testing 
purposes?  Or is there some other use envisioned?

> +	/* We copy an undocumented glibc feature: customizing the profiler's
> +	   output file name somewhat, depending on the env var GMON_OUT_PREFIX.
> +	   if GMON_OUT_PREFIX is unspecified, the file's name is "gmon.out".
> +
> +	   if GMON_OUT_PREFIX is specified with at least one character, the
> +	   file's name is computed as "$GMON_OUT_PREFIX.$pid".
> +
> +	   if GMON_OUT_PREFIX is specified but contains no characters, the
> +	   file's name is computed as "gmon.out.$pid".  Cygwin-specific.
> +	*/
> +	if ((prefix = getenv("GMON_OUT_PREFIX")) != NULL) {

setup-env.xml might be an appropriate place to mention this environment 
variable.

>   static void CALLBACK
>   profthr_func (LPVOID arg)
>   {
>     struct profinfo *p = (struct profinfo *) arg;
> -  size_t pc, idx;
>
>     for (;;)
>       {
> -      pc = (size_t) get_thrpc (p->targthr);
> -      if (pc >= p->lowpc && pc < p->highpc)
> -	{
> -	  idx = PROFIDX (pc, p->lowpc, p->scale);
> -	  p->counter[idx]++;
> -	}
> +      // record profiling sample for main thread
> +      profthr_byhandle (p->targthr);
> +
> +      // record profiling samples for other pthreads, if any
> +      cygwin_internal (CW_CYGHEAP_PROFTHR_ALL, profthr_byhandle);
> +

Hmm.. so why isn't this written as cygheap_profthr_all (profthr_byhandle) ?


