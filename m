Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id 2AE433858C50
 for <cygwin-patches@cygwin.com>; Tue, 29 Mar 2022 15:21:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2AE433858C50
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id 16A9ACC25;
 Tue, 29 Mar 2022 11:21:12 -0400 (EDT)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id 0637DCC1C;
 Tue, 29 Mar 2022 11:21:12 -0400 (EDT)
Date: Tue, 29 Mar 2022 08:21:11 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: pipe: Avoid deadlock for non-cygwin writer.
In-Reply-To: <20220329090753.47207-1-takashi.yano@nifty.ne.jp>
Message-ID: <alpine.BSO.2.21.2203290816270.56460@resin.csoft.net>
References: <20220329090753.47207-1-takashi.yano@nifty.ne.jp>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, SPF_HELO_PASS, SPF_PASS,
 TXREP, T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 29 Mar 2022 15:21:20 -0000

On Tue, 29 Mar 2022, Takashi Yano wrote:

> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index fb3d09d84..cd2d3a7ef 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -645,8 +646,18 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
>  		     && (fd == fileno_stdout || fd == fileno_stderr))
>  	      {
>  		fhandler_pipe *pipe = (fhandler_pipe *)(fhandler_base *) cfd;
> -		pipe->close_query_handle ();
>  		pipe->set_pipe_non_blocking (false);
> +		pipe->request_close_query_hdl ();
> +
> +		tty_min dummy_tty;
> +		dummy_tty.ntty = (fh_devices) myself->ctty;
> +		dummy_tty.pgid = myself->pgid;
> +		tty_min *t = cygwin_shared->tty.get_cttyp ();
> +		if (!t) /* If tty is not allocated, use dummy_tty instead. */
> +		  t = &dummy_tty;
> +		/* Emit __SIGNONCYGCHLD to let all processes in the
> +		   process group close query_hdl. */
> +		t->kill_pgrp (__SIGNONCYGCHLD);
>  	      }
>  	    else if (cfd->get_dev () == FH_PIPER && fd == fileno_stdin)
>  	      {
>

This block seems to be inside a loop over handles.  Would it make sense to
move the `tty_min dummy_tty` through `t->kill_pgrp` lines outside the
loop, and set a flag in the loop instead, so the pgrp only needs to be
signaled (killed) once rather than for each handle that needs closing?
