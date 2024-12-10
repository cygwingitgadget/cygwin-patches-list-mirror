Return-Path: <SRS0=U53b=TD=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id DFF493858428
	for <cygwin-patches@cygwin.com>; Tue, 10 Dec 2024 13:30:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DFF493858428
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DFF493858428
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733837436; cv=none;
	b=cXMd8ATiItNoTtGAr5nGm3CedSthHNOU+5QYRScCoeUEgdycj7V+JAxGMG8XTy+HUCQZUu0QkfQIBdTC6k9GRMnUl1k+dHZ8k1TMDzN1i34k0ffCftFk+cG5oXh5AZfWHDNv9cDdzl3Z09tdoMs8IOooXTZQy7G1LZtW5/O+n9w=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733837436; c=relaxed/simple;
	bh=2iOsLbPUj+JAkroN7o7MZLUKd551yfV1l5OIp9yvwwo=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=PHUDYKraXg9VRpPIoI7VEvV+cI/4dnt7wKF4nmq2PCRR61+FhPNYO2/cKF/d9pSYN4Qtt5oorFDVLGBwP/zJ3pyadT7srHvNqL8P3gLhPKutsuJraG47aTOTMvn/fidAAMp89yHk/0ZAYYX22kkKk7FGXCeFFnzVsm7INg/WrEw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DFF493858428
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=q7LUXTyo
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20241210133033287.HLIB.107569.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 10 Dec 2024 22:30:33 +0900
Date: Tue, 10 Dec 2024 22:30:32 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: SMBFS mount's file cannot be made executable
Message-Id: <20241210223032.77185e2abddeec1ab41b1fb3@nifty.ne.jp>
In-Reply-To: <20241210221057.6e9edf37a27b8fc2777bc9e4@nifty.ne.jp>
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
	<20241210221057.6e9edf37a27b8fc2777bc9e4@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733837433;
 bh=2o1+5GDgveiN8cDSTJVRDZ0jTQahrZfsEwYpI1synYc=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=q7LUXTyoIEQBIqz1cytoNWubZq1LtBdRVAWmlWE3uXk6uZZwGqZFV5TU8vVeowiZSuQRLA1X
 2Hvg6kIBJEoCovNyC0MTJbbhAHtwoYtiGs113CA5slHA9qQneinSSv+g4INWasXqP4LHiARXr/
 cU4ahqIvm6zyUT/WG3zRoi1vuqSsaXT40ea5F2GV0oHV8CllM8ABGAtMvK2JKkS7JyA9f2OEQ3
 ZdWTzn290Q169voCtf88wReYfT8QAwfgFNIEaw+xkyG1g5q6I8dfb/PsIBiV6eoElWP3D6qyyX
 zl07dIQqwtbdsZ/CEpIEucI0cLQNbbp/jVgcW+qoQdDtmCYg==
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Tue, 10 Dec 2024 22:10:57 +0900
Takashi Yano wrote:
> On Tue, 10 Dec 2024 14:00:53 +0100
> Corinna Vinschen wrote:
> > Hi Takashi,
> > 
> > On Dec 10 21:21, Takashi Yano wrote:
> > > Hi Corinna,
> > > 
> > > On Mon, 9 Dec 2024 16:26:53 +0100
> > > Corinna Vinschen wrote:
> > > > On Dec  9 22:57, Takashi Yano wrote:
> > > > > On Mon, 9 Dec 2024 22:44:00 +0900
> > > > > Takashi Yano wrote:
> > > > > > On Mon, 9 Dec 2024 12:11:56 +0100
> > > > > > Corinna Vinschen wrote:
> > > > > > > init_reopen_attr() uses the "open by handle" functionality as in the
> > > > > > > Win32 API ReOpenFile().  It only does so if the filesystem supports it.
> > > > > > > Samba usually does, so it's not clear to me why pc.init_reopen_attr()
> > > > > > > fails for you.
> > > > > > 
> > > > > > I didn't mean pc.init_reopen_attr() failed. Just I was no idea
> > > > > > for what handle to be passed.
> > > > > > 
> > > > > > > > What handle should I pass to pc.init_reopen_attr()?
> > > > > > > 
> > > > > > > You could pass pc.handle().  Is pc.handle() in this scenario NULL,
> > > > > > > perhaps?
> > > > > > 
> > > > > > I have tried pc.handle() and suceeded. Thanks for advice!
> > > > > 
> > > > > No! pc.handle() sometimes seems to be NULL....
> > > > 
> > > > Can you please figure out in which scenario it's NULL?  Theoretically
> > > > the function shouldn't even be called in this case.
> > > 
> > > This seems to happen when check_file_access() is called from av::setup()
> > > (spawn.cc:1237) called from child_info_spawn::worker() (spawn.cc:358).
> > 
> > Huh, yeah, thanks for tracking this down.  And this code snippet is
> > actually only called if we *failed* opening the file, so there's no
> > usable handle.
> > 
> > Try this:
> > 
> > 
> > From 23387c343381ba01d02210257e33cf2691611c2d Mon Sep 17 00:00:00 2001
> > From: Corinna Vinschen <corinna@vinschen.de>
> > Date: Tue, 10 Dec 2024 13:55:54 +0100
> > Subject: [PATCH] Cygwin: path_conv: allow NULL handle in init_reopen_attr()
> > 
> > init_reopen_attr() doesn't guard against a NULL handle.  However,
> > there are scenarios calling functions deliberately with a NULL handle,
> > for instance, av::setup() calling check_file_access() only if opening
> > the file did NOT succeed.
> > 
> > So check for a NULL handle in init_reopen_attr() and if so, use the
> > name based approach filling the OBJECT_ATTRIBUTES struct, just as in
> > the has_buggy_reopen() case.
> > 
> > Fixes: 4c9d01fdad2a ("* mount.h (class fs_info): Add has_buggy_reopen flag and accessor methods.")
> > Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> > ---
> >  winsup/cygwin/local_includes/path.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/local_includes/path.h b/winsup/cygwin/local_includes/path.h
> > index 3dd21d975abf..2a05cf44d40a 100644
> > --- a/winsup/cygwin/local_includes/path.h
> > +++ b/winsup/cygwin/local_includes/path.h
> > @@ -323,7 +323,7 @@ class path_conv
> >    }
> >    inline POBJECT_ATTRIBUTES init_reopen_attr (OBJECT_ATTRIBUTES &attr, HANDLE h)
> >    {
> > -    if (has_buggy_reopen ())
> > +    if (!h || has_buggy_reopen ())
> >        InitializeObjectAttributes (&attr, get_nt_native_path (),
> >  				  objcaseinsensitive (), NULL, NULL)
> >      else
> > -- 
> > 2.47.0
> > 
> 
> Thanks! Is your patch better than?
> +  if (pc.handle ())
> +    pc.init_reopen_attr (attr, pc.handle ());
> +  else
> +    pc.get_object_attr (attr, sec_none_nih);

I confirmed that both above two patches work.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
