Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 586183939C0D
 for <cygwin-patches@cygwin.com>; Mon, 22 Feb 2021 13:58:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 586183939C0D
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MQdtO-1lRzn842tS-00NiPH for <cygwin-patches@cygwin.com>; Mon, 22 Feb 2021
 14:58:29 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 92F81A80D43; Mon, 22 Feb 2021 14:58:28 +0100 (CET)
Date: Mon, 22 Feb 2021 14:58:28 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Prevent NULL pointer access in close().
Message-ID: <YDO4hCq+91d7KfmB@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210222133017.432-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210222133017.432-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:NLUl5pSCLKs7DPqM5ZU6rT+Fqp8FqF8r2hsp6s5Dk57EXrquosX
 8rFSo/E0X9XcpA+LGal3wiYO39j16jJ7/rWN5XmMJbJrOeLniByFrmv8eU5U3UCu6qf+J5g
 IzSnLBIKIAk6PZgUYe5l9WNcVJnv/xgBH9/qPV2eXdueVi0EdJJuJdKSDnJrBCEF2BVas0g
 lCyKx4ZNKTaIrkXd3fCeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DXUvTBJOxJw=:z2G5gEMyPDrGM/XqwNoqTG
 VN5H/GWj3p3qH1gRaKleGIo1+i2JgSWsk+hd9lo8t+eX7BPqK+/VT0Plzq12zrY5VN575A6sa
 Ry0eczoudDO7t7wstOLyKpzIzBkwsanBzg3zzrwXYpQVQZviiH42vWS6PILPqwzQ2XK4BGyMO
 rfggwmiCvLJSMS97RyjLxT8B+AaVnrntIK72SJb4NxSAc2cz+HzqFP/ylu+RxiGkY5Svz0LD5
 z2dQd7q3XJLWwUxgqUQXeVktocP0vqhspX/VVxYvYeyskJHHy3myR25rNZZjFRfEa7PxnmCMQ
 uCKxP6GqMliKJffM7SEcCh6CTJXwjVmZEOqccb6t1vVvb/MIL/DqUbfAvF5VZwwaEWF4EVDQ4
 26FoQmtRRRnIxt1eBwgVspF2rEdGhxNEbIK+WOAefCNteCIca+VSWMG1atlFZ//028LlzvjX+
 uPw7/ILukA==
X-Spam-Status: No, score=-107.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 22 Feb 2021 13:58:31 -0000

On Feb 22 22:30, Takashi Yano via Cygwin-patches wrote:
> - There seems to be a case that shared_console_info is not set yet
>   when close() is called. This patch adds guard for such case.
> ---
>  winsup/cygwin/fhandler_console.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
> index 6ded9eabf..96a8729e8 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -1393,7 +1393,7 @@ fhandler_console::close ()
>  
>    release_output_mutex ();
>  
> -  if (con.owner == myself->pid)
> +  if (shared_console_info && con.owner == myself->pid)
>      {
>        char name[MAX_PATH];
>        shared_name (name, CONS_THREAD_SYNC, get_minor ());
> -- 
> 2.30.0

Pushed.


Thanks,
Corinna
