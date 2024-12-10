Return-Path: <SRS0=U53b=TD=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e03.mail.nifty.com (mta-snd-e03.mail.nifty.com [106.153.226.35])
	by sourceware.org (Postfix) with ESMTPS id 68B87385828B
	for <cygwin-patches@cygwin.com>; Tue, 10 Dec 2024 13:11:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 68B87385828B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 68B87385828B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733836260; cv=none;
	b=fp6o1eMhETBfZwGDcRkbClvHmNIK/5ByhTTYRAtQZ/rJeajk+kNs57evNVwkSnJn8Tjm7YmVUOJCMWKrfv/5x+izVXWjW2Eu1HdYUvlMcPB7rrpl7gYeR+bCQlQyldM+uAVXUH6RM5K4zbUMMRBM+toCiYmDpL7a3tuthihX9Ms=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733836260; c=relaxed/simple;
	bh=StA9c834QIwDM+NNkn+AgUpFUtzmfIXDKMqyIibivnE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=qMIUVil4119IA0X0pGc2QyMdxWZcKftbqNqaJBs/9DmqS5uh+dhC2yi9uGtcuuGj1xfjxIV7QY9s8f+2Z0RhVyQIbl9/7L4C3wCdCo6coVxSStH88HCpd1Eu+tkQ27QKEE4ls0D6bk7n3Gjg0JRNMwVAgEr8juyxqASq0zHU0pY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 68B87385828B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=XOb2G9pL
Received: from HP-Z230 by mta-snd-e03.mail.nifty.com with ESMTP
          id <20241210131058498.VZRN.40277.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 10 Dec 2024 22:10:58 +0900
Date: Tue, 10 Dec 2024 22:10:57 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: SMBFS mount's file cannot be made executable
Message-Id: <20241210221057.6e9edf37a27b8fc2777bc9e4@nifty.ne.jp>
In-Reply-To: <Z1g7hVhAbbfnnmR5@calimero.vinschen.de>
References: <20241116002122.3f4fd325a497eb4261ad80f4@nifty.ne.jp>
	<ZztqpBESgcTXcd3d@calimero.vinschen.de>
	<20241119175806.321cdb7e65a727a2eb58c8a6@nifty.ne.jp>
	<Zzz7FJim9kIiqjyy@calimero.vinschen.de>
	<20241208081338.e097563889a03619fc467930@nifty.ne.jp>
	<Z1bQfIgv7MIDL1fB@calimero.vinschen.de>
	<20241209224400.978983b35ac2b5e5ebc35ef2@nifty.ne.jp>
	<20241209225759.9c71db3a2dcbafe0b4769a7b@nifty.ne.jp>
	<Z1cMPRDvfIqZAsL3@calimero.vinschen.de>
	<20241210212140.dcdaec01428393465929dc59@nifty.ne.jp>
	<Z1g7hVhAbbfnnmR5@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733836258;
 bh=F8wM8Eskqy/nsE41hvJE762MdjiKf6Sg42EonROiw/c=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=XOb2G9pLNxW011LvWwNuSyzdXyIeL0c1yEwmTDvSO+pzbKRCD73QyJKpxjUl6jjuFa5qw1ZM
 BIU4wkro6LGZE8mzt1JCGcRb7BbepLertgUzqA4JPQ2ul/cYliqsOhskg8usVIwvX1Vbkz2j1E
 OWdCjT/D++iaJ6UESIp3Ro3SPSSmIgLL0K0E0+Tegf7xTD4VMk+S7KtRqEeDCuwyiU0Ml5UWvY
 HPvhlMjvwh7wn1vA0wg8hJ1x86wwWM95B4yLVf2Icgd61+xB4JCq1qXqn7ESbRngFwnC+HJho4
 PWR4uNdZaQMmKaooXCozIX83ERV1jHgUOIh7RqMeUk7yGLDg==
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 10 Dec 2024 14:00:53 +0100
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Dec 10 21:21, Takashi Yano wrote:
> > Hi Corinna,
> > 
> > On Mon, 9 Dec 2024 16:26:53 +0100
> > Corinna Vinschen wrote:
> > > On Dec  9 22:57, Takashi Yano wrote:
> > > > On Mon, 9 Dec 2024 22:44:00 +0900
> > > > Takashi Yano wrote:
> > > > > On Mon, 9 Dec 2024 12:11:56 +0100
> > > > > Corinna Vinschen wrote:
> > > > > > init_reopen_attr() uses the "open by handle" functionality as in the
> > > > > > Win32 API ReOpenFile().  It only does so if the filesystem supports it.
> > > > > > Samba usually does, so it's not clear to me why pc.init_reopen_attr()
> > > > > > fails for you.
> > > > > 
> > > > > I didn't mean pc.init_reopen_attr() failed. Just I was no idea
> > > > > for what handle to be passed.
> > > > > 
> > > > > > > What handle should I pass to pc.init_reopen_attr()?
> > > > > > 
> > > > > > You could pass pc.handle().  Is pc.handle() in this scenario NULL,
> > > > > > perhaps?
> > > > > 
> > > > > I have tried pc.handle() and suceeded. Thanks for advice!
> > > > 
> > > > No! pc.handle() sometimes seems to be NULL....
> > > 
> > > Can you please figure out in which scenario it's NULL?  Theoretically
> > > the function shouldn't even be called in this case.
> > 
> > This seems to happen when check_file_access() is called from av::setup()
> > (spawn.cc:1237) called from child_info_spawn::worker() (spawn.cc:358).
> 
> Huh, yeah, thanks for tracking this down.  And this code snippet is
> actually only called if we *failed* opening the file, so there's no
> usable handle.
> 
> Try this:
> 
> 
> From 23387c343381ba01d02210257e33cf2691611c2d Mon Sep 17 00:00:00 2001
> From: Corinna Vinschen <corinna@vinschen.de>
> Date: Tue, 10 Dec 2024 13:55:54 +0100
> Subject: [PATCH] Cygwin: path_conv: allow NULL handle in init_reopen_attr()
> 
> init_reopen_attr() doesn't guard against a NULL handle.  However,
> there are scenarios calling functions deliberately with a NULL handle,
> for instance, av::setup() calling check_file_access() only if opening
> the file did NOT succeed.
> 
> So check for a NULL handle in init_reopen_attr() and if so, use the
> name based approach filling the OBJECT_ATTRIBUTES struct, just as in
> the has_buggy_reopen() case.
> 
> Fixes: 4c9d01fdad2a ("* mount.h (class fs_info): Add has_buggy_reopen flag and accessor methods.")
> Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> ---
>  winsup/cygwin/local_includes/path.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/local_includes/path.h b/winsup/cygwin/local_includes/path.h
> index 3dd21d975abf..2a05cf44d40a 100644
> --- a/winsup/cygwin/local_includes/path.h
> +++ b/winsup/cygwin/local_includes/path.h
> @@ -323,7 +323,7 @@ class path_conv
>    }
>    inline POBJECT_ATTRIBUTES init_reopen_attr (OBJECT_ATTRIBUTES &attr, HANDLE h)
>    {
> -    if (has_buggy_reopen ())
> +    if (!h || has_buggy_reopen ())
>        InitializeObjectAttributes (&attr, get_nt_native_path (),
>  				  objcaseinsensitive (), NULL, NULL)
>      else
> -- 
> 2.47.0
> 

Thanks! Is your patch better than?
+  if (pc.handle ())
+    pc.init_reopen_attr (attr, pc.handle ());
+  else
+    pc.get_object_attr (attr, sec_none_nih);
-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
