Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B6B20385840D; Wed, 26 Nov 2025 11:55:34 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 304B6A80F23; Wed, 26 Nov 2025 12:55:33 +0100 (CET)
Date: Wed, 26 Nov 2025 12:55:33 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: flock: Do not access tmp_pathbuf already released
Message-ID: <aSbqtZ1MQeKWfi4A@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251126192049.d753ae73075c905340298e98@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 26 19:20, Takashi Yano wrote:
> Hi Corinna,
> 
> On Tue, 25 Nov 2025 15:50:56 +0100
> Corinna Vinschen wrote:
> > On Nov 25 12:31, Corinna Vinschen wrote:
> > > A short addendum:
> > > 
> > > On Nov 25 11:38, Corinna Vinschen wrote:
> > > > That means:
> > > > 
> > > > - i_all_lf as array incures extra cost only at fork/execve time by
> > > >   having to copy additional 64K over to the child process.
> > > 
> > >     If we count the cygheap copy here, we also have to count the
> > >     mallocs in the other two cases...
> > > > 
> > > > - i_all_lf as malloced pointer in inode_t incures extra cost once
> > > >   per created inode (malloc), once per execve (malloc), once per
> > > >   deleted inode (free).
> > > 
> > >     Plus an extra 64K user heap copy at fork(2) time.
> > > 
> > > > - i_all_lf as local variable incures extra cost once per thread
> > > >   (malloc), per process, under ideal conditions. 
> > > 
> > >     Plus an extra 64K user heap copy at fork(2) time.
> > 
> > I just had a bit of time so I prepared a v4.  Can you please check if
> > this is ok?
> 
> Thanks! Looks good to me. I also confirmed the original test case
> from Nahor works fine with this patch. In addition,
> stress-ng --flock 20 -t 10
> and
> stress-ng --lockf 20 -t 10
> pass.

Great to read, thanks for your review.  I just sent a followup patch,
purely stylistic.  Please have a quick view if the patch is ok.  If so,
I'll push the patches out to main and the 3.6 branch.


Thanks,
Corinna
