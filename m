Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D9ACD3857BAF; Wed, 25 Jun 2025 11:40:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D9ACD3857BAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750851626;
	bh=laTSpj6qHede+k7Va09GuuWwKqEXLL9dzgQ5WMu5CTU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=tpwEZckCgJ9QeNMvKyoBZDmQzHxdPYbSNrUDmUXqDFPxCsqC5W2fdUp2HkcnxTaSm
	 w484ZPBDddRXOP9kzmhLFd+i8eLRS08+9IKwsSqixnNaAlsaObCei9GDc1McxIUHFr
	 d/fthPAZ56WhoIb4OhiexhkIBF6TXmRDYO0SM76k=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B98A8A80E29; Wed, 25 Jun 2025 13:40:24 +0200 (CEST)
Date: Wed, 25 Jun 2025 13:40:24 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: testsuite: test posix_file_actions_add(f)chdir
Message-ID: <aFvgKGHEdChNTJJy@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4e2155b6-941b-29b6-e610-059f8a1e7539@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e2155b6-941b-29b6-e610-059f8a1e7539@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 24 13:47, Jeremy Drake via Cygwin-patches wrote:
> Also test their interaction with addopen, as opens added subsequent to a
> chdir need to be relative to that new cwd.
> 
> In order for the tests to compile on Linux, define O_SEARCH to O_PATH if
> O_SEARCH is not defined, and use the *chdir_np names instead of the
> now-standardized *chdir.

Go for it.


Thanks,
Corinna
