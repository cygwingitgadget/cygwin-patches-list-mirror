Return-Path: <SRS0=x/bO=6C=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 520C13858D1E
	for <cygwin-patches@cygwin.com>; Wed, 26 Nov 2025 12:51:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 520C13858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 520C13858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1764161505; cv=none;
	b=IaKQLbVWOGfo+Pl4Z9XNkYaV3TPTop7JML4Na/O/U5BEHfJ19Y/LJWP3KDGeUAYPSm7RVeuHGG1VUgCl1Q5ZTYlBjyp4LY8JR9AOCCFTGlTAzJJ7ypv+8fneTHELn5C0jMGmWjiCXD5H8mwdnTpyYTPSQokqslf6v2eKi4pn7G0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1764161505; c=relaxed/simple;
	bh=yHMVqyqUiXpUJNyeKaF3h8RcUKn0ifKctSgwzqrE3W8=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Vt8M5Q5bPR6Jf1eJBM8L1WbZL9YGWbXozW3KpKOzgdAXz2I5cR4Kspf7mxCJZDqV4VnQyUkRAO2hIKhMHx7KRRzlGzNilAeodxM7NPrDBSsMkT3wa7/LABKVfPR9LahHE+GEkizsW8Ou85eB+QbFzz4rgoo+uKiaDdjCBKpMfFE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 520C13858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lArhUPeS
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20251126125142094.ZENV.116672.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 26 Nov 2025 21:51:42 +0900
Date: Wed, 26 Nov 2025 21:51:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: flock: Do not access tmp_pathbuf already
 released
Message-Id: <20251126215141.fa45bb6ad857befc2070484c@nifty.ne.jp>
In-Reply-To: <aSbqtZ1MQeKWfi4A@calimero.vinschen.de>
References: <aSRY7wyUJFby7XHZ@calimero.vinschen.de>
	<20251124223546.9d3e2b5085fb2d71dca3479f@nifty.ne.jp>
	<20251124225933.b32dd342d5d0795dee496e8d@nifty.ne.jp>
	<20251124233114.0e3e1f3328ea3cbda7cf81d0@nifty.ne.jp>
	<aSSBUMJ8l3dYWR4T@calimero.vinschen.de>
	<20251125112948.0136d0bdd77aca512f9977d0@nifty.ne.jp>
	<aSWHH95BcSy6wHed@calimero.vinschen.de>
	<aSWTf6e9-tCKBVcT@calimero.vinschen.de>
	<aSXCUNSuTyZ4jDBL@calimero.vinschen.de>
	<20251126192049.d753ae73075c905340298e98@nifty.ne.jp>
	<aSbqtZ1MQeKWfi4A@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1764161502;
 bh=WeeyYXzbfrx3sB16TY9TmUw2lmVeA6YAfvUQ7wi5fc8=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=lArhUPeSfySOS3ww41wGAoVksB3vSWLooE/XIMgYg3v11ukHBLjhvq+ywK23daJI9NeKEDlu
 t4mZ5nG64s8JFbYjhCbtTOakyOC6vAkDNt3R3JlPQ+XgL0UCnhvB/2rFOl8kukT6MHPaGtQqp7
 D2TkwtVdsDFU0WQdr2maacpHZ3ujpfFzaVGZdULyVl6Xk5c3xk419bVW+m5sz3M6hMupTqA4RL
 P4zPTTLmgemK6GfLzIA2n/qREqlVOMapELTAgF1Wx1ZmM8ynaJgJoH3QRzY25GQ3qYRPZoFOrK
 q3SP71dWdzM+eVi9sMGlmna8Ml7naqlUQ0RdAD23hogya4ug==
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 26 Nov 2025 12:55:33 +0100
Corinna Vinschen wrote:
> On Nov 26 19:20, Takashi Yano wrote:
> > Hi Corinna,
> > 
> > On Tue, 25 Nov 2025 15:50:56 +0100
> > Corinna Vinschen wrote:
> > > On Nov 25 12:31, Corinna Vinschen wrote:
> > > > A short addendum:
> > > > 
> > > > On Nov 25 11:38, Corinna Vinschen wrote:
> > > > > That means:
> > > > > 
> > > > > - i_all_lf as array incures extra cost only at fork/execve time by
> > > > >   having to copy additional 64K over to the child process.
> > > > 
> > > >     If we count the cygheap copy here, we also have to count the
> > > >     mallocs in the other two cases...
> > > > > 
> > > > > - i_all_lf as malloced pointer in inode_t incures extra cost once
> > > > >   per created inode (malloc), once per execve (malloc), once per
> > > > >   deleted inode (free).
> > > > 
> > > >     Plus an extra 64K user heap copy at fork(2) time.
> > > > 
> > > > > - i_all_lf as local variable incures extra cost once per thread
> > > > >   (malloc), per process, under ideal conditions. 
> > > > 
> > > >     Plus an extra 64K user heap copy at fork(2) time.
> > > 
> > > I just had a bit of time so I prepared a v4.  Can you please check if
> > > this is ok?
> > 
> > Thanks! Looks good to me. I also confirmed the original test case
> > from Nahor works fine with this patch. In addition,
> > stress-ng --flock 20 -t 10
> > and
> > stress-ng --lockf 20 -t 10
> > pass.
> 
> Great to read, thanks for your review.  I just sent a followup patch,
> purely stylistic.  Please have a quick view if the patch is ok.  If so,
> I'll push the patches out to main and the 3.6 branch.

The followup patch LGTM. Thanks!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
