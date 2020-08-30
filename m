Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id D1587386F801
 for <cygwin-patches@cygwin.com>; Sun, 30 Aug 2020 12:47:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D1587386F801
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MqINP-1kxoW61tSN-00nS4S for <cygwin-patches@cygwin.com>; Sun, 30 Aug 2020
 14:47:01 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C27ECA83A7E; Sun, 30 Aug 2020 14:47:00 +0200 (CEST)
Date: Sun, 30 Aug 2020 14:47:00 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Remove waitloop argument from try_to_debug()
Message-ID: <20200830124700.GP3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200829144332.9065-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200829144332.9065-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:o+3SxuXoF3kLpW+dlYNpW0BxpMbBW28lwzlUK/OqG1lxWG4jSiZ
 XS7VlAwW12ipH4U13xjuj7PWMSHsWanVVOdUc0tp3LKF9XbumhMVHBFjpJjSuKEA/Jq8Sio
 45W5rBpxDd+aeXDEIecDhj1AbF5yvCdWvBVhREbcCbx27VgA/sRAMqWhYlXSGt6vjl4jtMf
 tQ497o/jaAUtktTq0udkw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GwCOgMXTFMM=:Y2BHJ9KzoP0IQwp+0vu2FM
 KZJlSlaYOW0Uz/7A0kH6L39Vor88Hx4IjLZU3BmgBEv+qW10NcePd7AXaysz7q6kb+QDQfmC+
 D0dT/cjEGM5IiqeJgYytDJWF//YGXk8kn105+EUJZJVj/PdJOEprlht+Fqn+t+cNP744IttHy
 F0Z9eLnqcEObGH5n1th7WcFx229jn6W3+7TPOJGahA4cDicC1EJ7SeF1ZkfnW9MivIDFHzcxZ
 99vc1u7jL6TBWJHOQExusNJEHTTWcR1Ple+DwwoZJHtEBxpGUiV24cLQ4UgmqhCiQwDJJzRee
 EfBtT7/IMQipb8HlW0jsn7VHngFb88D6j2ZJLsQpNNIcn7BDPoA6IcvhZUt97IBpctW0km1IH
 SsaT0ForTSfRy1gwEx+BaCMf82zpYj7q/u+VvEs38Gm0WynpWGKHEmEYGK5WZNUi4+ITY5w6Q
 nl2Gry7JAOyKqnfxv6JeYr0aHbDbF0S+Pg0lC8SiV6F++om26F2YRO0346h6wcY873/I1GVk1
 uCSSJ5rkxiKYRBgcKQBD4CkNF/fmTq+R8z9dTpfFZmsq17GcnpuG3aKuMX4wRIdvFP2Q141h/
 krj/MQWgF31Y6LDTNl6Ff73SxqoUKRwX5mlOIzGlvxG+qN3BeYjmmMIVBjE3hK1Nqdp1eOwfI
 Osef4KZjteei7aiZqc3EshF1NQxYOptq1qM3YWWdn7gYp4oXW/pQyPkBFurpGP5CkCT8F9sDx
 oFjvleApQVLfLz6Bo9ykB1O/aQ6IzKiYmZcGhPg95bKkejK9Z86A1xa9BbtppFQ769W7TGWuH
 TCtsa4pYfQjtLcf9z5okYask8nu1Cub5tg5Y58839dy+yl/nh5H9Wt/0lgKfM8IZsP/ED828I
 +AJXof6cYUXAxO2PJXew==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
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
X-List-Received-Date: Sun, 30 Aug 2020 12:47:13 -0000

On Aug 29 15:43, Jon Turney wrote:
> Currently, when using CYGWIN='error_start=dumper', the core dump written
> in response to an exception is non-deterministic, as the faulting
> process isn't stopped while the dumper is started (it even seems
> possible in theory that the faulting process could have exited before
> the dumper process attaches).
> 
> Remove the waitloop argument, only used in this case, so the faulting
> process busy-waits until the dump starts.
> 
> Code archeology to determine why the code is this way didn't really turn
> up any answers, but this seems a low-risk change, as this only changes
> the behaviour when:
> 
>  - a debugger isn't already attached
>  - an error_start is specified in CYGWIN env var
>  - an exception has occured which will be translated to a signal
> 
> Future work: This probably can be further simplified to make it
> completely synchronous by waiting for the dumper process to exit. This
> would avoid the race condition of the dumper attaching and detaching
> before we get around to checking for that (which we try to work around
> by juggling thread priorities), and the failure state where the dumper
> doesn't attach and we spin indefinitely.
> ---
>  winsup/cygwin/exceptions.cc | 8 ++------
>  winsup/cygwin/winsup.h      | 2 +-
>  2 files changed, 3 insertions(+), 7 deletions(-)

I'm a bit fuzzy on the implications but it doesn't look like it
hurts a lot(*).  Let's get it in.


Thanks,
Corinna


(*) Famous last words alarm...
