Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 4456438708BE
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 13:00:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4456438708BE
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N0X0U-1lvWg03ZQK-00wWPc for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 14:00:16 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 725DDA80988; Mon, 18 Jan 2021 14:00:16 +0100 (CET)
Date: Mon, 18 Jan 2021 14:00:16 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 4/5] Cygwin: pty: Prevent pty from changing code page
 of parent console.
Message-ID: <20210118130016.GD59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210118112447.1518-1-takashi.yano@nifty.ne.jp>
 <20210118123901.GB59030@calimero.vinschen.de>
 <20210118215748.53084ce47333655288d09aaa@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210118215748.53084ce47333655288d09aaa@nifty.ne.jp>
X-Provags-ID: V03:K1:u1PrYGy7CSIZUHnsG2lSO/7nNiP8u75/fgeUXt+UAHmk5M3FqpN
 a0JOWRa1gTt7SvKfxjXpkG8imGvwwxkWKD61voY7nKweA4QpZyv1TXv7T8VgR9LzEp9UwHw
 lAi2VUEAc2vJbZh5cAWA7/MN3ESUuLHGkFvOQV4w9Da6HX9UKHOW5fB9ayk4Wkw/zt89Sdc
 lOc8IKY+R2ubkomD7Q+rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ukz5bJjsHME=:CbHe8YYTeYTHqashbqNpJ9
 6qS6uUZNTDCjfLLiWIFymOMCmXPj9AaKLa7egOxufKHPRI8AiU1MQfCu1Bfuv6LZBNemh64qC
 Yg7VxnzixvljthXt1vhVhtSRNv+OYpEidBMQq0fRIxuAlpDD6NcQ9aulFFGYEy4VKO9WI8dTA
 TJeN8s4MWGS+3rtCvoN0q8SsPExtqGwZMSeOid2up7NiP2Vd/pyux1GpB7Clfsc+iJunvGp0X
 1pqQTpjRRBplZEmDJKUVCMJIVstQ1xMVw9a4dB8MlcBsvx9Z39VRJALwWY/yoqzsvZdfxMbLc
 dQL/f/VUSlU1J4kn8PTqdaA/s6L7k5zixbp8LDtqax+AJB1qYB/G3eP+NbFZsIL4vjfGXXarh
 DbvQQm2/BzOMXf7U0mo/MAmzueYVXSYZr72lzyGohSXv7nOWxb466zRVpcClZQZD403A/CZgj
 4zYa46C4Gg==
X-Spam-Status: No, score=-101.0 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 18 Jan 2021 13:00:19 -0000

On Jan 18 21:57, Takashi Yano via Cygwin-patches wrote:
> On Mon, 18 Jan 2021 13:39:01 +0100
> Corinna Vinschen wrote:
> > Sorry if I'm slow, but I was just mulling over this code snippet again,
> > and I was wondering if we couldn't do without the HeapAlloc loop.
> > Assuming you use a tmp_pathbuf here, you'd have space for 16384
> > processes per console.  Shouldn't that be more than enough?  I.e.
> > 
> > static DWORD
> > get_console_process_id (DWORD pid, bool match)
> > {
> >   tmp_pathbuf tp;
> >   DWORD *list = (DWORD *) tp.w_get ();
> >   const DWORD num = NT_MAX_PATH * sizeof (WCHAR) / sizeof (DWORD);
> >   DWORD res = 0;
> > 
> >   num = GetConsoleProcessList (&list, num);
> > 
> >   /* Last one is the oldest. */
> >   /* https://github.com/microsoft/terminal/issues/95 */
> >   for (int i = (int) num - 1; i >= 0; i--)
> >     if ((match && list[i] == pid) || (!match && list[i] != pid))
> >       {
> > 	res = list[i];
> > 	break;
> >       }
> >   return res;
> > }
> > 
> > 
> > What do you think?
> 
> That's more that enough. I will submit v3 patch. Thanks again.
> By the way, why do you think tmp_pathbuf is better than HeapAlloc()?

tmp_pathbuf never frees the buffers it used at least once. so
chances are hight that the call just returns the next free
pointer to an already alloocated buffer.


Corinna
