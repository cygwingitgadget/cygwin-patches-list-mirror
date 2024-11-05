Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 31C0D3858023; Tue,  5 Nov 2024 12:29:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 31C0D3858023
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1730809787;
	bh=TzmuXvgwuTAwy/72Z7YDN/n/PGlgzVEwRbovg/JxOc4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=mcQt9tqLWUG5wrA4RXt+4z16WHSngz+ghDa7lzImyblCXTk3uxQC9fbm7AvFyrsTC
	 01O/fPy7onPyHo7wHuoevFEt1M9tU+/kcFH/kofpd/U61jt4x/J0cEnqNCpkg4BEgW
	 cpnt9nPlvtHrp7UlJXXKJOdJ4LV8q7406nWcmuoI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A7BF6A809BC; Tue,  5 Nov 2024 13:29:44 +0100 (CET)
Date: Tue, 5 Nov 2024 13:29:44 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Change pthread_sigqueue() to accept thread id
Message-ID: <ZyoPuEidrxii1aN7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240919091331.1534-1-mark@maxrnd.com>
 <Zxe6gsvAQp7HaeO7@calimero.vinschen.de>
 <c86bcce2-e705-41e2-a918-d97debc7362b@maxrnd.com>
 <ec6ec704-67d1-72fd-0041-87e7372b58f3@t-online.de>
 <ZyiinKXESiXU4AvU@calimero.vinschen.de>
 <683a0e8b-9a8c-4729-0594-353ff5e04ac6@t-online.de>
 <ZyjbgeaHuJEZmP3m@calimero.vinschen.de>
 <ZyjfC6-UiQDuYwoH@calimero.vinschen.de>
 <bf4fbc09-f47d-61a9-3eaf-eaa6eef12197@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf4fbc09-f47d-61a9-3eaf-eaa6eef12197@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov  5 12:37, Christian Franke wrote:
> Corinna Vinschen wrote:
> > I guess if it's only part of the 3.5 backport, it's ok.
> 
> A closer look might suggests that there are no use cases for packages in the
> Cygwin distro:
> 
> I did a quick check unpacking all *.dll *.exe *.so (with --backup=t) files
> (~20GiB) from all x86_64/release/**tar* files from a local Cygwin mirror. An
> 'objdump -p' on each file (total 24Gib) lists pthread_sigqueue only for the
> various cygwin1.dll releases. Even the stress-ng package I maintain isn't
> affected because the related stress test is guarded with #ifndef __CYGWIN__.

Thanks for pointing this out!

Then we should probably just make the plunge, fix the buggy 
pthread_sigqueue and be done with it, as in Mark's v2, just with
the discussed changes (and a new entry for release/3.5.5).

Maybe you can enable the ifndef'ed out test with this change...

Mark, are you going to prepare a v3?


Thanks,
Corinna
