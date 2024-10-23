Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 15F1D3858D21; Wed, 23 Oct 2024 10:01:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 15F1D3858D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1729677671;
	bh=0ErmguoJOwZ8JJOt7PZiNXU2cKS78baadLPFAOdSmwI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=XWfD2QCm+5+8kK5cSyqwhfggTLkQX9w2SQ5A+uf1N8O5VRIGf8ip/UE9l1bfzbjqD
	 CogoeBQ0BaRM5xtZ+myS9j+Mj8AhnZ+V/Y+BCJU7vosYceIs0is/MvXsSN7j3vpwiO
	 94n36R98RvLHEe98NqaBetqHpFYXp3VlO/8qg6mA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DB406A80D05; Wed, 23 Oct 2024 12:01:08 +0200 (CEST)
Date: Wed, 23 Oct 2024 12:01:08 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: pread/pwrite: prevent EBADF error after fork()
Message-ID: <ZxjJZKJ7HdPxrqDg@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <9ef0c0ee-23fd-e74e-a925-2d7f973151b2@t-online.de>
 <Zxe7D_8yo05dgxZ2@calimero.vinschen.de>
 <a3fb9ca1-5f61-c009-0700-1bc0564fda3f@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3fb9ca1-5f61-c009-0700-1bc0564fda3f@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Oct 23 11:48, Christian Franke wrote:
> Corinna Vinschen wrote:
> > Hi Christian,
> > 
> > On Sep 24 12:09, Christian Franke wrote:
> > > This addresses:
> > > https://sourceware.org/pipermail/cygwin/2024-September/256468.html
> > > 
> > > -- 
> > > Regards,
> > > Christian
> > > 
> > Cool. Can you please add a matching entry to release/3.5.5?
> 
> Attached.

Pushed.  I just added a "Fixes:" line to the commit message.


Thanks,
Corinna
