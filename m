Return-Path: <SRS0=J2yH=26=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id C87D8385842D
	for <cygwin-patches@cygwin.com>; Mon, 18 Aug 2025 17:51:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C87D8385842D
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C87D8385842D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1755539482; cv=none;
	b=F+ymTCslwBSU4GBHLlb9N8OsqH4Zv03xJyl9fVGd8k9lwFJ6Byu9+e3RkHgvl3awsyOyrEvAe5edRwjIGk6BjK9Iv8A+Cmggvo9VPWgZkEY8pQsg3rZbLdhWKVW/DTUKnNHg8YKwPbkCe4nXuHCl32Od/RvDISA9G4MzHo+FMoQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1755539482; c=relaxed/simple;
	bh=FifrKHB1yt07sFYBrKXXLjUslyhyOAYJ4NKejVzwHBE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=g/n60KkDgpWXI3StPT2SVBcTYEeBbd/O0cKCRHRXqxlbVssfWy1a3Ouj84QzyZb2V13dsvYNOcLWh6kPqMZs55oBhfY/TcxvRLD+spj6JZnxV35iQnwHkp3evbcXSyGkiqrcc+364t/feJxWlPL9SZ4LJymxrrTHtfcC9KDB1yA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C87D8385842D
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=NqZ4eMkS
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 3172845CF3;
	Mon, 18 Aug 2025 13:51:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=dZRKRssLMRcaJIo3qbJQ98bSus0=; b=NqZ4e
	MkSLTwuxq2be0gs2L6ePTyKIWYchMAeV0NW0HS7nDUZ/0QrlYLVh/lswzzbbk4Ov
	XniZNjmH0FjS8Z7MnrTUs04429aoI61qIMcYDmvZERRkuBYXk1VAX0SvDsmk84IO
	Xxo89Lvk6uiE80IyHv2zOfD6PJegy4ymZruqp4=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 17DD545CEF;
	Mon, 18 Aug 2025 13:51:22 -0400 (EDT)
Date: Mon, 18 Aug 2025 10:51:21 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com, Denis Excoffier <cygwin@Denis-Excoffier.org>
Subject: Re: [PATCH v3] Cygwin: spawn: Make ch_spwan_local be initialized
 properly
In-Reply-To: <20250818053130.1184-1-takashi.yano@nifty.ne.jp>
Message-ID: <4b72a508-d79e-2c7a-5edd-be161b3ce991@jdrake.com>
References: <20250818053130.1184-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 18 Aug 2025, Takashi Yano wrote:

> The class child_info_spawn has two constructors: one without arguments
> and one with two arguments. The former does not initialize any members.
> Commit 1f836c5f7394 used the latter to ensure that the local ch_spawn
> (i.e., ch_spawn_local) would be properly initialized. However, this was
> insufficient - it initialized only the base child_info members, not the
> fields specific to child_info_spawn. This led to the issue reported in
> https://cygwin.com/pipermail/cygwin/2025-August/258660.html.
>
> This patch introduces a new constructor to properly initialize member
> variable 'ev', etc., which were referred without initialization, and
> switches ch_spawn_local to use it. 'subproc_ready', which may not be
> initialized, is also initialized in the constructor of the base class
> child_info.
>
> Addresses: https://cygwin.com/pipermail/cygwin/2025-August/258660.html
> Fixes: 1f836c5f7394 ("Cygwin: spawn: Make system() thread-safe")
> Reported-by: Denis Excoffier <cygwin@Denis-Excoffier.org>
> Reviewed-by: Jeremy Drake <cygwin@jdrake.com>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>

LGTM.


> ---
>  winsup/cygwin/local_includes/child_info.h | 3 ++-
>  winsup/cygwin/sigproc.cc                  | 9 ++++++++-
>  winsup/cygwin/spawn.cc                    | 2 +-
>  winsup/cygwin/syscalls.cc                 | 2 +-
>  4 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/winsup/cygwin/local_includes/child_info.h b/winsup/cygwin/local_includes/child_info.h
> index 2da62ffaa..25d99fa7d 100644
> --- a/winsup/cygwin/local_includes/child_info.h
> +++ b/winsup/cygwin/local_includes/child_info.h
> @@ -33,7 +33,7 @@ enum child_status
>  #define EXEC_MAGIC_SIZE sizeof(child_info)
>
>  /* Change this value if you get a message indicating that it is out-of-sync. */
> -#define CURR_CHILD_INFO_MAGIC 0xacbf4682U
> +#define CURR_CHILD_INFO_MAGIC 0x77f25a01U
>
>  #include "pinfo.h"
>  struct cchildren
> @@ -149,6 +149,7 @@ public:
>
>    void cleanup ();
>    child_info_spawn () {};
> +  child_info_spawn (child_info_types);
>    child_info_spawn (child_info_types, bool);
>    void record_children ();
>    void reattach_children ();
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 361887981..30779cf8e 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -895,7 +895,8 @@ child_info::child_info (unsigned in_cb, child_info_types chtype,
>    msv_count (0), cb (in_cb), intro (PROC_MAGIC_GENERIC),
>    magic (CHILD_INFO_MAGIC), type (chtype), cygheap (::cygheap),
>    cygheap_max (::cygheap_max), flag (0), retry (child_info::retry_count),
> -  rd_proc_pipe (NULL), wr_proc_pipe (NULL), sigmask (_my_tls.sigmask)
> +  rd_proc_pipe (NULL), wr_proc_pipe (NULL), subproc_ready (NULL),
> +  sigmask (_my_tls.sigmask)
>  {
>    fhandler_union_cb = sizeof (fhandler_union);
>    user_h = cygwin_user_h;
> @@ -946,6 +947,12 @@ child_info_fork::child_info_fork () :
>  {
>  }
>
> +child_info_spawn::child_info_spawn (child_info_types chtype) :
> +  child_info (sizeof *this, chtype, false), hExeced (NULL), ev (NULL),
> +  sem (NULL), moreinfo (NULL)
> +{
> +}
> +
>  child_info_spawn::child_info_spawn (child_info_types chtype, bool need_subproc_ready) :
>    child_info (sizeof *this, chtype, need_subproc_ready)
>  {
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index 680f0fefd..71add8755 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -950,7 +950,7 @@ spawnve (int mode, const char *path, const char *const *argv,
>    if (!envp)
>      envp = empty_env;
>
> -  child_info_spawn ch_spawn_local (_CH_NADA, false);
> +  child_info_spawn ch_spawn_local (_CH_NADA);
>    switch (_P_MODE (mode))
>      {
>      case _P_OVERLAY:
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 863f8f23c..1b1ff17b0 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -4535,7 +4535,7 @@ popen (const char *command, const char *in_type)
>        fcntl (stdchild, F_SETFD, stdchild_state | FD_CLOEXEC);
>
>        /* Start a shell process to run the given command without forking. */
> -      child_info_spawn ch_spawn_local (_CH_NADA, false);
> +      child_info_spawn ch_spawn_local (_CH_NADA);
>        pid_t pid = ch_spawn_local.worker ("/bin/sh", argv, environ, _P_NOWAIT,
>  					 __std[0], __std[1]);
>
>

