Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 3B825385B805
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 11:36:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3B825385B805
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MRmsE-1lUW1s3fn0-00TDC2 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 12:36:30 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 7EA4CA80988; Mon, 18 Jan 2021 12:36:30 +0100 (CET)
Date: Mon, 18 Jan 2021 12:36:30 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 08/11] path.cc: Allow to skip filesystem checks
Message-ID: <20210118113630.GX59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-9-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115134534.13290-9-ben@wijen.net>
X-Provags-ID: V03:K1:N7XglFXsTiuGwNDSQJA3AghEuFEKAIXJ3GrcPRqXSvSuTRyb8Mz
 LS/k1i2yYEiA4O+OyWkBXzk4DnB434S1IPAUdzjROZ58ADZZVLRdOfHNObVA8f105UBGPe1
 cW17dZEHVg2cQNqEb1v9XY2wDWM6Z08FVBHeQQlVM8OyMzahmZCLq5wZ3oIOzI3pGPNlmUk
 hy6W5yWjD4Ym15zaKDCkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oYW0XAafpx4=:fTAbWldsGMF90rzx0eyEtN
 3A/lnnEpj1cosdIMIegYw67yhanT9Y5w52W9bstrMJdLwbdZOWincu13YI1puz+wryQzALXSQ
 ndtaIEASozwpB4/b+EeWXKvgvbs4YaWdiLEPJx3IwjnpS1DHLvQlI3lWzA8XL/WVYC1UfWEW0
 b/xM4yQ25W7nuNd7l4YVHr6AcC1PYWAbO4Zdi9THC+KVXkwdqdlfDWUJbN+X8u4323FMSKr74
 sBJDNoduR6weX5k6DxwMaJVQKc2vQ9Of4LmENzuYihAQJTyVOX3/lXjB1xTTFjfFLZWawbV3w
 lNsL/eNTSOWbNkOGfAhkww8qdaO+ZbiNU8rARpAnqS9DhEPz+z+ms82ixn1fk+txx4wwKfWXV
 lLNpfDiosyOIqYNdoaf2Kj3ORP5cb9NbK67WYvqwQkhLvo9KCChpuN7DNgrT0Xxl7JJYURMMg
 HpO403Qiqw==
X-Spam-Status: No, score=-107.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 18 Jan 2021 11:36:33 -0000

On Jan 15 14:45, Ben Wijen wrote:
> When file attributes are of no concern,
> there is no point to query them.

Without any code setting the flag, this doesn't seem to make any
sense.  At least the commit message should reflect on the reasons
for this change.

> ---
>  winsup/cygwin/path.cc | 3 +++
>  winsup/cygwin/path.h  | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index abd3687df..f00707e86 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -931,7 +931,10 @@ path_conv::check (const char *src, unsigned opt,
>  
>      is_fs_via_procsys:
>  
> +	    if (!(opt & PC_SKIP_SYM_CHECK))
> +	    {
>  	      symlen = sym.check (full_path, suff, fs, conv_handle);
> +	    }

Please follow the indentation 4 lines above, and please don't add curly
braces for single line blocks.


Thanks,
Corinna
