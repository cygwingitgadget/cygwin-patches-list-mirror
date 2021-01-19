Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 4B1873939C26
 for <cygwin-patches@cygwin.com>; Tue, 19 Jan 2021 09:57:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4B1873939C26
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N6bo8-1m6FfM03Sg-01870o for <cygwin-patches@cygwin.com>; Tue, 19 Jan 2021
 10:57:34 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 81C61A80D4B; Tue, 19 Jan 2021 10:57:33 +0100 (CET)
Date: Tue, 19 Jan 2021 10:57:33 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: spawn.cc: Fix typo in comment by commit 974e6d76.
Message-ID: <20210119095733.GN59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210118184524.792-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210118184524.792-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:BH+vQQiX5aGHfbP/3hqU5sx6YjWhQsw+krrjo0Yf+ynREUoX/6h
 R7SkfVcYRKgG25H2dHdcbX9FPxaR9N13qWGp5C8YWqWTJ6G/SX6KqjjdvXlKh7sp9rCxaSv
 j4P74pmbSS25LvfEbVAfJbZIkqn/CMXwgTxzzA0GijYR9W5Iwt4DNmyOCgOAAhFSutE6C02
 vRaxKqvkl7Ew4P2fpRuvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/O8Mbocqe1g=:BIusknMUE1J+Skc+BQ1h8b
 3t9ZebyHAG8Qohd859fZfmOpqN3kK3X0W4+wx2Pwy9e24HmzEXSD9Y4G0xnpP7CAIhPRu5xZ/
 TGXS7RZHK2py2NwU/co4SvcgoFQBK2buynmlSjRRegpNe9Ods4DZx+2Jik/iakr/0abM05C8Z
 FEgHy8No+CaH7gAxmkCRAlN7T1QzetjZclvCH+tZgB8z0HzPurbKRkC4TMNfUT2nTYy3mqYLQ
 Xr42v69TTXRGTFdNeibTTs8NftaVfSBudLLoLaCP9HsSHXGMxVGMUxKi04Fkg6gMKt7pmf0oh
 mCL2tAlVwTXeNB5iOO7N1hmrQG9cvn5xfDKh8L+R72Z6fVzpc4u14uLEH9uPPjEZSX1YweeCB
 3Xxonr3U4sRnJPuHtgDHAoa8D36EC5fQWhQBuxXFvQcwsbfpBJAe73l0CXvxw5aaJx+qPVpHf
 OmgEZqa0+w==
X-Spam-Status: No, score=-106.8 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 19 Jan 2021 09:57:36 -0000

On Jan 19 03:45, Takashi Yano via Cygwin-patches wrote:
> ---
>  winsup/cygwin/spawn.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index 42044ab53..d03492ee6 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -636,7 +636,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
>  	}
>        struct fhandler_console::handle_set_t cons_handle_set = { 0, };
>        if (cons_native)
> -	/* Console handles will be closed by close_all_handle(),
> +	/* Console handles will be closed by close_all_files(),
>  	   therefore, duplicate them here */
>  	cons_native->get_duplicated_handle_set (&cons_handle_set);
>  
> -- 
> 2.30.0

Pushed.


Thanks,
Corinna
