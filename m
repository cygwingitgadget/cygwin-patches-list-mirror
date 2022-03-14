Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 44FCE3857C47
 for <cygwin-patches@cygwin.com>; Mon, 14 Mar 2022 11:04:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 44FCE3857C47
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N18MG-1o99CL3Qde-012ZG1 for <cygwin-patches@cygwin.com>; Mon, 14 Mar 2022
 12:04:19 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id B6D28A8096C; Mon, 14 Mar 2022 12:04:18 +0100 (CET)
Date: Mon, 14 Mar 2022 12:04:18 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: path: Add fallback for DFS mounted drive.
Message-ID: <Yi8hMjqUsMmPps7r@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220314105744.739-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220314105744.739-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:WFyohWeAF1+nWjX3N+Lsyagls0BrpNi4KoT6wdxG+j/DYarFLQe
 +I9Q0t8k8Xln/Yhy2RUEJukKXZVLJi/eQOtFjwYrL6GhdzTsYbyEA/Vm87NtOqJjykNV/nD
 pCjrhSGU2jOoWiakGYy+h6CKLeFApbrJj0UjA/U1CJP28VGIhtcO+84YYqghfR+5X0i9Pkk
 7RjaXnT7zObxeAhceiTMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VCOvlNrP5uM=:brJvuSuEhJNhbZJT2Q16dA
 F8CxmAjCmxbwF+hIOwCkiRWuTLBZZLhzyEpDzsOBk992UgmFRPSTZap3q8tiRDpJxJQDW8l7q
 Fnkm0RSx8l6/qJZKACpr4cTOEQzDyryUPCBHCXdWxVN1wa4wz5QO8BT9YNajkIjck9eJ1D0A0
 8DFINDBzEDmCktRqwYbEXxT5LTcanpGn3MGloFxw1rG9NNMDncqPOXCtD498aHwFQjZhvyFHF
 0XI8UTBs84IiNDgNtltSI2HTeZ6uCeeuh8a/9a7pwdeYnZl0a6hxOLvtIHND1YPaXeOSfXcVl
 0seVPWiCpN+8fO55QdnoMuNkEAmhW0AnzvWhMuE/JLpVaDKBDdaxq6efcSTb8ujs+yxXQXi9d
 14egc5hz00irxrxG+GJklijt0qZhdmY6N/AXJZk8SQu1hgiazbCbYwkDDPrbO+PcWQOWAjyYs
 kjYboElipa2oRz6EbHdvHOFzsbZwHlR3A1OfyzKpQp/O6KsBxZHr3a10IVb7TESlSvAUkc2SM
 JrnSLytGVlIpor8WjI1antJQx3ehQ8s6kg6hXFcwH5jv6OV4zu7INRrwO374syHo+0khJfeP7
 ue6xUKXngiKlMp89AgVISJP4YhxrrkUTlPcbPJ5bsYvhnONPVlKjcq7LZQhoIxBTz1gB1WDaM
 FnsKRU7IKh3gvHC148pz4+LBkioQbO4sbpgSuTU/7i3eq784YpxhNUJnJKduy+Ofta240Urpg
 NYuyX67YEdC1TH9k
X-Spam-Status: No, score=-102.8 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Mon, 14 Mar 2022 11:04:22 -0000

Hi Takashi,

On Mar 14 19:57, Takashi Yano wrote:
> - If UNC path for DFS is mounted to a drive with drive letter, the
>   error "Too many levels of symbolic links" occurs when accessing
>   to that drive. This is because GetDosDeviceW() returns unexpected
>   string such as "\Device\Mup\DfsClient\;Z:000000000003fb89\dfsserver
>   \dfs\linkname" for the mounted UNC path "\??\UNC\fileserver\share".
>   This patch adds a workaround for this issue.
> 
>   Addresses: https://cygwin.com/pipermail/cygwin/2022-March/250979.html
> ---
>  winsup/cygwin/path.cc | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index 4ad4e0821..dd8f6c043 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -3527,7 +3527,7 @@ restart:
>  		      int remlen = QueryDosDeviceW (drive, remote, MAX_PATH);
>  		      if (remlen < 3)
>  			goto file_not_symlink; /* fallback */
> -		      remlen -= 2;
> +		      remlen -= 2; /* Two L'\0' */
>  
>  		      if (remote[remlen - 1] == L'\\')
>  			remlen--;
> @@ -3535,20 +3535,27 @@ restart:
>  		      UNICODE_STRING rpath;
>  		      RtlInitCountedUnicodeString (&rpath, remote,
>  						   remlen * sizeof (WCHAR));
> +		      const int uncp_len =

I'd still prefer an unsigned type as USHORT or size_t here.  USHORT
because that's the type of the UNICODE_STRING::Length member, or
size_t because that's the standard type used for string lengths.

With that, GTG.

I just notice that remlen is int, too.  Given it represents the return
value from QueryDosDeviceW, it should ideally be converted to DWORD.


Thanks,
Corinna
