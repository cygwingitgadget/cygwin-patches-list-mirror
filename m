Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id A38A3384A01D
 for <cygwin-patches@cygwin.com>; Thu, 10 Dec 2020 09:47:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A38A3384A01D
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MIdaF-1ksVCD0JKH-00EgjD for <cygwin-patches@cygwin.com>; Thu, 10 Dec 2020
 10:47:32 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id EBC77A8075A; Thu, 10 Dec 2020 10:47:30 +0100 (CET)
Date: Thu, 10 Dec 2020 10:47:30 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] cygwin: use CREATE_DEFAULT_ERROR_MODE in spawn
Message-ID: <20201210094730.GA4102@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2012091123460.9707@resin.csoft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.BSO.2.21.2012091123460.9707@resin.csoft.net>
X-Provags-ID: V03:K1:rNj/1Z6cScMZpb9MtrjB4xk4N1oxiDa0tN2p00fMkgmhJSKgE9w
 sabZUoSr42snuF0FMQ6/Jp1ocKJVvgyeI1P2/UhGPZuOxX5rlZrMT32rFNt+xFqKbL4Z+qa
 FAC0Gq6gkXLmBNFd/CGwHRcUN+w3n3SLhUzwHdzN2NEjF/+N5wlA/zNeDEQb9bLICmvag9S
 PYnxaQ2UpWbzMQthS0Mhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XdKCurb4/Bk=:7txfmJf8umi6BpWu5hrxVq
 ma7YUeOxntXe/6IGW47MnBu1KoPQogf8dp+HSzVU0QvdneiKfdrcHwhxA+isW0TJBKSjERtzk
 aNwak91I38BxVklp75P3s352SRMNR7Dle9OynZO75yA4fikNHUzVSVn62bcHMD8dTQOuNUbF4
 w2CcEoGHivsPE9CmByzXi1IU+kY1qfgDHqAesyXpPN1C1VDw99lqEWsfOOi++Xe4g4iDMkUFJ
 0rNTKizuyrZrGuoY58Zy3Q+WCpfhCJwATJCWgykKi78X6W1+ohzLM60NeSpAsdddaCGJ3eKGl
 k5yBtRtqEbkS9zqB114eZ/Xmqbxky7HmTO/GW7MWBHN0WecoJ6nfzut9BfU51MQAnAqqLnOJG
 p7QY57O56VfLuSL4IdaQKC0an1gN6Y6ggWQ/7CFAK/ECMLPZiFha2geL/cEQw7xmDP0aj6UfE
 Sh6fqpa2sw==
X-Spam-Status: No, score=-106.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Thu, 10 Dec 2020 09:47:35 -0000

On Dec  9 11:27, Jeremy Drake via Cygwin-patches wrote:
> This allows native processes to get Windows-default error handling
> behavior (such as invoking the registered JIT debugger).
> 
> ---
>  winsup/cygwin/spawn.cc | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index 92d190d1a..83b216f52 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -431,6 +431,13 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
> 
>        c_flags |= CREATE_SEPARATE_WOW_VDM | CREATE_UNICODE_ENVIRONMENT;
> 
> +      /* Add CREATE_DEFAULT_ERROR_MODE flag for non-Cygwin processes so they
> +	 get the default error mode instead of inheriting the mode Cygwin
> +	 uses.  This allows things like Windows Error Reporting/JIT debugging
> +	 to work with processes launched from a Cygwin shell. */
> +      if (!real_path.iscygexec ())
> +	c_flags |= CREATE_DEFAULT_ERROR_MODE;
> +
>        /* We're adding the CREATE_BREAKAWAY_FROM_JOB flag here to workaround
>  	 issues with the "Program Compatibility Assistant (PCA) Service".
>  	 For some reason, when starting long running sessions from mintty(*),
> -- 
> 2.29.2.windows.3

Pushed.


Thanks,
Corinna
