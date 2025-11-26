Return-Path: <SRS0=x/bO=6C=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w04.mail.nifty.com (mta-snd-w04.mail.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id 305E53858D32
	for <cygwin-patches@cygwin.com>; Wed, 26 Nov 2025 10:20:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 305E53858D32
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 305E53858D32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1764152452; cv=none;
	b=E1KGjOQi5LRH+MmpzE6C3ipkutPB1ULmSR/SWR59ftis8hoI6M/NaNbx45Hjbp0ogXXaEYUg9xr1xY0NwSaRrG9v3CxPReOpOQusMachmuVGlIuwTKayB5V2lmKhD0Z0UBJG3YDOjdO9PGAVfnA9/J2/MF3FBdTcWLnxXmRYLBs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1764152452; c=relaxed/simple;
	bh=pn94Tfkcdr3o/V9FPLjniBstn2W5waOnR+FjiaFCMAU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=hdzGCpUTL+Ga+9VwDVqCJu3gsY2YHySNeDIdu9bYW3jimQp1PUHiMkGjKk42luEfp8NjchwiOvixv9YBu269aBqXxsO+EdqLXeweE8ecDkEOYcDsETn/e9iW5gLGjDRhBxQyRbGRKsLXBtR/hO8mTRjy5u9pUrIFbCKjJLllJjY=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from HP-Z230 by mta-snd-w04.mail.nifty.com with ESMTP
          id <20251126102049951.KVSX.52630.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 26 Nov 2025 19:20:49 +0900
Date: Wed, 26 Nov 2025 19:20:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: flock: Do not access tmp_pathbuf already
 released
Message-Id: <20251126192049.d753ae73075c905340298e98@nifty.ne.jp>
In-Reply-To: <aSXCUNSuTyZ4jDBL@calimero.vinschen.de>
References: <20251124033047.2212-1-takashi.yano@nifty.ne.jp>
	<aSRKB6KpYHIViSD_@calimero.vinschen.de>
	<aSRY7wyUJFby7XHZ@calimero.vinschen.de>
	<20251124223546.9d3e2b5085fb2d71dca3479f@nifty.ne.jp>
	<20251124225933.b32dd342d5d0795dee496e8d@nifty.ne.jp>
	<20251124233114.0e3e1f3328ea3cbda7cf81d0@nifty.ne.jp>
	<aSSBUMJ8l3dYWR4T@calimero.vinschen.de>
	<20251125112948.0136d0bdd77aca512f9977d0@nifty.ne.jp>
	<aSWHH95BcSy6wHed@calimero.vinschen.de>
	<aSWTf6e9-tCKBVcT@calimero.vinschen.de>
	<aSXCUNSuTyZ4jDBL@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1764152450;
 bh=ujLEEoPRgAEGZL4yJgy/FFI6bjHx0tnL1CZDNHhEMf0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=YKmbQV68Of0t+T62DfAb4WU6M8W77O47GyQPOhPwJFQz7ceALbMLhMd0Sqgc+u7/piAld2m2
 Jq8fIWvDKLTJ5f2+JXhQrivhPmXjth3PqPvASHgpozTIf8zXOIYDs2cVY5IQ0g7jlt4AEOlKNH
 yqu/LFQlA0dY8DjLsUJp/L8xB79fjPvfjm+35xQtHmtdwRWrQR785KmO+PSTxTVq2LcrMpx/Va
 NIRih6sdft6zIcrUWq+jYcb0VlXF9PbKJ3Fz26EyzOaFcQm2FquUVd4jKJJLNQtwyNlH577zzC
 eDETFurjKpDA9RXLn0VYw75df/hndbfDGfa/oZboUc1Jh8gQ==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Tue, 25 Nov 2025 15:50:56 +0100
Corinna Vinschen wrote:
> On Nov 25 12:31, Corinna Vinschen wrote:
> > A short addendum:
> > 
> > On Nov 25 11:38, Corinna Vinschen wrote:
> > > That means:
> > > 
> > > - i_all_lf as array incures extra cost only at fork/execve time by
> > >   having to copy additional 64K over to the child process.
> > 
> >     If we count the cygheap copy here, we also have to count the
> >     mallocs in the other two cases...
> > > 
> > > - i_all_lf as malloced pointer in inode_t incures extra cost once
> > >   per created inode (malloc), once per execve (malloc), once per
> > >   deleted inode (free).
> > 
> >     Plus an extra 64K user heap copy at fork(2) time.
> > 
> > > - i_all_lf as local variable incures extra cost once per thread
> > >   (malloc), per process, under ideal conditions. 
> > 
> >     Plus an extra 64K user heap copy at fork(2) time.
> 
> I just had a bit of time so I prepared a v4.  Can you please check if
> this is ok?

Thanks! Looks good to me. I also confirmed the original test case
from Nahor works fine with this patch. In addition,
stress-ng --flock 20 -t 10
and
stress-ng --lockf 20 -t 10
pass.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
