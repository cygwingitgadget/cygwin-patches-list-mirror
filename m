Return-Path: <SRS0=U53b=TD=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 243033858423
	for <cygwin-patches@cygwin.com>; Tue, 10 Dec 2024 13:34:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 243033858423
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 243033858423
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733837641; cv=none;
	b=sVCoeC6jNbj6xhOBuruval0j444WgdcGw9IMAQ5x/3/Fzygwd0Op61D3+kfeXo7EqIdzo6kFhLvoTCytYD1iZVlfg1jzSsHQIzpa8AthI3/+sCrXsPjLinYXJypIAKo4bCe9D2O+jUfaeRqMhzETrY8FdWzKu6030FZzeJRMlOI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733837641; c=relaxed/simple;
	bh=slP4//Q0IAeauZ3oeL1mkhEmTbiYtiPeFFZ6j6y7gQo=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=vCFBEeKaBVXV/1ozgg36fm5cIFSV/EpjU4f33vOd7ha6Egz6XnNMtC9G9TEiecl78aGg7kW/NEKULrV+Qf9F3TFsfT4VDMAhf6aSUswOJys9a/OmVn9y/7/gonrU/qSuymtTOjLjnmi2wFDtpfUwTBIfRkp/VxhZhd/14kULrUM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 243033858423
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ph1Gip1D
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20241210133359415.MFKN.84910.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 10 Dec 2024 22:33:59 +0900
Date: Tue, 10 Dec 2024 22:33:58 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: SMBFS mount's file cannot be made executable
Message-Id: <20241210223358.7757b61d93bdbbe3cfc11fb2@nifty.ne.jp>
In-Reply-To: <Z1hA2KFehQjXi3Wp@calimero.vinschen.de>
References: <20241119175806.321cdb7e65a727a2eb58c8a6@nifty.ne.jp>
	<Zzz7FJim9kIiqjyy@calimero.vinschen.de>
	<20241208081338.e097563889a03619fc467930@nifty.ne.jp>
	<Z1bQfIgv7MIDL1fB@calimero.vinschen.de>
	<20241209224400.978983b35ac2b5e5ebc35ef2@nifty.ne.jp>
	<20241209225759.9c71db3a2dcbafe0b4769a7b@nifty.ne.jp>
	<Z1cMPRDvfIqZAsL3@calimero.vinschen.de>
	<20241210212140.dcdaec01428393465929dc59@nifty.ne.jp>
	<Z1g7hVhAbbfnnmR5@calimero.vinschen.de>
	<20241210221057.6e9edf37a27b8fc2777bc9e4@nifty.ne.jp>
	<Z1hA2KFehQjXi3Wp@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733837639;
 bh=QEa9Yp6jByY/7u/p/hTwWE8JmW3vV/BCjOSr8+vEO5U=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=ph1Gip1DQcym0A5xWOyfsR33ASKq2rqGgBwzSivMU4DTmGU5JU4lUTFAT8JNdqdJryzbVLMK
 Kv0rLDCGXr/U88yy/EYvOl6GM6+v29n8IJiweBTJUcVpNT54BvI8+WyxHfqi3rK83FooHr2sXW
 NNfs1fvcmTSR/4di0SQfbZgAzyO02zMTZTOJAlIIYsBrcu1FRRqutB3p2TSWvQCzRWZUmaXCOh
 CXRtVVsBGpq43s3ODTImVRlSYWtK/bMCp8kMx4TW0rnqKlwJhoyng3mdB6Q7MhWame74WS+aDg
 tl/2/8cWS709AVWm3j78Pb6pjM0CB7ZI6360gC3gdidmzvsQ==
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 10 Dec 2024 14:23:36 +0100
Corinna Vinschen wrote:
> On Dec 10 22:10, Takashi Yano wrote:
> > On Tue, 10 Dec 2024 14:00:53 +0100
> > Corinna Vinschen wrote:
> > > diff --git a/winsup/cygwin/local_includes/path.h b/winsup/cygwin/local_includes/path.h
> > > index 3dd21d975abf..2a05cf44d40a 100644
> > > --- a/winsup/cygwin/local_includes/path.h
> > > +++ b/winsup/cygwin/local_includes/path.h
> > > @@ -323,7 +323,7 @@ class path_conv
> > >    }
> > >    inline POBJECT_ATTRIBUTES init_reopen_attr (OBJECT_ATTRIBUTES &attr, HANDLE h)
> > >    {
> > > -    if (has_buggy_reopen ())
> > > +    if (!h || has_buggy_reopen ())
> > >        InitializeObjectAttributes (&attr, get_nt_native_path (),
> > >  				  objcaseinsensitive (), NULL, NULL)
> > >      else
> > > -- 
> > > 2.47.0
> > > 
> > 
> > Thanks! Is your patch better than?
> > +  if (pc.handle ())
> > +    pc.init_reopen_attr (attr, pc.handle ());
> > +  else
> > +    pc.get_object_attr (attr, sec_none_nih);
> 
> Well, it fixes the problem once and for all, without having to
> add a conditional in multiple places.

Ok. Then, the similar code at:
sec/base.cc:61
sec/base.cc:231
can be simplified with your patch. Right?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
