Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1F48D3857839; Tue, 25 Nov 2025 14:50:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1F48D3857839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1764082258;
	bh=0oLsR9piYsnYa5jQrm6xVOHZskIudYsFXM8qQKuyvwo=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=cISSlAVoPnPfLl15GvkF3apHgQTJRqKbu5obS7IZBQNDEdAuYYVfjmfQpyvJt2ICF
	 NALevO9+jRbcr8qqKI1fX/onkRKFlr2mnTqqRFRuQVcY6wK88DTlwFODKIq9F5K9U1
	 rzVUIARc0NRFvC478KeyBwbm8aidiZ5/KWYlsvY4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6252EA80556; Tue, 25 Nov 2025 15:50:56 +0100 (CET)
Date: Tue, 25 Nov 2025 15:50:56 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: flock: Do not access tmp_pathbuf already released
Message-ID: <aSXCUNSuTyZ4jDBL@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aSWTf6e9-tCKBVcT@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov 25 12:31, Corinna Vinschen wrote:
> A short addendum:
> 
> On Nov 25 11:38, Corinna Vinschen wrote:
> > That means:
> > 
> > - i_all_lf as array incures extra cost only at fork/execve time by
> >   having to copy additional 64K over to the child process.
> 
>     If we count the cygheap copy here, we also have to count the
>     mallocs in the other two cases...
> > 
> > - i_all_lf as malloced pointer in inode_t incures extra cost once
> >   per created inode (malloc), once per execve (malloc), once per
> >   deleted inode (free).
> 
>     Plus an extra 64K user heap copy at fork(2) time.
> 
> > - i_all_lf as local variable incures extra cost once per thread
> >   (malloc), per process, under ideal conditions. 
> 
>     Plus an extra 64K user heap copy at fork(2) time.

I just had a bit of time so I prepared a v4.  Can you please check if
this is ok?


Thanks,
Corinna
