Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id C4F943858D20
 for <cygwin-patches@cygwin.com>; Mon, 14 Mar 2022 18:00:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C4F943858D20
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MeD1l-1o0xYB1HPz-00bI26 for <cygwin-patches@cygwin.com>; Mon, 14 Mar 2022
 19:00:20 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 97F1DA8096C; Mon, 14 Mar 2022 19:00:19 +0100 (CET)
Date: Mon, 14 Mar 2022 19:00:19 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: path: Convert type of variable 'remlen' to DWORD.
Message-ID: <Yi+Csy507+6UVbxz@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220314113658.6009-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220314113658.6009-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:/kwqcIJiUr/ZMC799UfsPHZD9rCrBTL8Y5rz/9bLgTwa8IY3chn
 FIl8wNghGKdaCUzCENIO6VMTBsRBnrEwOElf6UxGKpIKaKzpWBEdwYaUNURZ1L2Oj+PILg6
 yhDptmU+1yy38du/Ck3w0GQifSlNZvOyscgRAyj99zZb3s+AjOD9Pw/TfCEei16+fn06raw
 plo/9ic9RSSH1ydti4uEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CcnlRpJoH68=:mYQiHDe6wLyTCkzSxrhg6p
 ODvJJfBXJCeC7nH4iskQv3E89X66TMFBoMqFsu0zMOaeXDjtP/knph9n3iL+Jo2SUw7lyNOEa
 w+XvumFWBFAJXbEcXXZ6lltk1Wp72g7mBUghEYkh9n/AHhASqK6ml33ZFBBE9wtC5LyKq8qdt
 U3f7Jtmj+jdO5UqjsNbGbwrb6OdX3F5zm1LYpXLO59T4tnhYz6kYBxoDfPnGfwsLnnZ/dnpiC
 2/JKMIbCseK8rHaWAnz89wguBiJogvZcwTT5joPer4qn40rNQqbI2Tc35ssKsjaumX8/kbqpy
 Q233WtyMiC06b/dWSteoAuCvHQZUgf0jluk81d63D74+xS1RZpYnPsSI/usdAOTSpA6XxKKqU
 9tw+x3LfKfLfQVcBczOMn8GUJZUC2iHtlo+s1rmIq1cn5YRrmOf9itPpRI8krpzqkJrJ+xY+T
 9eC6akIkXZQgzhJcRnaI9f+sJkE5xzLpRkWE1PxkVzceZgxvG7ZiPLtF5ghCZopyic3FY/fmA
 wQBBO8yAEb3AJMbkf75W9p/doueoi3nXDcbUQ0uhzo9UXsD9srqByxU8jE+JgrZb64ppoIO+k
 RkwLtInlt8ptZ+misootT+mhGI6O9EAsVQnLlCBWm93SeP3A5rcvnF8+40Tx33TBWRjCW9lLS
 CtM5/oImNINrwMSAHjWqG99gyVvH7mOE3MFPSH//pZt31KQrhQyBe7BDQWOI/+WN+w1oHNabw
 WMjymaFUrsPt1l1B
X-Spam-Status: No, score=-102.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 14 Mar 2022 18:00:24 -0000

On Mar 14 20:36, Takashi Yano wrote:
> - Variable remlen stores the return value of QueryDosDeviceW(), so
>   it is better to be DWORD.
> ---
>  winsup/cygwin/path.cc | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index eceafbbcf..e370843ee 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -3523,8 +3523,7 @@ restart:
>  			{(WCHAR) towupper (upath.Buffer[4]), L':', L'\0'};
>  		      WCHAR remote[MAX_PATH];
>  
> -
> -		      int remlen = QueryDosDeviceW (drive, remote, MAX_PATH);
> +		      DWORD remlen = QueryDosDeviceW (drive, remote, MAX_PATH);
>  		      if (remlen < 3)
>  			goto file_not_symlink; /* fallback */
>  		      remlen -= 2; /* Two L'\0' */
> -- 
> 2.35.1

Thanks, please push.


Corinna
