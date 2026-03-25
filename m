Return-Path: <SRS0=haOa=BZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 60CA04BB5922
	for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 12:41:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 60CA04BB5922
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 60CA04BB5922
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774442474; cv=none;
	b=OtyNauYMvUH7CETc9MuvkzqBnVccho4/pLnyGPr+Ch+mIobNo0Lnw/v3Mn5h1ZjiDXNsiwb+UScpmYyopWKk3inxrvD9Ljdh9kO0+lYSGM/AD9k/F2EkZv1hOf1LvftAZ+jZT3MRV22T+HSDvWG+9Hd5BPw7CbtrI28ZvE4sGJ8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774442474; c=relaxed/simple;
	bh=+4XLPkYYzJSngdqOzQUEAidrTI5/Rj5mTaV6c6dmVyQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=j+/yzrSVURu/Huoj1PP5TiXPWhgAZVn7r+vk10QwXCfmVZfCRiHtnN9B17ok6aNuWVKTnfkqshSkDzeOT5hsrWntEgqeAl+5EbjwqUbPft0j5rVOKYX1pRnz3QPZ2J6CsU6OZm/e9NH/yykmB/Ri/ncnf+Dx618GR5Pol5kRf2k=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 60CA04BB5922
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=mVD69C/s
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260325124111567.CPTZ.14880.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 21:41:11 +0900
Date: Wed, 25 Mar 2026 21:41:09 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 1/3] Cygwin: pty: Use OpenConsole.exe if available
Message-Id: <20260325214109.eda376ea321601393aa2a13e@nifty.ne.jp>
In-Reply-To: <90f23c8e-cb9c-ad64-8c22-2f5cb3a535e3@gmx.de>
References: <20260312113923.1528-1-takashi.yano@nifty.ne.jp>
	<20260312113923.1528-2-takashi.yano@nifty.ne.jp>
	<90f23c8e-cb9c-ad64-8c22-2f5cb3a535e3@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__25_Mar_2026_21_41_09_+0900_rQ3rR2NKHdQWDWUZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774442471;
 bh=aXYg9gl36WYEXCovV5mRfRSmv/BueUSc5GlsTQY8U7Q=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=mVD69C/s5CeV8S/uEx1pSsBblODw2NkOeKGv4KSbRtcJa4vaDD3w4WIS7l9XjKCMLQsu7w9B
 WzfsVkElrUSMVimZzmtPp33J7XEdAtSBYcDoC8CBhX91ykuJvQP2CyBPJchD8L3d+PYZ2bRKgR
 YRw+Pvpk7AGJ/bDvMXs5CzjSXO357A/q1cIJ3UVOK6D9rxfr3V7Pky6Ey+NoNlfqR3drpk+cA2
 4xiqAXsIUmoNUZ7ezhJ7OXiAmOwlv1LA8T/+G7oM8esw7tE1roXbyjO3RBa/VCEthK/QK2mXV1
 8hrJD4ioWaKy19C3Pr8juz3khVzj5zdRjz7G3UFzgOoyqcaA==
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Wed__25_Mar_2026_21_41_09_+0900_rQ3rR2NKHdQWDWUZ
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

Hi Johannes,

Thanks for reviewing!

On Mon, 16 Mar 2026 10:55:29 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Thu, 12 Mar 2026, Takashi Yano wrote:
> 
> > This patch replaces legacy conhost.exe with OpenConsole.exe if
> > it is available. This enables various new features such as mouse
> > support in pseudo console and bug fixes. The legacy conhost has
> > problems, e.g. character attributes are mangled or ignored, and
> > terminal reports are not passed through. This patch resolve the
> > issue by loading /usr/bin/OpenColnsole.exe instead of conhost.exe
> 
> I know that Corinna cares about typos in commit messages, so I'd like to
> point out that "OpenColnsole" has an extra "l" in it.
> 
> > if it is available.
> 
> My biggest issue with this patch: There is no opt-out mechanism: No
> CYGWIN=disable_openconsole or MSYS=disable_openconsole flag. If
> /usr/bin/OpenConsole.exe exists and is buggy, or this here patch, the user
> is stuck.

Thnaks. I'll add CYGWIN=use_lagacy_pcon option.

> My second-biggest issue: The commit message leaves too many legitimate
> questions unanswered. It says "various new features such as mouse support"
> and "terminal reports are not passed through" without specifics, without

To be honest, aside from the few points I mentioned here, I’m not aware
of any other improvements in OpenConsole.exe.
I tested only mouse support and attached text from Thomas.
These improvements seems already applied to conhost.exe in
latest Windows 11.

Any idea > Thomas?

> linking to any bug report, and without explaining why reimplementing
> `CreatePseudoConsole()` using undocumented NT kernel APIs
> (`\Device\ConDrv\Server`) is necessary (vs. just passing the
> `OpenConsole.exe` path to the standard `CreatePseudoConsole()` somehow).
> The message also doesn't address the maintenance burden of vendoring
> Windows Terminal code.

I expect the APIs will not be changed so often, because the same code
works even for old conhost.exe.

> Another concern I have, which is however very easily addressed, is that
> this patch does two things for the price of one. It would be better to
> separate the CSIc handling from the `OpenConsole.exe` integration. This
> would make it possible to fast-track one without the other, and make
> reviews of future iterations much easier.

