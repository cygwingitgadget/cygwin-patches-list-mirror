Return-Path: <SRS0=JFVn=EN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0004.nifty.com (mta-snd00007.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id A0BEF3858D28
	for <cygwin-patches@cygwin.com>; Mon, 28 Aug 2023 12:09:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A0BEF3858D28
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 by dmta0004.nifty.com with ESMTP
          id <20230828120953811.LPYC.104251.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 28 Aug 2023 21:09:53 +0900
Date: Mon, 28 Aug 2023 21:09:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: spawn: Fix segfalt when too many command
 line args are specified.
Message-Id: <20230828210953.5b5c11840014f916b6ea21b3@nifty.ne.jp>
In-Reply-To: <ZOx9j/YRr3UX88wV@calimero.vinschen.de>
References: <20230828094605.2405-1-takashi.yano@nifty.ne.jp>
	<ZOx9j/YRr3UX88wV@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 28 Aug 2023 12:57:19 +0200
Corinna Vinschen wrote:
> On Aug 28 18:46, Takashi Yano wrote:
> > Previously, the number of command line args was not checked for
> > cygwin process. Due to this, segmentation fault was caused if too
> > many command line args are specified.
> > https://cygwin.com/pipermail/cygwin/2023-August/254333.html
> > 
> > Since char *argv[argc + 1] is placed on the stack in dll_crt0_1(),
> > STATUS_STACK_OVERFLOW occurs if the stack does not have enough
> > space.
> > 
> > With this patch, the total length of the arguments and the size of
> > argv[] is restricted to 1/4 of total stack size for the process, and
> > spawnve() returns E2BIG if the size exceeds the limit.
> > [...]
> > +static size_t
> > +get_stack_size (const WCHAR *filename)
> > +{
> > +  HANDLE h;
> > +  h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
> > +		   NULL, OPEN_EXISTING, 0, NULL);
> > +  char buf[1024];
> > +  DWORD n;
> > +  ReadFile (h, buf, sizeof (buf), &n, 0);
> > +  CloseHandle (h);
> > +  IMAGE_NT_HEADERS32 *p = (IMAGE_NT_HEADERS32 *) memmem (buf, n, "PE\0\0", 4);
> > +  if (!p)
> > +    return 0;
> > +  if ((char *) &p->OptionalHeader.SizeOfStackCommit > buf + n)
> > +    return 0; /* buf[] is not enough */
> > +  if (p->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR32_MAGIC)
> > +    return p->OptionalHeader.SizeOfStackReserve;
> > +  IMAGE_NT_HEADERS64 *p64 = (IMAGE_NT_HEADERS64 *) p;
> > +  if ((char *) &p64->OptionalHeader.SizeOfStackCommit > buf + n)
> > +    return 0; /* buf[] is not enough */
> > +  return p64->OptionalHeader.SizeOfStackReserve;
> > +}
> 
> Sorry, but this proposal is too complicated, IMHO.
> 
> Checking the stacksize in the file header for each single execve
> is quite a bit time consuming, isn't it?

I did this because the stack size of an executable can vary by
peflags -x command or -Wl,--stack=xxxxx option.

> The question is rather, why storing argv on the stack at all?  I guess
> the original idea was that argv is always a rather overseeable number.
> But it doesn't have to stay on the stack.
> 
> I tried this simple patch:
> 
> diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
> index 49b7a44aeb15..961dea4ab993 100644
> --- a/winsup/cygwin/dcrt0.cc
> +++ b/winsup/cygwin/dcrt0.cc
> @@ -978,11 +978,8 @@ dll_crt0_1 (void *)
>  	 a change to an element of argv[] it does not affect Cygwin's argv.
>  	 Changing the the contents of what argv[n] points to will still
>  	 affect Cygwin.  This is similar (but not exactly like) Linux. */
> -      char *newargv[__argc + 1];
> -      char **nav = newargv;
> -      char **oav = __argv;
> -      while ((*nav++ = *oav++) != NULL)
> -	continue;
> +      char **newargv = (char **) malloc ((__argc + 1) * sizeof (char **));
> +      memcpy (newargv, __argv, (__argc + 1) * sizeof (char **));
>        /* Handle any signals which may have arrived */
>        sig_dispatch_pending (false);
>        _my_tls.call_signal_handler ();
> 
> and the testcase `LC_ALL=C sed 's/x/y/' $(seq 1000000)' simply ran
> as desired.  Combined with a bit of error checking...
> 
> > diff --git a/winsup/cygwin/sysconf.cc b/winsup/cygwin/sysconf.cc
> > index 2db92e4de..6cb2aecd0 100644
> > --- a/winsup/cygwin/sysconf.cc
> > +++ b/winsup/cygwin/sysconf.cc
> > @@ -21,6 +21,13 @@ details. */
> >  #include "cpuid.h"
> >  #include "clock.h"
> >  
> > +#define DEFAULT_STACKGUARD (wincap.def_guard_page_size() + wincap.page_size ())
> > +static long
> > +get_arg_max (int in)
> > +{
> > +  return (long) (get_rlimit_stack () + DEFAULT_STACKGUARD) / 4;
> > +}
> > +
> >  static long
> >  get_page_size (int in)
> >  {
> > @@ -485,7 +492,7 @@ static struct
> >      };
> >  } sca[] =
> >  {
> > -  {cons, {c:ARG_MAX}},			/*   0, _SC_ARG_MAX */
> > +  {func, {f:get_arg_max}},		/*   0, _SC_ARG_MAX */
> >    {cons, {c:CHILD_MAX}},		/*   1, _SC_CHILD_MAX */
> >    {cons, {c:CLOCKS_PER_SEC}},		/*   2, _SC_CLK_TCK */
> >    {cons, {c:NGROUPS_MAX}},		/*   3, _SC_NGROUPS_MAX */
> > -- 
> > 2.39.0
> 
> Along these lines, there's no reason to couple SC_ARG_MAX to the
> size of the stack.  I'd propose to return the value 2097152.  It's
> the default value returned by getconf ARG_MAX on LInx as well.

The default value of 2097152 in Linux comes from 1/4 of the stack
size. It varies by ulimit -s command. So I tried to imitate it.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
