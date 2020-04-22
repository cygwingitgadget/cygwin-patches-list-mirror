Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 8AABC386F43F
 for <cygwin-patches@cygwin.com>; Wed, 22 Apr 2020 07:36:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8AABC386F43F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mmhs6-1iywNQ10i6-00jmmY for <cygwin-patches@cygwin.com>; Wed, 22 Apr 2020
 09:36:18 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id B3C59A8270C; Wed, 22 Apr 2020 09:36:17 +0200 (CEST)
Date: Wed, 22 Apr 2020 09:36:17 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3 v3] Cygwin: accounts: Unify nsswitch.conf db_* defaults
Message-ID: <20200422073617.GC1654005@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200421203106.00002fd7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421203106.00002fd7@gmail.com>
X-Provags-ID: V03:K1:mTuGc5UQK+45VjIa5DIlRWoyE0AjUgGxn5Fn0CBJedmxISWoXSl
 g8f7hDRn9JKWA+tr2YxgdFEcrKBGfrB8DnG2MtXd8qWj9f1iFkxu/u+OHPCSbZePEyTsYor
 QnRuJs9NoiRZqsReDpAffc5eMy5iOj+cTVELIRI2P4vFRakogLbUILPWQlaVhkSN6qEn18T
 TANZUchAbQI+ntRRUzUlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dCDN8bAtqR0=:Ou//Qmw+kLKOdQ7NMp6pUy
 UmDJpZSTIVYfs3YAPVU5MzuGuctyxfRbKfchJiO9idouiB8O1QxGPkoL48EWYx5DOai95hgGb
 D0Oi+7t53QQM3aEa0Iid342wXsJw1JdS4KCKJ4DziIpwHoUErrt7dLvldP7uSucpLPRaErPX3
 xzXmpUcRtpeTptpWKWhcP5Ure3EMgxTGp7oEwhZQj/8mThexYMhnvgQUDy01KqIOXrvLfCBAE
 7+eCTCDRHsv+Ek4OjN4l+XfoEHGF87jomhQOMR1384kvxZdRezWxmEzV7LLqTjhnGRmw6+CVZ
 bfANiNYcrsjnnFFEmxoBoGMd7DkdoYAdHM0U0dHdhA15yJ7fiXJUjPEKKN5P4FtBiwWscvN8f
 4mADoC+II5GwTx9pJtm++oDafPzvuT4LVsJcbp5dCpcFcwGIOX96+rkSA1NJPqz+YCstLdIk6
 45MGDc/jCDhskIili14QBepqTJdy9AZdVWwBmwHImsPNg82mIm4By4922gu8YehXMk8bGYpbR
 n1ZTzgvIbkvpVsa5vFixBfgHVseftONvCOBWqBq7ftBYXs1bbgQvjNAOjOsBbRBKw/BB2ebJk
 ndXh4cyjNXJsPrbJiN7QxeliSi4nMNC3KiT2Sg8gKOXFn9NGQuLKTgUNshtggyV5WR0SsHpCM
 cUCeKqn1cF7oWBpswtRG5nclfKKuqVAxH6lN9NeaA48/hFAjRmwHyVnEyFtYOFXNCNLppZQKa
 z//r/7a22JgSatS/YRswpwfl/cwTzHrRQ6ggN9eCWSEq1yzMpXOqUzelKRWbfdJVMSPPsQWnV
 7GNuOj1weql28Zzc/O9j3p4weK0RAey0njGVjl6dSf4TGFi8n7OGNCmTThjXF9JDV0km6LS
X-Spam-Status: No, score=-99.6 required=5.0 tests=BAYES_00, GIT_PATCH_2,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 22 Apr 2020 07:36:21 -0000

On Apr 21 20:31, David Macek via Cygwin-patches wrote:
> Signed-off-by: David Macek <david.macek.0@gmail.com>
> ---
>  winsup/cygwin/uinfo.cc | 11 +----------
>  winsup/doc/ntsec.xml   | 21 ++++++++++-----------
>  2 files changed, 11 insertions(+), 21 deletions(-)

Thanks, all patches pushed.


Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
