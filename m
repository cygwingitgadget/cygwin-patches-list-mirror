Return-Path: <SRS0=IKhM=TC=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:21])
	by sourceware.org (Postfix) with ESMTPS id 1CB683858D33
	for <cygwin-patches@cygwin.com>; Mon,  9 Dec 2024 13:44:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1CB683858D33
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1CB683858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733751845; cv=none;
	b=ri4F+fXXE1Wg9XfWp7LO3wQYOpiVzwQNlnKODlttb6sFh8rK2lRVylZC6RH2hRnyXNYhAXVEy7k540Au54xwZEidGOKz7EvAiV0v7fVO4QkEKXELiWZ4UhGJG4MWk2Jbp1HhLpb8WtkHDVMIlqhGYbLpjdVAiO38Bf7GuZoc9Bc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733751845; c=relaxed/simple;
	bh=UJrVQnYNXpczIM9Y1UV9ipfsbdvBq1ryQOvdUZoeeqg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=CxN9hBzbTSgtytrYNBjAXxIMNlMeDjQmNsLfspQd6MHYLE5PYuJidMlp1DCKtSxbWMk8mcKKRFbB/Whhn8e9hRQomnJyxfVZorchji/5KLrBr42y994PxXPCibclTA+M574rRNOe0v5Rf2ZsZj6zd84N0Sh5voifGABq69d86do=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1CB683858D33
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=TuSYiD4s
Received: from HP-Z230 by mta-snd-w01.mail.nifty.com with ESMTP
          id <20241209134401838.FYCT.19323.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 9 Dec 2024 22:44:01 +0900
Date: Mon, 9 Dec 2024 22:44:00 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: SMBFS mount's file cannot be made executable
Message-Id: <20241209224400.978983b35ac2b5e5ebc35ef2@nifty.ne.jp>
In-Reply-To: <Z1bQfIgv7MIDL1fB@calimero.vinschen.de>
References: <20241113181755.02289e8e8d9af7e19e8f4387@nifty.ne.jp>
	<CANV9t=SvYedzG-LmECwdT7kjipOyhgwsZ1yucnTm8mWMnNkJVw@mail.gmail.com>
	<20241114003740.e573d7ec79d35da76225c9f1@nifty.ne.jp>
	<CANV9t=TLh8xD7KBsF-MucZWNjP-L0KE04xUv2-2e=Z5fXTjk=w@mail.gmail.com>
	<20241114010807.99f46760b2240d472440c329@nifty.ne.jp>
	<20241116002122.3f4fd325a497eb4261ad80f4@nifty.ne.jp>
	<ZztqpBESgcTXcd3d@calimero.vinschen.de>
	<20241119175806.321cdb7e65a727a2eb58c8a6@nifty.ne.jp>
	<Zzz7FJim9kIiqjyy@calimero.vinschen.de>
	<20241208081338.e097563889a03619fc467930@nifty.ne.jp>
	<Z1bQfIgv7MIDL1fB@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733751841;
 bh=KSXaaiwSyG6SOZoMJWmn9M24l2agqOLdcERE1hPgoyc=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=TuSYiD4sj1YD2NHP1cfbrCk5DJkF6/MsT3Z4BkX5vnjJlbWVM2BoxPuaWoal8xx3YBfrnb5q
 omqCgioIWawpp8dvQhPW6gcNgy3Arftw2Ik7hzBaJ7Z6Cx4lxLubvj/OJUj5PNdNUgw/75cOXl
 U/Ok0vKZlWPxroYgUvvzRrUaw8jI6hwX51hfxT6VkP2TsXqYCz41OHjCAcZUy/plRV/vKsbhaj
 k6wlrZ+QFkcLO2AmBMMlaVvrbM5nn6sMPR4L6Q8Wpd1bTp4hsZLCpz6ufnMXXb6a2fy0A0CpZK
 0NDXq+eHxelSjCtEE62Tuxe6oLUQNjj4pRx2k5REYHBF1lAw==
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 9 Dec 2024 12:11:56 +0100
Corinna Vinschen wrote:
> On Dec  8 08:13, Takashi Yano via Cygwin wrote:
> > On Tue, 19 Nov 2024 21:54:44 +0100
> > Corinna Vinschen wrote:
> > > No, we can't do that, it's too simple.
> > > 
> > > Just kidding.
> > > 
> > > This is so simple, I'm puzzled we never tried that before.  Or, if we
> > > did, it's a loooong time ago...
> > > 
> > > If we really do this, we don't even need to call get_file_sd().  And it
> > > should use NtOpenFile and reopen semantics i.e.  pc.init_reopen_attr().
> > > Also, the sharing flags should allow all access.  And the `effective'
> > > argument needs to be taken into account.
> > 
> > I have a question. What pc.init_reopen_attr() is for? I tested with
> > pc.get_object_attr() instead, it works.
> 
> init_reopen_attr() uses the "open by handle" functionality as in the
> Win32 API ReOpenFile().  It only does so if the filesystem supports it.
> Samba usually does, so it's not clear to me why pc.init_reopen_attr()
> fails for you.

I didn't mean pc.init_reopen_attr() failed. Just I was no idea
for what handle to be passed.

> > What handle should I pass to pc.init_reopen_attr()?
> 
> You could pass pc.handle().  Is pc.handle() in this scenario NULL,
> perhaps?

I have tried pc.handle() and suceeded. Thanks for advice!

> > @@ -709,12 +615,44 @@ check_file_access (path_conv &pc, int flags, bool effective)
> >      desired |= FILE_WRITE_DATA;
> >    if (flags & X_OK)
> >      desired |= FILE_EXECUTE;
> > -  if (!get_file_sd (pc.handle (), pc, sd, false))
> > +
> > +  NTSTATUS status;
> > +  if (!effective && cygheap->user.issetuid ())
> > +    {
> > +      /* Strip impersonation token temporarily */
> > +      HANDLE tok = NO_IMPERSONATION;
> > +      status = NtSetInformationThread (GetCurrentThread (),
> > +				       ThreadImpersonationToken,
> > +				       &tok, sizeof (tok));
> > +      if (!NT_SUCCESS (status))
> > +	{
> > +	  debug_printf("NtSetInformationThread() for stripping "
> > +		       "impersonation token failed: %y", status);
> > +	  __seterrno_from_nt_status (status);
> > +	  return ret;
> > +	}
> > +    }
> 
> You can simplify this:
> 
> 	if (!effective)
> 	  cygheap->user.deimpersonate ();
>    
> > +  if (!effective && cygheap->user.issetuid ())
> > +    {
> > +      /* Recover impersonation token */
> > +      HANDLE tok = cygheap->user.imp_token () ?: hProcImpToken;
> > +      status = NtSetInformationThread (GetCurrentThread (),
> > +				       ThreadImpersonationToken,
> > +				       &tok, sizeof (tok));
> > +      if (!NT_SUCCESS (status))
> > +	debug_printf("NtSetInformationThread() for recovering "
> > +		     "impersonation token failed: %y", status);
> >      }
> 
> And this:
> 
> 	if (!effective)
> 	  cygheap->user.reimpersonate ();

This also works! Thank you very much!
I'll submit v2 patch to cygwin-patches@cygwin.com.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
