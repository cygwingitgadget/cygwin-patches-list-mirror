Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 0DF9C385781F
 for <cygwin-patches@cygwin.com>; Thu, 11 Nov 2021 09:10:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0DF9C385781F
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M3DBd-1mi3pS2989-003eHQ for <cygwin-patches@cygwin.com>; Thu, 11 Nov 2021
 10:10:39 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 09DBBA80A5B; Thu, 11 Nov 2021 10:10:37 +0100 (CET)
Date: Thu, 11 Nov 2021 10:10:37 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Fix raw_write() for non-cygwin pipe with
 size zero.
Message-ID: <YYzeDTmhDjm1nCsD@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211111081923.802-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211111081923.802-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:2t3x6FDTl2PdbaHwA139sNy214F4KTLVGY+GdvW3dhLvZbUohUQ
 yrVeoAJcqbpj9lE/q1JksrxfUNqOLolrtOqJBGUaLrb0mjgeLDqoMrNdECXxXRE0udXTU8d
 pCgTyG+Sgrp1IihBiVOzvMDunUuDLZu/IYRgmMpD//QaxVU1rSeP2o6erBMap2gHA3Ii5Zd
 p4Cx8QqIz53UlUC9zy3vg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WwJxJE32uuk=:hjQv+6UfOd0ADsEIzby1LD
 rIVBXF4+LhJq65kli+ipkYYJGHIA4T+Oa5JSF1LQ7YAI1B0BpY1KPmqu0Ef6YOo83aQ3bSMSW
 8fQJqO7Ni06coSMzLoYdTTXrtiSnrDjUkGXsNxNcfoLctJ9X1s1p676lwAgEqjY6Ar/jEz6rQ
 pQ6+WmL6GbTpTm2VybPolvDH540odrj8O/gvIb3dZk6D9EW33QIaxS3U6F+drksO+N0y/kERh
 U3oa1ZnNNzU4nXpa4bvXCsNaXoVoKkxA9Za0fwf+eog09xd3gFg4LjwvZjNx6FoHlA22IFxCf
 jvlyHy1kV1S7Y3yBo8VcXwNq0B8WrhKx/zU8Z9h8Y3Ank2Q47Y23D/J7UTM2GsvechebExo06
 pHAVa9+lsmd0DXpXkzIMFj0WxNpQxemnqlHs4Mrxq7eHpXNKHt/3hIpN+FrEV2OOQkgquBE8v
 uTu99IoE0V3EyY4Jjw6V4RnJkpQe/SOMdRdyU9u2V3CKJTYSIrxZEizJpNaBlR1jeeP/cXWrc
 MdoveJQi9JH7XxPYoyPItZR9uIHrTXGoZHjn4Vb+gGSilj8NnMSbryMwyAzW4opVtxBBGHcrQ
 RBdDC8VgavAsj9sKkH9Mqe7XtAgAuHpEW8P5GNlcAlvOtm93OTCxCKaEy+ZiN8nkYNGg1tl9D
 K0iA378og4OJUIpLSAk1nw7C6EsGSW9eLCca/kWzOhc98BU+3LNMLJGGEOcCdpWIVEsDya1rm
 WdjVTB4IqbAQDCwW
X-Spam-Status: No, score=-105.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Thu, 11 Nov 2021 09:10:42 -0000

On Nov 11 17:19, Takashi Yano wrote:
> - Currently, raw_write() fails to handle size zero pipe which may
>   be created by non-cygwin apps (e.g. Windows native ninja). This
>   patch fixes the issue.
> 
> Addresses:
>   https://cygwin.com/pipermail/cygwin/2021-November/249844.html
> ---
>  winsup/cygwin/fhandler_pipe.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler_pipe.cc b/winsup/cygwin/fhandler_pipe.cc
> index 13731437e..9392a28c1 100644
> --- a/winsup/cygwin/fhandler_pipe.cc
> +++ b/winsup/cygwin/fhandler_pipe.cc
> @@ -449,7 +449,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
>        return -1;
>      }
>  
> -  if (len <= pipe_buf_size)
> +  if (len <= pipe_buf_size || pipe_buf_size == 0)
>      chunk = len;
>    else if (is_nonblocking ())
>      chunk = len = pipe_buf_size;
> -- 
> 2.33.0

ACK.  Please push.


Thanks,
Corinna
