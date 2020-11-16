Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 7D6B1385E83A
 for <cygwin-patches@cygwin.com>; Mon, 16 Nov 2020 12:08:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7D6B1385E83A
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MY5s5-1kmW4K0VCP-00YOpA for <cygwin-patches@cygwin.com>; Mon, 16 Nov 2020
 13:08:17 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8A39CA8093F; Mon, 16 Nov 2020 13:08:16 +0100 (CET)
Date: Mon, 16 Nov 2020 13:08:16 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: path_conv::eq_worker: add NULL pointer checks
Message-ID: <20201116120816.GB41926@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201114141625.24465-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201114141625.24465-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:65dM70LnWFfiTS3XMI7AfgXzXEHAQDSFN63+DPpZgayehwNmVYs
 s/JowIQmuAy5BAvAwI0eGGWHpUBREyp+Hmr1LdapfYYlRtM00wsy4Bf/JA+RC5zaYklfnEy
 ZlFgSDc0Q3+VdhVIgUxWAPi3WRyPe+BhyXRfjz0DlSGkluMe2NkAP92ehtok5LfJ/PH57CQ
 r5UsTHG6x5D7FfuvmgDqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/0GQxa03z6g=:Q6V5nKCHLEvSZ9QXL3ks0i
 +YTOvI2Xtw2QEC1kRZVZBjNr8nvSG0gf61JK4o4Cr3xh69gXqdZ4jpA+M7XEgErc3/a9qn9Pa
 usXyFH1ulvQf6doFbP3n9F5peh9gh3aATD/rLKUJyWsNt5v2VDWzIbzo19ToCHwN+4euzj+ET
 3W2FiC4XbVpT+pDpOE5/THdKFUTmxkBeJcTb83ZSpDCCz9hZUbifjQhV37Lc8O7wGN2TGbxsm
 KOJDdsEEwgrG+5XQjuxBjGoDUdw2nAg/G8CrFe4ad0BsG55nXXREyVjjcboRSf2XzvcMLFU4e
 +1zPOLkbWTxCMi62j6QuJzs8Y1xgHT241AxaLbBWwYF6PQ/Q4YZmyyLabKGzbXlTxTzoUNhD+
 mkvqORaiu0BqIfLI7FPdgGuFiZ2eR9BxtMwtm9PHcU9eUp80k2LAI4h3r6RbPmOUIiRDzvnhA
 213QdBa4pg==
X-Spam-Status: No, score=-106.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 16 Nov 2020 12:08:19 -0000

On Nov 14 09:16, Ken Brown via Cygwin-patches wrote:
> Don't call cstrdup on NULL pointers.
> ---
>  winsup/cygwin/path.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/path.h b/winsup/cygwin/path.h
> index b94f13df8..0b3e72fc1 100644
> --- a/winsup/cygwin/path.h
> +++ b/winsup/cygwin/path.h
> @@ -320,9 +320,11 @@ class path_conv
>         contrast to statically allocated strings.  Calling device::dup()
>         will duplicate the string if the source was allocated. */
>      dev.dup ();
> -    path = cstrdup (in_path);
> +    if (in_path)
> +      path = cstrdup (in_path);
>      conv_handle.dup (pc.conv_handle);
> -    posix_path = cstrdup(pc.posix_path);
> +    if (pc.posix_path)
> +      posix_path = cstrdup(pc.posix_path);
>      if (pc.wide_path)
>        {
>  	wide_path = cwcsdup (uni_path.Buffer);
> -- 
> 2.29.2

LGTM.  How did you notice this?  Maybe a pointer to the problem
in the log message may be helpful in future.


Thanks,
Corinna
