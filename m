Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 203053858C50; Fri, 27 Jun 2025 12:31:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 203053858C50
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751027515;
	bh=wMPvhzudeLcVRr4HZBIV002KXstGPxGZJWxLxx0E09A=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=rn7qHAA6N0Lb3+SHzgLUft81+Xp1dPT6IAsUK23hn3Xs9va16NF/lTiD97+f/550q
	 MCMlsXFOvjsuCKCfrr8tr0eLXa7qPJ868N71Ns0jWTzOLPGv5MSVDZ0Js74+bt9ntY
	 Hx6fZysTSzDMdCzvnV7QZWER9J6WVbQ8d+FN90pI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0B2E6A8061B; Fri, 27 Jun 2025 14:31:53 +0200 (CEST)
Date: Fri, 27 Jun 2025 14:31:53 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: testsuite: test passing directory fd to child
Message-ID: <aF6POTp2VGPfPE6m@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1b4da216-51cb-cbc5-7a2d-db997429eed3@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1b4da216-51cb-cbc5-7a2d-db997429eed3@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 26 13:34, Jeremy Drake via Cygwin-patches wrote:
> It doesn't make a whole lot of sense to redirect stdin/out/err to/from a
> directory handle, but test it anyway.

I disagree.  There's nothing wrong if a program expects a directory
handle on a file descriptor if the task is, for instance, to perform
readdir on the incoming descriptor.

Therefore, the code is ok, the commit message isn't.


Thanks,
Corinna
