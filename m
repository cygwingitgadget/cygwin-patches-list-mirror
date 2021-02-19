Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 8B9F9398C039
 for <cygwin-patches@cygwin.com>; Fri, 19 Feb 2021 16:58:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8B9F9398C039
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N2VGj-1lqlSS1RR1-013uaP for <cygwin-patches@cygwin.com>; Fri, 19 Feb 2021
 17:58:39 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D5618A80CEC; Fri, 19 Feb 2021 17:58:38 +0100 (CET)
Date: Fri, 19 Feb 2021 17:58:38 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Console fixes for Win7.
Message-ID: <YC/uPsB/KUGuJaZs@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210218090128.1459-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210218090128.1459-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:c1Ly96qBK9q5Sfa2YaNjAV/qMBN74h6g46qfrBPAqPEfJEKvOhQ
 md/vGv9s9N7hQM9myKLlZplnt5FRmD/BxMUwD/tgw+SEfRFEVmkcjKj8Q5zT+kaalaH4WVn
 0ISGI9VrJLIiiVHTL18omuenFa8QIVbhWq2U38vpHZdAikUPIVbeqFvaNQLIHu/YC1BHEg9
 J8LNYZAh/pv771mNSmTsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iWi7h3/mR6k=:OQ7XqHzh/rlzm+sQ4RdH9r
 75JpjmPmSagPnGzB5IO1gPcIlUMcETjh0ke0ima6qslVXE5Evr/Q1oE9j/doIWEixVL/wuQjK
 hS6iaU4nI8GVj50YKSKdtPrwVJHYxXsY659m0gxw3Ml5Ln/o4TYCjOVWD6x/5NzxKRGzIzDaC
 FBUNqmdqlG15k0bddMAuHvfkFrQbGx9iN5Rcj98A7z2jAXOpau/v5DDBm5Fk6lmvaFmXVTJFF
 +PSDdVXKiRhqP4G7ZwaiI5V6C7JudKcJDYpM46fXImm8OSgxJC5+c4FZEknIcjXPJCJb7Gl1s
 6GadVAis2bPDfyiJGCYXAgOi5aMZ9KO1vadFVkvbD/+/vdFowEK4h/kZxN/vZcjbJxIcRCJjk
 TGXYD5UDoRyfwt8yzVgq5iStM8pjlSt1RdTVISiP2tCEAu5jikOxdJwurIC86B6yYa1dK/6JK
 +NgF+ZgOew==
X-Spam-Status: No, score=-101.4 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Fri, 19 Feb 2021 16:58:45 -0000

On Feb 18 18:01, Takashi Yano via Cygwin-patches wrote:
> Takashi Yano (2):
>   Cygwin: console: Fix SIGWINCH handling in Win7.
>   Cygwin: console: Fix handling of Ctrl-S in Win7.
> 
>  winsup/cygwin/fhandler.h          |   9 +-
>  winsup/cygwin/fhandler_console.cc | 306 ++++++++----------------------
>  winsup/cygwin/select.cc           |   4 +-
>  winsup/cygwin/spawn.cc            |  32 ++--
>  winsup/cygwin/tty.h               |   8 +-
>  5 files changed, 113 insertions(+), 246 deletions(-)
> 
> -- 
> 2.30.0

Pushed.

Thanks,
Corinna
