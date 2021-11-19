Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 5A22E385800C
 for <cygwin-patches@cygwin.com>; Fri, 19 Nov 2021 17:22:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5A22E385800C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MVv8f-1nD6Yf41xt-00Rslj for <cygwin-patches@cygwin.com>; Fri, 19 Nov 2021
 18:22:41 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 34644A80D65; Fri, 19 Nov 2021 18:22:40 +0100 (CET)
Date: Fri, 19 Nov 2021 18:22:40 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: sigproc: Do not send signal to myself if exiting.
Message-ID: <YZfdYKyHPbMSZKVH@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211119115043.356-1-takashi.yano@nifty.ne.jp>
 <YZfH6jj7AqbpSTn2@calimero.vinschen.de>
 <YZfIlfu+1Lw3OZIl@calimero.vinschen.de>
 <20211120021452.c72956bba50a03d33c43d454@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211120021452.c72956bba50a03d33c43d454@nifty.ne.jp>
X-Provags-ID: V03:K1:wOcIcN49s5kpynOAA69N2MJi8n8PECr03UQ+5LkHpU25tXMQqmz
 OEpJ5e/IpIxRba29NCg/cNfDe/+95i1FC3TdigYYv7oE/in7rztqIxeu3RL/Qaycd7WaXBP
 qIpFhMsDwO0YSYCbcQhyM15duL9dUq8eQsDtSaA8B+pZZEC3IvTBwm3tD1cFAk239OnKnmP
 V3xqzTPS++XMP2q9EPJDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tcdb+JL1b/E=:/PMK0ewz/5sQFbq5r14VWM
 X2IcCoQCD0hrD2pp2zrwI8uM3tZJmP2GScho7736hX3Iz85rovMpxjN+M43nUUL439y4N79do
 DIkTA+ltD8m70xeYCeD+lFDy3Sg1nMsGtnzj/HXgnXetPZ0f+GEGHjUzCAKVI7rQt620zE3zO
 wP1CgECuRbavVqbxdqytRlo2pVMJQRmWP8RTnURzgqgqpU7wjBJ7+OK/zmkfaLhmKMiD5JX28
 coiDILD+eqU0HQ+BAoHUZRmUcl9w9p20TvVBbSvuWajR1uTZp+4KTHzBVtHc7c1Qv3roF+IGE
 nbLP867Kq6H5LbR4x7sJv5f4OjyT17BYWl6cAxMbAN768KvwSbgcVMfi7Uv3mr0EYGX4S2jCE
 Sy3qSZTJWEjZn+eXPqt9/3+q1FbftMtTTYX863FVmTKs/yWTkYA8U7eujfSKq1lyvJsJXkou6
 F3MzxVtlsnxPKYVjIub/S+j1UzWUqL3KTUgqzHwTVClqJ8Wj9Bkyv1CQB+J7opS/LtUvYZp96
 r2bKoTXLLvJZeUUHOOEOQji1AeUsNo99iQci4BXyPYCLkDE6Rh67Cbf26rruwbdHpCHbeGLh7
 8hF87I+mCOwsfK8XH4hqsPaFKuL+XmXNpMhtdcPaWRD3xvGhxCwVZa7jT3GVvfXJoO5KmXSks
 SZTY0Yuq1siMp58cj8IAyZvWDjeFlZeyv0qIvB1jCM0Pzn2CxQ2zxYnv1ZtDgKH+ZSFZOHhss
 fMmW+JMScH8ugaTR
X-Spam-Status: No, score=-99.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Fri, 19 Nov 2021 17:22:43 -0000

On Nov 20 02:14, Takashi Yano wrote:
> On Fri, 19 Nov 2021 16:53:57 +0100
> Corinna Vinschen wrote:
> > On Nov 19 16:51, Corinna Vinschen wrote:
> > > Isn't that already handled in wait_sig?  What's the difference here?
> > 
> > ...and where exactly is it waiting 60 secs?
> 
> If sending signal to myself with exit_state > ES_EXIT_STARGING,
> wait_for_completion in sig_send() is set to true. Therefore,
> sig_send() waits for pack.wakeup event for WSSC (60000 msec) here:
> 
>   /* No need to wait for signal completion unless this was a signal to
>      this process.
> 
>      If it was a signal to this process, wait for a dispatched signal.
>      Otherwise just wait for the wait_sig to signal that it has finished
>      processing the signal.  */
>   if (wait_for_completion)
>     {
>       sigproc_printf ("Waiting for pack.wakeup %p", pack.wakeup);
>       rc = WaitForSingleObject (pack.wakeup, WSSC);
>       ForceCloseHandle (pack.wakeup);
>     }
> 
> However, thread wait_sig ignores the signal here:
>       /* Don't process signals when we start exiting */
>       if (exit_state > ES_EXIT_STARTING && pack.si.si_signo > 0)
>         continue;
> and does not call SetEvent (pack.wakeup).
> 
> As a result, sig_send() hangs for 60 secs.
> 
> With this patch, sig_send() does not send signal which will
> be ignored in wait_sig().

Ah, ok, that makes sense.  Thanks for the explanation.  Please push.


Thanks,
Corinna
