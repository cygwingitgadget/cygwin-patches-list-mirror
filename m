Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id ACAD6386EC5B
 for <cygwin-patches@cygwin.com>; Tue, 27 Oct 2020 09:27:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org ACAD6386EC5B
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MtOSu-1kG5MX0DN8-00upbi for <cygwin-patches@cygwin.com>; Tue, 27 Oct 2020
 10:27:35 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id A5058A8104F; Tue, 27 Oct 2020 10:27:33 +0100 (CET)
Date: Tue, 27 Oct 2020 10:27:33 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable ResizePseudoConsole() if stdout is
 redirected.
Message-ID: <20201027092733.GI5492@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201027082634.441-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027082634.441-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:76vxnxLMjBxFDh1s0zQ1UBK/SEq5egqSlPIMVoDzElVDYi3tofT
 0pkulpqSBOF2yjWj0p3bP6Ynjgfp3qDc/H71NNnWb6kqwVDnf93rPM0sQ4YauEyoi1vNmMz
 DfbMI6pChb3uUJnJkYDJA/iWrSlaCYTQpTw81Pw6oIuvmYXwUqh93EG9ToxgphqTvD8WuVG
 RmnRenhKr49wbhqVOpfQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iyzapGBnmJI=:T0EKgzpEKsm2zrEQCpuBCp
 +1WmFI0XVY/tC/iski0erQXx6qHYksbSeAvY4zzuyt5uo4gQoRnfi1zYGp8EtxZumqokW8se4
 DR0uinrbcvR+g21fB5KcC1HX3AyBVAUwriF3/E1rZPnm+3eawmWWEXMeWdBVdYUchmAxhFWqy
 5aEMpD7/zGjwGeMUgSNIhx/NPZv6Q5QUoJ979Vqw8WlqnquQbaoj5BqsX1TcK490bpEHmbY3u
 PKZpi+cBtx4RzreI52TL44uw4qdV+6GppcdYrsdtA2sAlgcuS3huqm1nZdQ3rUPW02UwAuvEC
 x6YAPHu0oFq9WoMhn6yTeBeyIpibdFeXlF7wPn4gAPtfyFTwwq45bwkUCZQswyBOwrkV9CAAK
 TIXrjOlpGuQh+Jl5lw3/JIhPXBWzFokIbrrd38M5pl3kBu+MYLCtS50/+UftQOLVU5OFvCFS/
 le6q+Pbd8A==
X-Spam-Status: No, score=-100.9 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Tue, 27 Oct 2020 09:27:38 -0000

On Oct 27 17:26, Takashi Yano via Cygwin-patches wrote:
> - Calling ResizePseudoConsole() generates some escape sequences.
>   Due to this behaviour, if the output of non-cygwin app is piped
>   to less, screen is sometimes distorted when the screen is resized.
>   With this patch, ResizePseudoConsole() is not called if stdout is
>   redirected.
> ---
>  winsup/cygwin/fhandler_tty.cc | 8 ++++++--
>  winsup/cygwin/tty.cc          | 1 +
>  winsup/cygwin/tty.h           | 1 +
>  3 files changed, 8 insertions(+), 2 deletions(-)

Pushed.


Thanks,
Corinna
