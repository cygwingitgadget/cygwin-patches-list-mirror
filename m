Return-Path: <SRS0=iZMO=23=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id E1A713858D32
	for <cygwin-patches@cygwin.com>; Fri, 15 Aug 2025 21:46:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E1A713858D32
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E1A713858D32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1755294393; cv=none;
	b=u0U5oGVYGHVQ8b1AVcwPjOutiEWu/W1s3BGX3TFAfu7J0h5RPk//nQk/MWHVXthgR7SmBP4kq5tYxjWkzzztGisTtfgI3mUtMdNTHnBc8KK8FGzdY9H5eMBWHPpqSl4i/SHmuRmE2IV7bvfswCYsKY0fzUhgQnFpXQS83AWGgbY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1755294393; c=relaxed/simple;
	bh=jUpLkAhfMR2v4TkQ7UqzEop1LetpKyHLkV2pWGAZhi8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Bw5r3s+fgF9ApDGtWDjs5YOFwEHmRRafhLBNelmfierypbYT7jBQJgQ9WpgrbTSivEN6gE7NP0PQSkMAnmZxCEQOMVKfP0TQquCJ5D4KK0gWdD1pZYd54QQd6dOhymkH/Se5BIfgJADoNiu6Pk8WyWc2ntW8ULUshmf/JK8HWKo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E1A713858D32
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=y2VgG56F
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id B9C9F45A5F;
	Fri, 15 Aug 2025 17:46:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=P3jZ9pMHwP2N0dgCKACAcqwdQPM=; b=y2VgG
	56FwENnTEu21SUk62P1FTY3eDdKIU4dRpLfLciP09TfcevhriLzYrtCW2jfHCOrc
	feuN34Y6X1vh9I0n2YCkmno3ISAbGdxUIzFXtnpj76tKoh4xTpU2Mldbxw3bm8Fe
	Zzf0XmROuNf+BUQrls0w42LXRnfSRoa5XFKjg0=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id B3D9845A25;
	Fri, 15 Aug 2025 17:46:31 -0400 (EDT)
Date: Fri, 15 Aug 2025 14:46:31 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com, Denis Excoffier <cygwin@Denis-Excoffier.org>
Subject: Re: [PATCH] Cygwin: spawn: Make ch_spwan_local be fully
 initialized
In-Reply-To: <20250815213519.3049-1-takashi.yano@nifty.ne.jp>
Message-ID: <ee1649ac-50bf-df75-b1bf-eabc99336d8f@jdrake.com>
References: <20250815213519.3049-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 16 Aug 2025, Takashi Yano wrote:

> The class child_info_spawn has two constructors: one without arguments
> and one with two arguments. The former does not initialize any members.
> Commit 1f836c5f7394 used the latter to ensure that the local ch_spawn
> (i.e., ch_spawn_local) would be properly initialized. However, this was
> insufficient - it initialized only the base child_info members, not the
> fields specific to child_info_spawn. This led to the issue reported in
> https://cygwin.com/pipermail/cygwin/2025-August/258660.html.
>
> This patch updates the former constructor to properly initialize all
> member variables and switches ch_spawn_local to use it.
>
> Addresses: https://cygwin.com/pipermail/cygwin/2025-August/258660.html
> Fixes: 1f836c5f7394 ("Cygwin: spawn: Make system() thread-safe")
> Reported-by: Denis Excoffier <cygwin@Denis-Excoffier.org>
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/local_includes/child_info.h | 4 +++-
>  winsup/cygwin/spawn.cc                    | 2 +-
>  winsup/cygwin/syscalls.cc                 | 2 +-
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
> index 2da62ffaa..e359d3645 100644
> --- a/winsup/cygwin/local_includes/child_info.h
> +++ b/winsup/cygwin/local_includes/child_info.h
> @@ -148,7 +148,9 @@ public:
>    char filler[4];
>
>    void cleanup ();
> -  child_info_spawn () {};
> +  child_info_spawn () : child_info (sizeof *this, _CH_NADA, false),
> +    hExeced (NULL), ev (NULL), sem (NULL), cygpid (0),
> +    moreinfo (NULL), __stdin (0), __stdout (0) {};
>    child_info_spawn (child_info_types, bool);
>    void record_children ();
>    void reattach_children ();

Making a change to the child_info* classes will require updating the
"magic" define in that header.

Do we really need to initialize all of the members?  It seems like most of
them would be written during child_info_spawn::worker.  I expect sem to be
an exception.  I guess it doesn't hurt.

__stdin and __stdout might make sense to initialize to -1 instead of 0,
but I know they will always be written during worker.


> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index 680f0fefd..6cd97ec17 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -950,7 +950,7 @@ spawnve (int mode, const char *path, const char *const *argv,
>    if (!envp)
>      envp = empty_env;
>
> -  child_info_spawn ch_spawn_local (_CH_NADA, false);
> +  child_info_spawn ch_spawn_local;
>    switch (_P_MODE (mode))
>      {
>      case _P_OVERLAY:
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 863f8f23c..83a54ca05 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -4535,7 +4535,7 @@ popen (const char *command, const char *in_type)
>        fcntl (stdchild, F_SETFD, stdchild_state | FD_CLOEXEC);
>
>        /* Start a shell process to run the given command without forking. */
> -      child_info_spawn ch_spawn_local (_CH_NADA, false);
> +      child_info_spawn ch_spawn_local;
>        pid_t pid = ch_spawn_local.worker ("/bin/sh", argv, environ, _P_NOWAIT,
>  					 __std[0], __std[1]);
>
>

