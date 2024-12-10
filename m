Return-Path: <SRS0=U53b=TD=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e08.mail.nifty.com (mta-snd-e08.mail.nifty.com [106.153.226.40])
	by sourceware.org (Postfix) with ESMTPS id D34ED3858D33
	for <cygwin-patches@cygwin.com>; Tue, 10 Dec 2024 12:21:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D34ED3858D33
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D34ED3858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733833304; cv=none;
	b=mFvXZoGQ1YPp2qYgHJlbYXXSlJGTaegtZ5f2pdO9x9Q4X1USoBL9IrYafL+IYXEOps26g4tgm+raYrMOFtG7aIpIhNQec2DESLU2aIJdlXDSTdQr/BpepW4htJ9EcLX+lVjdT2dzEuwIus/mfW69Z6T0udoNgBmNOEVz2Nm9NVE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733833304; c=relaxed/simple;
	bh=p/FhnbdDludq2C9jLWPBKISxDCUARPtd/ojEvzt6sP0=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=YfFb1UQ7yQREk6t+SpobSTNHzvvjs62WvOjw+CllzWF5prGiBMxMq37RtfHT/JQ8spUJYaYdxFZ/jnC71Pb8BJGnPHmIzunjK3O4Vc5yMhTY2ygPltFhCp4BmYKdKz2hirrDwfPVVh+UpLsxuZRkI5l37Po0XqCd2jqnoFwiHnI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D34ED3858D33
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=BBxDsdCx
Received: from HP-Z230 by mta-snd-e08.mail.nifty.com with ESMTP
          id <20241210122141657.TZQO.11752.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 10 Dec 2024 21:21:41 +0900
Date: Tue, 10 Dec 2024 21:21:40 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: SMBFS mount's file cannot be made executable
Message-Id: <20241210212140.dcdaec01428393465929dc59@nifty.ne.jp>
In-Reply-To: <Z1cMPRDvfIqZAsL3@calimero.vinschen.de>
References: <CANV9t=TLh8xD7KBsF-MucZWNjP-L0KE04xUv2-2e=Z5fXTjk=w@mail.gmail.com>
	<20241114010807.99f46760b2240d472440c329@nifty.ne.jp>
	<20241116002122.3f4fd325a497eb4261ad80f4@nifty.ne.jp>
	<ZztqpBESgcTXcd3d@calimero.vinschen.de>
	<20241119175806.321cdb7e65a727a2eb58c8a6@nifty.ne.jp>
	<Zzz7FJim9kIiqjyy@calimero.vinschen.de>
	<20241208081338.e097563889a03619fc467930@nifty.ne.jp>
	<Z1bQfIgv7MIDL1fB@calimero.vinschen.de>
	<20241209224400.978983b35ac2b5e5ebc35ef2@nifty.ne.jp>
	<20241209225759.9c71db3a2dcbafe0b4769a7b@nifty.ne.jp>
	<Z1cMPRDvfIqZAsL3@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733833301;
 bh=FUTAbAoOk+G2Mq+6xJVYa0wDRnV0dxL7RfMri6LSgkw=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=BBxDsdCxQPvbGkNZAol7iLfRkg0IJ3WZNRWG3xp9F8Zap4DEQRaZ1gAp4QqBirUO2sy58cxQ
 SudqcWczoGlutWUYJQSZ8LwCLRbIb4uvthghzG2LKqvxnNLcQAyPbF3CG6SUug2gVyB8iY0IO6
 ajZDXebMCiKxO5LB3eQp0NqSWxn030OAMfsxm2Ok4nppKpycy2Rj2Y5h2PgUi3QbHMiCE+LbH5
 0B6XmnSIPsNsuEMlTjVgS2q49+NohJCJ9Ed6hLmp5epqkoUCPs5hijqbA/TXgHtOtI/DkMv1iP
 ROwPF0YkGvBK5jNNgr0jmB35JXf7eIeb2kTu081IVsMhbBRw==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 9 Dec 2024 16:26:53 +0100
Corinna Vinschen wrote:
> On Dec  9 22:57, Takashi Yano wrote:
> > On Mon, 9 Dec 2024 22:44:00 +0900
> > Takashi Yano wrote:
> > > On Mon, 9 Dec 2024 12:11:56 +0100
> > > Corinna Vinschen wrote:
> > > > init_reopen_attr() uses the "open by handle" functionality as in the
> > > > Win32 API ReOpenFile().  It only does so if the filesystem supports it.
> > > > Samba usually does, so it's not clear to me why pc.init_reopen_attr()
> > > > fails for you.
> > > 
> > > I didn't mean pc.init_reopen_attr() failed. Just I was no idea
> > > for what handle to be passed.
> > > 
> > > > > What handle should I pass to pc.init_reopen_attr()?
> > > > 
> > > > You could pass pc.handle().  Is pc.handle() in this scenario NULL,
> > > > perhaps?
> > > 
> > > I have tried pc.handle() and suceeded. Thanks for advice!
> > 
> > No! pc.handle() sometimes seems to be NULL....
> 
> Can you please figure out in which scenario it's NULL?  Theoretically
> the function shouldn't even be called in this case.

This seems to happen when check_file_access() is called from av::setup()
(spawn.cc:1237) called from child_info_spawn::worker() (spawn.cc:358).

There are two other check_file_access() in spawn.cc (L156, L1132), but
I don't confirm them if they are the same.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
