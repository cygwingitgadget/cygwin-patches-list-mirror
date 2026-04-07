Return-Path: <SRS0=Vzu2=CG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 135E04BA2E1B
	for <cygwin-patches@cygwin.com>; Tue,  7 Apr 2026 00:05:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 135E04BA2E1B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 135E04BA2E1B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1775520343; cv=none;
	b=OJaSZpBudMSYWyQEyZRO0+xleEpr81zrLbLZW/TlL3HZo7MFgG8Hha2enEl0W6POXU6l9JALfi2+HekIS9dbbTXieqcq4HsoCuOq6pcChkhVoL9oCGz8AUcV2DIoZ4uyjts/F9nudFmSF4c3SlITR6xeechNLfx7zQgAeAATwuo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775520343; c=relaxed/simple;
	bh=AL1srZMx7GWSrXKPKe0u/PnegINl3nGSeufonU2nUOM=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=GTY+T8b9CyR4ecQKYd/P0ZKcyYvVfGtf9bHV4aOoZlssu0yROikq2A93OQV+USpqI1mRyJMcOztHmOSbO9GNJJTZf7lyNUf30gEnxOcSbEfdsdyhzX62A4Wl+sWvq+A3gQQ65Suu9kOczgqEnbIkIbSlXgjUFzjpQn0EOx6Vx5Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 135E04BA2E1B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ozdtlsoy
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260407000539108.FMDG.36235.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 7 Apr 2026 09:05:39 +0900
Date: Tue, 7 Apr 2026 09:05:38 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 1/3] Cygwin: pty: Use OpenConsole.exe if available
Message-Id: <20260407090538.6d2b4f72ed8883509df496db@nifty.ne.jp>
In-Reply-To: <59d4e265-6cab-a701-2c58-ce03b88fd5ed@gmx.de>
References: <20260312113923.1528-1-takashi.yano@nifty.ne.jp>
	<20260312113923.1528-2-takashi.yano@nifty.ne.jp>
	<90f23c8e-cb9c-ad64-8c22-2f5cb3a535e3@gmx.de>
	<20260325214109.eda376ea321601393aa2a13e@nifty.ne.jp>
	<59d4e265-6cab-a701-2c58-ce03b88fd5ed@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1775520339;
 bh=uFoXUfjoABL1SJWudkxcxCMg7kBtwQWyYP+agoR4pxI=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=ozdtlsoys1u6hx3F6h6DnDXTTE6cn8lMN9lm6UxItnf8pOGy1PdLxr4URdxsQDPFQoBtXEnb
 sCeM24V1aDvTYFE4Ksrm94UHlK/A0rCQ9SUchozObs+Cb/pdbDk1+G7j98qcust/eizTrvBoQ2
 IclZhm5tzwYWg4nmJd7zc8kUdgJ8vJc44aLEsPTp0dbKTBI6Xw7MLOtKjJ8snukzz/G2gtmZP4
 K09ibH3vI9QybhKmynDZkJnry2m/3XR5UAOLrArNJwPpIS8NhdjZ60G8of6gK8uT1LidOdeutv
 fQ3P+UI1lbu592+rsOOyizFdSyUHhgInOq9eY0XE8A27IROQ==
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 6 Apr 2026 10:36:19 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> Thank you for v6. I verified that it addresses the majority of the
> review comments from v5: the typo, the opt-out mechanism
> (`CYGWIN=use_legacy_pcon`), the CSIc separation, the `extern "C"`
> export, the `h_read_pipe` leak, the thread-safety concern (which you
> rightly noted also affects the existing pseudo console code), and the
> `in_pcon_start` reset. I appreciate the thorough follow-up.
> 
> Two small items remain, neither of which I consider blockers:
> 
> On Mon, 6 Apr 2026, Takashi Yano wrote:
> 
> > Johannes Schindelin wrote:
> > > 
> > > On Thu, 12 Mar 2026, Takashi Yano wrote:
> > > 
> > > > This patch replaces legacy conhost.exe with OpenConsole.exe if
> > > > it is available. This enables various new features such as mouse
> > > > support in pseudo console and bug fixes. The legacy conhost has
> > > > problems, e.g. character attributes are mangled or ignored, and
> > > > terminal reports are not passed through. This patch resolve the
> > > > issue by loading /usr/bin/OpenColnsole.exe instead of conhost.exe
> > > 
> > > I know that Corinna cares about typos in commit messages, so I'd like to
> > > point out that "OpenColnsole" has an extra "l" in it.
> > > 
> > > > if it is available.
> > > 
> > > My biggest issue with this patch: There is no opt-out mechanism: No
> > > CYGWIN=disable_openconsole or MSYS=disable_openconsole flag. If
> > > /usr/bin/OpenConsole.exe exists and is buggy, or this here patch, the user
> > > is stuck.
> > 
> > Thnaks. I'll add CYGWIN=use_lagacy_pcon option.
> 
> Thank you!
> 
> > > > +
> > > > +  HANDLE h_con_server, h_con_reference;
> > > > +  NTSTATUS status;
> > > > +  BOOL res;
> > > > +  HANDLE h_read_pipe, h_write_pipe;
> > > > +  BOOL inherit_cursor;
> > > > +  path_conv conhost ("/usr/bin/OpenConsole.exe");
> > > 
> > > Is it really a good idea to hard-code that path? That would not only
> > > preclude an `OpenConsole.exe` that is in the `PATH` to be used, it also
> > > suggests that you plan on building a Cygwin version of that executable
> > > (because that location should only contain native Cygwin applications and
> > > DLLs).
> > 
> > I imagine we would have openconsole cygwin package which install
> > OpenConsole.exe into /usr/bin/.
> 
> That makes sense as a packaging plan. My remaining concern is purely about
> maintainability: the path is a string literal buried in the function body.
> I would suggest defining a named constant for it (near the existing
> `"/bin/cygwin-console-helper.exe"` literal, or at file scope) so that the
> path is easy to find and change in one place.
> 
> > 
> > > > +  InitializeProcThreadAttributeList (NULL, 1, 0, &list_size);
> > > 
> > > This requires a corresponding `DeleteProcThreadAttributeList()` call.
> > 
> > This call is for retrieving list_size. Nothing is allocated with this call.
> 
> Agreed, the first call with `NULL` is purely for size discovery and needs
> no cleanup. My concern was actually about the _second_ call,
> `InitializeProcThreadAttributeList(si.lpAttributeList, ...)`, which does
> initialize the buffer, sorry for quoting the wrong call. Per MSDN, that
> requires a matching `DeleteProcThreadAttributeList()` before `HeapFree()`:

Ah, indeed. Thanks for pointing this out. Fixed.

> The existing code in `setup_pseudoconsole()` gets this right in the
> success path but actually has the same gap in its `cleanup_heap` error
> path. Could you add the `DeleteProcThreadAttributeList()` call in the
> error cleanup path of your new `CreatePseudoConsole_new()` as well? And if
> you feel like fixing the pre-existing gap in `setup_pseudoconsole()` too,
> all the better. :-)

I'll submit another patch to add DeleteProcThreadAttributeList()
in cleanup path of setup_?pseudoconsole(). Thanks!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
