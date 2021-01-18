Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com
 [210.131.2.90])
 by sourceware.org (Postfix) with ESMTPS id EF205386F466
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 12:58:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EF205386F466
Received: from Express5800-S70 (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conssluserg-05.nifty.com with ESMTP id 10ICvkwl008325
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 21:57:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 10ICvkwl008325
X-Nifty-SrcIP: [122.249.67.108]
Date: Mon, 18 Jan 2021 21:57:48 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 4/5] Cygwin: pty: Prevent pty from changing code page
 of parent console.
Message-Id: <20210118215748.53084ce47333655288d09aaa@nifty.ne.jp>
In-Reply-To: <20210118123901.GB59030@calimero.vinschen.de>
References: <20210118112447.1518-1-takashi.yano@nifty.ne.jp>
 <20210118123901.GB59030@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 18 Jan 2021 12:58:17 -0000

On Mon, 18 Jan 2021 13:39:01 +0100
Corinna Vinschen wrote:
> Sorry if I'm slow, but I was just mulling over this code snippet again,
> and I was wondering if we couldn't do without the HeapAlloc loop.
> Assuming you use a tmp_pathbuf here, you'd have space for 16384
> processes per console.  Shouldn't that be more than enough?  I.e.
> 
> static DWORD
> get_console_process_id (DWORD pid, bool match)
> {
>   tmp_pathbuf tp;
>   DWORD *list = (DWORD *) tp.w_get ();
>   const DWORD num = NT_MAX_PATH * sizeof (WCHAR) / sizeof (DWORD);
>   DWORD res = 0;
> 
>   num = GetConsoleProcessList (&list, num);
> 
>   /* Last one is the oldest. */
>   /* https://github.com/microsoft/terminal/issues/95 */
>   for (int i = (int) num - 1; i >= 0; i--)
>     if ((match && list[i] == pid) || (!match && list[i] != pid))
>       {
> 	res = list[i];
> 	break;
>       }
>   return res;
> }
> 
> 
> What do you think?

That's more that enough. I will submit v3 patch. Thanks again.
By the way, why do you think tmp_pathbuf is better than HeapAlloc()?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
