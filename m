Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 80CC6385842A
 for <cygwin-patches@cygwin.com>; Mon, 14 Mar 2022 09:50:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 80CC6385842A
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MNL2Y-1nn1Q03GLS-00Oqh8 for <cygwin-patches@cygwin.com>; Mon, 14 Mar 2022
 10:50:26 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 73F4DA8075A; Mon, 14 Mar 2022 10:50:26 +0100 (CET)
Date: Mon, 14 Mar 2022 10:50:26 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fsync: Return EINVAL for special files.
Message-ID: <Yi8P4sOhvgEuJ1oE@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220311213707.1463-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220311213707.1463-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:cRghsnjYa0bUXDDlg7Ii1tMs5caiiDPxNnp+PG92cc8C7Gnx/DH
 pg1tpztsFgwtjwnzyhW06UyqbiV/ohZ9MvY5mfLz/S+jQeEY+Wwxlad0DAuYHEEdyRO4GuJ
 j1IGXeUMfTpVha0inZDJnohbcH/KwVuEvZGKvnfKrf7v53zBwU+fEl/RQHAc0wInRoy8Jwc
 emZO1Ola4mYMElhwAzgOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9RQYx12gN+c=:4OXxY74m4rmhSIVPvRlV5q
 tFZ9xUDw9+08tH5/K84p9XeFyRzimcQ1nW2WUNGJ5G0SkZ17WUIWNv5YYWSoVdRptpZtL/pE4
 F20su4TqGlD/ZBxXatAp7Fnpn+Z+wlHOH20XUcE+VjJqg1e0V3fNmweLgE/KWOKjg0x5sCeX/
 J8KIPXMFk2zeOiMElbWrMDUF9vgHCWBcZStIlP6naLcf/K36eyn1v+2i71Qu7ZpzZEyiamvU3
 C+/XHUueFlYneljA6D+/OaMNfqfo+pi9ErAQm8c8ZOrsdaJiAs3Wbwxe1795UXFZ4w8psUO95
 sA1sc/Zoqfr3q9hu2DWXFKAdtaZZau5vV1sbCPz+RZ0Oe2hsvAQaQdpnN++H9zt05c8WYzWTn
 +WIsel/8zlNzQwertPwU/onfreRkRLCsuaHpklHUsiFaAn/A93NfGpZLQVRBjqLX2Vp48AkFF
 +ti2cyyCIovc3McqCQUZ+hAcm2BlKZR18y3sOOLYyljcMoQlwJMOHlDzZOrSzZxD5gW7t1g9y
 XWvIUVdS5vlOvmQKneL+9cja9+3hg0j5xhTXswP9ocXv3xScVPpfLw0NWKQ69QXzWUmI68yL+
 U1K0AZhoc4kmxODTn4M6q3uv5uZvt3uXJVWQIQzy6jUjCGHUKOwqzNAj++W73blUBOHEGoub4
 tWQesGnxtOjX3VoLB5ZipuSszjoPsl29p3s9A3hLO5tlJXEj8a0a295h55JjJlXtkRMD/EGPC
 ZKnJO/px0vbFtCgV
X-Spam-Status: No, score=-102.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_FAIL, SPF_HELO_NONE, TXREP,
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
X-List-Received-Date: Mon, 14 Mar 2022 09:50:30 -0000

On Mar 12 06:37, Takashi Yano wrote:
> - Unlike linux, fsync() calls FlushFileBuffers() even for special
>   files. This cause the problem reported in:
>     https://cygwin.com/pipermail/cygwin/2022-March/251022.html
>   This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
> index 98d7a3b2d..fc7bf0a0e 100644
> --- a/winsup/cygwin/fhandler.cc
> +++ b/winsup/cygwin/fhandler.cc
> @@ -1750,7 +1750,7 @@ fhandler_base::utimens (const struct timespec *tvp)
>  int
>  fhandler_base::fsync ()
>  {
> -  if (!get_handle () || nohandle ())
> +  if (!get_handle () || nohandle () || pc.isspecial ())
>      {
>        set_errno (EINVAL);
>        return -1;
> -- 
> 2.35.1

Ouch, yeah, that's obvious.


Thanks,
Corinna
