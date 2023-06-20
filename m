Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 539283858D1E; Tue, 20 Jun 2023 08:22:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 539283858D1E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1687249370;
	bh=imQ4bnbkZ/DjlNvAtk+M07e0VnZqB0qIgjcz4rcMtlo=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=CNAfCx5G4PcY0MxXceVBXGM2NpUkD43g9zX7zzQejzItw52QbO3Op9xXaQPPBNP79
	 yjLNBwC+Rk9S5t42TBaIdeuvO0f5bTITCc1ucjBC5TLSoL0AKtFSWOcbcNnTP4j9MI
	 J6swfPM5BJe51a2OYw+iAIEu71GBT9EXb9qW1m6Q=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9477CA80BD1; Tue, 20 Jun 2023 10:22:48 +0200 (CEST)
Date: Tue, 20 Jun 2023 10:22:48 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/3] use wincap in format_proc_cpuinfo for user_shstk
Message-ID: <ZJFh2Cy9PnCqNoYU@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1687198150.git.Brian.Inglis@Shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1687198150.git.Brian.Inglis@Shaw.ca>
List-Id: <cygwin-patches.cygwin.com>

On Jun 19 12:15, Brian Inglis wrote:
> In test for for AMD/Intel Control flow Enforcement Technology user mode
> shadow stack support replace Windows version tests with test of wincap
> member addition has_user_shstk with Windows version dependent value
> 
> Fixes: 41fdb869f998 fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3 cpuinfo
> Signed-off-by: Brian Inglis <Brian.Inglis@Shaw.ca>
> 
> Brian Inglis (3):
>   wincap.h: add wincap member has_user_shstk
>   wincap.cc: set wincap member has_user_shstk true for 2004+
>   fhandler/proc.cc: use wincap.has_user_shstk
> 
>  winsup/cygwin/fhandler/proc.cc        |  8 ++++----
>  winsup/cygwin/local_includes/wincap.h |  2 ++
>  winsup/cygwin/wincap.cc               | 10 ++++++++++
>  3 files changed, 16 insertions(+), 4 deletions(-)

Never mind, I fixed the remaining problems.  Thanks for the patch,
I pushed it with slight modifications to the commit messages.

I'm a bit puzzled if my original mail
https://cygwin.com/pipermail/cygwin-patches/2023q2/012280.html
was really that unclear.  Reiterating for the records:

- Commit messages should really try to explain why the patch is made and
  what it's good for. In case of fixing a bug, the bug should be explained
  and, ideally, explain why the patch is the better solution.

- If a patch fixes an older bug, it should say so and point out the
  commit which introduced the bug using the Fixes: tag.  The format
  is
  
    Fixes: <12-digit-SHA1> ("<commit headline>")

  The parens and quoting chars are part of the format.

- Every patch should contain a Signed-off-by: to indicate that
  you did the patch by yourself.  That's easily automated by
  using `git commit -s'.

- Other Tags like "Reported-by:" or "Tested-by:" are nice to have,
  but not essential.


Thanks,
Corinna