I'll separate the CSIc matter.

> > +extern "C" WINBASEAPI HRESULT WINAPI
> 
> This should probably not be exported from cygwin1.dll, it is for
> internal use only.
> 
> > +CreatePseudoConsole_new (COORD size, HANDLE h_input, HANDLE h_output,
> > +			 DWORD flags, HPCON *hpcon)

Thanks. Fixed.

> > +{
> > +
> > +  HANDLE h_con_server, h_con_reference;
> > +  NTSTATUS status;
> > +  BOOL res;
> > +  HANDLE h_read_pipe, h_write_pipe;
> > +  BOOL inherit_cursor;
> > +  path_conv conhost ("/usr/bin/OpenConsole.exe");
> 
> Is it really a good idea to hard-code that path? That would not only
> preclude an `OpenConsole.exe` that is in the `PATH` to be used, it also
> suggests that you plan on building a Cygwin version of that executable
> (because that location should only contain native Cygwin applications and
> DLLs).

I imagine we would have openconsole cygwin package which install
OpenConsole.exe into /usr/bin/.

> > +  InitializeProcThreadAttributeList (NULL, 1, 0, &list_size);
> 
> This requires a corresponding `DeleteProcThreadAttributeList()` call.

This call is for retrieving list_size. Nothing is allocated with this call.
 
> > +  hpcon_internal->hWritePipe = h_write_pipe;
> > +  hpcon_internal->hConDrvReference = h_con_reference;
> > +  hpcon_internal->hConHostProcess = pi.hProcess;
> > +  *hpcon = (HPCON) hpcon_internal;
> > +
> > +  HeapFree (GetProcessHeap(), 0, attr_list);
> > +  CloseHandle (h_con_server);
> > +  CloseHandle (pi.hThread);
> 
> I see `h_read_pipe` being closed in the failure mode, but not in the
> success one.
> 
> `h_write_pipe` is stored in `*h_pcon`, so it becomes the caller's
> responsibility. And `h_con_server`/`pi.hThread` are closed properly, but I
> don't see where `h_read_pipe` is handled properly.

Indeed. My fault. Fixed.

> > -  if (get_ttyp ()->pcon_start)
> > +  int pcon_start_mode =
> > +    get_ttyp ()->pcon_start ? 1 : (get_ttyp ()->pcon_start_csi_c ? 2 : 0);
> > +  if (pcon_start_mode)
> 
> Does this need to be made thread-safe in case `write()` is called
> simultaneously on two separate processor cores?

Yeah! Thanks for pointing this out. This is not a bug only of
OpenConsole.exe implementation, but also regacy psseudo console.
I'll submit an indivisual patch.

> > @@ -2693,6 +2865,7 @@ workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
> >    int arg = 0;
> >    bool saw_greater_than_sign = false;
> >    bool saw_question_mark = false;
> > +  static bool in_pcon_start = false;
> >    for (DWORD i=0; i<rlen; i++)
> >      if (state == 0 && outbuf[i] == '\033')
> >        {
> > @@ -2774,8 +2947,21 @@ workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
> >  	    start_at = i;
> >  	    state = 1;
> >  	  }
> > +	else if (arg == 6 && outbuf[i] == 'n' && ttyp->pcon_start)
> > +	  {
> > +	    in_pcon_start = true;
> 
> Should this variable be reset in error paths below? This might be
> _particularly_ nasty to debug because `in_pcon_start` is `static` and will
> therefore persist indefinitely.

Do you mean in the else block:
    else
      { /* Never reached */
        is_csi = false;
        is_osc = false;
        saw_greater_than_sign = false;
        saw_question_mark = false;
        arg = 0;
        state = 0;
      }
?

Maybe. Added.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Wed__25_Mar_2026_21_41_09_+0900_rQ3rR2NKHdQWDWUZ
Content-Type: application/octet-stream;
 name="xtextattr1"
Content-Disposition: attachment;
 filename="xtextattr1"
Content-Transfer-Encoding: base64

G10xMDtncmVlbgcgZ3JlZW4gZm9yZWdyb3VuZAobWzFtIDE6IHRleHQgYm9sZCAbWzIybSAobm90
IHdoaXRlKQobWzJtIDI6IHRleHQgZGltIBtbMjJtChtbM20gMzogdGV4dCBpdGFsaWMgG1syM20K
G1s0OjNtIDQ6MzogdGV4dCBjdXJseSB1bmRlcmxpbmVkIBtbMjRtChtbNW0gNTogdGV4dCBibGlu
a2luZyAbWzI1bQobWzZtIDY6IHRleHQgYmxpbmtpbmcgcmFwaWRseRtbMjVtChtbNTNtIDUzOiB0
ZXh0IG92ZXJsaW5lZCAbWzU1bQobWzIxbSAyMTogdGV4dCBkb3VibHkgdW5kZXJsaW5lZCAbWzI0
bQobWzQ4OjQ6MTA6ODo0OjI6NW0gQ01ZSyBjb2xvdXIgG1swbQogVlQxMDAgZ3JhcGhpY3MgZW5h
YmxlZCBzaGlmdGVkIBspMA5hYmNkZWZnaGlqa2xtbm9wcXJzdHV2d3h5eg8bKUIK

--Multipart=_Wed__25_Mar_2026_21_41_09_+0900_rQ3rR2NKHdQWDWUZ--
