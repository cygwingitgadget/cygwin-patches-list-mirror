Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 0450439B6802
 for <cygwin-patches@cygwin.com>; Wed, 21 Apr 2021 15:44:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0450439B6802
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M7sQ6-1leD6c0QF8-004yeJ for <cygwin-patches@cygwin.com>; Wed, 21 Apr 2021
 17:44:12 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 7BE43A80EDD; Wed, 21 Apr 2021 17:44:10 +0200 (CEST)
Date: Wed, 21 Apr 2021 17:44:10 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Additional race issue fix regarding pseudo
 console.
Message-ID: <YIBISlJOtJXk90RR@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210421030600.3793-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210421030600.3793-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:aTapiExBcA6qJLu3oB9Xo/P/XsQ27QxhxYt8Vu6zee3gS2WkGBg
 vvtjEYIOBuaY6FfkpaIfuRcchq/7GjaYFP6zZ3NKNWPAMAPeNYGeEvAye1qdeDn8y8BTWjP
 QVuF65ev+CXq2XSl2QoCTFGF4NYwImqBpGOFEO/lPQWvZ2An2J/y3ZGlZeOKdBiM9UJwPA4
 0xDWq/ADuQbUVqChejADQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9X244/am8RE=:DZSfeqSnSFouMybgpN8pVl
 feG/hd+v2WSXDLiRNPohPBgfRVKe2KiCF+7MzcdCCRXGiMRbMMyl0eOF1wWHleD9it1KjnPk1
 8GQI+06B+mVLjK2ucwZmEz2hNVIVHZzLQlqCpNjm5pyOUfOpDiKMDUV2T2653P8UKJkNQCiXU
 Op0ptCqrnPRINTup2RixHMEwYc5Q5ej95+UqhhT1/Opv7Q9WfC41I9dtC6QpMbfum+wLR7Vub
 +f0EQEMZV+zMUBZj8vSNNPaqv5vR74ktpvBK+GFXIwMvP62gewb7wvLZ+3DGUiU2YMZRNk0TU
 rB+LTcCTyxGWyMw39gxbCErz62LtJX71fTCJLFCtXM47ySFnksFFZCXvLGGpW/QZutmJsfbXR
 O1KObfCPJOvs6FQTkhODCECNA17NMAeyG0g10NLRaUJgUUi2EwFtzgUXV3UAd/yEU0c2KKrhU
 BlyMOM3TCG8XtJh58oA3OqaqLyNGcEATEcsjlk90nsTBWas25VeXgZkaMyOFszYH8lYsRNbVu
 /pOPwrzOkdTzSOiS2IQiaw=
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Wed, 21 Apr 2021 15:44:24 -0000

On Apr 21 12:06, Takashi Yano wrote:
> - In commit bb93c6d7, the race issue was not completely fixed. In
>   the pseudo console inheritance, if the destination process to
>   which the ownership of pseudo console switches, is found but exits
>   before switching, the inheritance fails. Currently, this extremely
>   rarely happens. This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler_tty.cc | 47 +++++++++++------------------------
>  1 file changed, 14 insertions(+), 33 deletions(-)

This and the other two patches pushed.


Thanks,
Corinna
