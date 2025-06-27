Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id DB7BF3857C5D; Fri, 27 Jun 2025 08:55:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DB7BF3857C5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751014552;
	bh=mQ82piOzDDXXzvmwoaiiJMEnAT8QndgWRqfJgTAe9RE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=VCcP9axJCR3afdkZaFhWtxLBrQZlXphUIlH8g6SkbV7uWWW+x53UnwzJUdx64A7C5
	 WaHvPa6IZ0S7hfl1fBkNMUKSud0X9lVS07V2f4eLiNKo/TG8gJYwOl9ynSb0vD24e+
	 DCP1ebwBI+021Qwk8HAJmrQfU7p6ncT33Kt26yCI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B74F0A806FF; Fri, 27 Jun 2025 10:55:50 +0200 (CEST)
Date: Fri, 27 Jun 2025 10:55:50 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: testsuite: test relative path to exe after
 addchdir.
Message-ID: <aF5cls2rh-njQ-PF@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <798a4efc-cd12-42be-c155-88284d16c721@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <798a4efc-cd12-42be-c155-88284d16c721@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 26 13:29, Jeremy Drake via Cygwin-patches wrote:
> This is apparently relative to the new cwd, but my implementation is
> currently treating it as relative to the parent's cwd, so it's worth
> testing.
> 
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
>  winsup/testsuite/winsup.api/posix_spawn/errors.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/winsup/testsuite/winsup.api/posix_spawn/errors.c b/winsup/testsuite/winsup.api/posix_spawn/errors.c
> index 38563441f3..2fc3217bc0 100644
> --- a/winsup/testsuite/winsup.api/posix_spawn/errors.c
> +++ b/winsup/testsuite/winsup.api/posix_spawn/errors.c
> @@ -15,6 +15,7 @@ void cleanup_tmpfile (void)
> 
>  int main (void)
>  {
> +  posix_spawn_file_actions_t fa;
>    pid_t pid;
>    int fd;
>    char *childargv[] = {"ls", NULL};
> @@ -53,5 +54,12 @@ int main (void)
>        posix_spawn (&pid, tmpsub, NULL, NULL, childargv, environ));
>  #endif
> 
> +  /* expected ENOENT: relative path after chdir */
> +  errCode (posix_spawn_file_actions_init (&fa));
> +  errCode (posix_spawn_file_actions_addchdir_np (&fa, "/tmp"));

_np?  This is POSIX issue 8 now without the trailing _np.
Cygwin supports that already.


Corinna
