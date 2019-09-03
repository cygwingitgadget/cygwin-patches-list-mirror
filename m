Return-Path: <cygwin-patches-return-9592-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 43601 invoked by alias); 3 Sep 2019 03:05:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 43592 invoked by uid 89); 3 Sep 2019 03:05:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-6.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HDKIM-Filter:v2.10.3, UD:jp
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 03 Sep 2019 03:05:40 +0000
Received: from Express5800-S70 (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id x8335N61015193	for <cygwin-patches@cygwin.com>; Tue, 3 Sep 2019 12:05:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x8335N61015193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567479923;	bh=FmBCjIyYmv9c3G5oFh80vMIq++r9SywnHPiE3vZ1eww=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=Ts8TZrqzYn1+eqvgi19VvUxNxrAQxMXzzFb0G2CQ8p/1Cbu5uPt3EJTkKDVYhONJZ	 G25l9GpO4jBpuPoT4DXm/7d4Xo/BLylBqWNs2hkqlmW3bQ4ufEfU1KbU83k7FILEcJ	 acE4CS6guvSCGpPL5U6PGU04fKi6mEdNI9dbrixDcEI6pGEbxJVkQDkBBUaoqilgpj	 qyI/ugeKswkt/M7YunjT/ST4ofIeoqApRxJSD/scoVO9oshSkh+4pzRfXTY73Iy3Qt	 e/5V/HuhmqtI/S8W/h4x229wDmJwEa4pUw4YWUXXM0SDkcrttTpcf890obYgAW0wQ1	 Gve4xWoUSOG7w==
Date: Tue, 03 Sep 2019 03:05:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 1/1] Cygwin: pty: Fix state management for pseudo console support.
Message-Id: <20190903120530.f7b31bfa6feb2118762891a2@nifty.ne.jp>
In-Reply-To: <20190902143716.GF4164@calimero.vinschen.de>
References: <20190901221156.1367-1-takashi.yano@nifty.ne.jp>	<20190901221156.1367-2-takashi.yano@nifty.ne.jp>	<20190902143716.GF4164@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00112.txt.bz2

Hi Corinna,

On Mon, 2 Sep 2019 16:37:16 +0200
Corinna Vinschen wrote:
> >  class fhandler_pty_slave: public fhandler_pty_common
> >  {
> >    HANDLE inuse;			// used to indicate that a tty is in use
> >    HANDLE output_handle_cyg, io_handle_cyg;
> > +  DWORD pidRestore;
> 
> Please don't use camelback.  s/pidRestore/pid_restore/g

I will fix it in v5 patch.

> > -	      HeapAlloc (GetProcessHeap (), 0, num * sizeof (DWORD));
> > -  num = GetConsoleProcessList (list, num);
> > +	      HeapAlloc (GetProcessHeap (), 0, (num + 16) * sizeof (DWORD));
> > +  num = GetConsoleProcessList (list, num + 16);
> 
> You're still going to change that, right?

This is temporary code while debugging. Sorry. I will fix it in v5.

> > @@ -855,26 +868,6 @@ fhandler_pty_slave::cleanup ()
> >  int
> >  fhandler_pty_slave::close ()
> >  {
> > -#if 0
> > -  if (getPseudoConsole ())
> > -    {
> > -      INPUT_RECORD inp[128];
> > -      DWORD n;
> > -      PeekFunc =
> > -	PeekConsoleInputA_Orig ? PeekConsoleInputA_Orig : PeekConsoleInput;
> > -      PeekFunc (get_handle (), inp, 128, &n);
> > -      bool pipe_empty = true;
> > -      while (n-- > 0)
> > -	if (inp[n].EventType == KEY_EVENT && inp[n].Event.KeyEvent.bKeyDown)
> > -	  pipe_empty = false;
> > -      if (pipe_empty)
> > -	{
> > -	  /* Flush input buffer */
> > -	  size_t len = UINT_MAX;
> > -	  read (NULL, len);
> > -	}
> > -    }
> > -#endif
> 
> Ideally stuff like that should be in a separate code cleanup patch.

I see. I will post it as a separate patch.

> > -      Sleep (60); /* Wait for pty_master_fwd_thread() */
> > +      Sleep (20); /* Wait for pty_master_fwd_thread() */
> 
> Isn't that a separate issue as well?  A separate patch may be in order
> here, kind of like "Cygwin: pseudo console: reduce time sleeping ..."
> with a short description why that makes sense?

Actually it is not. The wait time became able to be reduced by
redesigning switching of r/w pipes which managed via variable
switch_to_pcon. So I think this should be included in this patch. 

> > +	  /* If not attached this pseudo console, try to attach temporarily. */
>                            ^^^^
>                             to

Thanks.

> > -	  get_ttyp ()->hPseudoConsole = NULL;
> > +	  //get_ttyp ()->hPseudoConsole = NULL; // Do not clear for safty.
> 
> Why don't you just drop the line?

OK. Just drop it.

> Other than that, the patch looks good.
> 
> However, I have a few questions in terms of the code in general, namely
> in terms of
> 
>   ALWAYS_USE_PCON
>   USE_API_HOOK
>   USE_OWN_NLS_FUNC
> 
> Can you describe again why you introduced these macros?

These are defined for debugging purpose.

If ALWAYS_USE_PCON is defined to true, pseudo console pipe is used for
all process including pure cygwin process. Usually, this should be false
so that the cygwin process use named pipe as previous.

USE_API_HOOK is for enabling/disabling the API hook to detect direct
console access in cygwin process. This should be true so that the
r/w pipe switching is set to pseudo console side for the cygwin
process which directly access console.

As for USE_OWN_NLS_FUNC, I have not decided yet which codes should be
used. If USE_OWN_NLS_FUNC is false, setlocale (LC_CTYPE, "") is
called therefore it may affect to some programs wihch do not call
setlocale().

> In terms of USE_API_HOOK:
> 
> - Shouldn't the hook_api function be moved to hookapi.cc?

I will move it into hookapi.cc, and post it as a separate patch.

> - Do we really want to hook every invocation of WriteFile/ReadFile?
>   Doesn't that potentially slow down an exec'ed process a lot?
>   We're still not using the NT functions throughout outside of the
>   console/tty code.

I measured the time for calling WriteFile() 1000000 times writing
1 byte to a disk file for each call.

Not hooked:
Total: 4.558321 seconsd

Hooked:
Total: 6.522692 seconsd

Hooking causes slow down indeed. It seems that GetConsoleMode()
is slow. So I have added the check for GetFileType() before
GetConsoleMode() and made check in two stages.

Hooked (new):
Total: 5.217996 seconsd

This results in speed up a little. I will post another patch for this.

> In terms of USE_OWN_NLS_FUNC:
> 
> - Why do we need this function at all?  Can't this be handled by
>   __loadlocale instead?  If not, what is __loadlocale missing to make
>   this work without duplicating the function?

Calling __loadlocale() here causes execution error.

mintty:
      0 [main] tcsh 1901 sig_send: error sending signal 6, pid 1901, pipe handle 0x0, nb 0, packsize 164, Win32 error 6

script:
Script started, file is typescript
script: failed to execute /bin/tcsh: Bad address
Script done, file is typescript

I could not find out the reason. Some kind of initialization which
is needed by __loadlocale() may not be done yet. So I copied
only necessary part from __loadlocale() and nl_langinfo().

Simply,
 path_conv a ("/usr/share/locale/locale.alias");
also causes errors on starting mintty.

Ideally, the cause of the error should be found out, I suppose.


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
