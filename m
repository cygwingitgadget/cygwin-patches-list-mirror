Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 40000386F001
 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020 12:09:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 40000386F001
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M8QiW-1kCK9Y41HE-004T82 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020
 14:09:53 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 927BCA803FC; Fri, 11 Sep 2020 14:09:52 +0200 (CEST)
Date: Fri, 11 Sep 2020 14:09:52 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Prevent garbled output for existing
 non-cygwin apps.
Message-ID: <20200911120952.GI4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200911105440.199-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911105440.199-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:zjg0wZkhQM3gV1lWn5I5KtbVIE1dvA9OYDGJyTMzCXlwpNPDsmT
 RCkyNNHS7V6el7Zn6S59jij29mUYDHxO8isT6J3C9AkzRoldpVA3uvrxgMoSLO7cwyzF15A
 kEMor0/x/hHvTmqJliX76GTaXPCaj9y1lxqUJeJzjd7N8UeG37PLi7edXcQrbi5vn7NzKna
 T4+7e6+TV49ejWx1g65rA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ezTaSpI5vSQ=:MaKUUnX2MRtdMt34yD+kuX
 PUeYfmg3T6kztJv93ttdlH9ivAA67lxFGkkNu8CxxDsJQaUtxQ5fozj+joo5YT0qJrDxiicC7
 XA/khnKpbouVZcrvyC6gvppQdNyGto6zoRibMwVFVY25xA+Jn7npsV1LEYs6MMi1sa8DxacA+
 P8ljSMuBjEpa7W5cnWzbrMWyprChbTBiZhIK2W2wPPkPJhi+hrlS0cfmRceYQ/w7RvZu/ErPE
 3VvLxJIhJcuklIzRvyA04UMvXKhg7lX9RMpv5C7lPhnZqg9Xgarcml40O04vKzn8Z6GmCtUVM
 uD9XgweoiCrnIy0WpzK82jX4RK0aivzjOBN9WZVc3ZSfmhE4e2yUh+4lL/9IPcnpUu/cQfwz9
 oo2Egea6WU56eH6cnVT4qSIQ/1jt8YwVS0OBOoB+F0Y8LMTJltro/muMyzpSZY/cpEw7c1bro
 ZriK4WG2wJc/fSpt176VhFX1q04jAdeFZBPfzXRxCWWhkAK9PMVlie7WsYRHZcs06bdWPnx3y
 QnY6+K0Nbx+DZJOAsaQfJDDDMjh70n111ZVRDmjpQg2odxxpTbjUCPEnkiPcRjogEz/iZ3R9J
 60geEOdlSBpThcMefZOIPm+pQTEm1N5NfzOmTOi08+L84px9rlORjprw4ciMrfwHTge2IhQWB
 HTMG9WssZQFRKVFtzesrlKkvRQUS72AMB/6VYMq78W6SrLHY7ri9eNhKogbTc0HfCe9jjTbSO
 3nkjpMcysWPUecIlhwDICG3IVY9BMj80JtijKMW+ClY0cHgS3gHRb2Lgyc5Ay4RAjrRvX+jL2
 4LHMLiXeAT/AvaoiVHZIU4QBtfLiCCOBezaxS7su6j4QRY/I3kZfotEkgb/AU0cqe36rqILNK
 w+yI/Lq2jNRlyls5yjjg==
X-Spam-Status: No, score=-105.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Fri, 11 Sep 2020 12:09:55 -0000

On Sep 11 19:54, Takashi Yano via Cygwin-patches wrote:
> - If pseudo console is disabled, non-cygwin apps do not detect
>   console device. In this case, some apps output UTF-8 regardless
>   of the locale setting. At least git-for-windows, rust-based apps
>   and node.js do that. This patch provides backward compatibility
>   as default behaviour by setting console codepage to the charset of
>   the locale. Even in the cases above, garbled output is prevented
>   with this patch in most cases because mintty uses UTF-8 by default.
> 
>   I beleave this is not really a problem in cygwin side but that in
>   app side, however, some users complain about garbled output with
>   existing apps in MSYS2 (which is based on cygwin) in which pseudo
>   console is disabled by default.
> ---
>  winsup/cygwin/fhandler_tty.cc | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index ee5c6a90a..3d93bef30 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -1835,7 +1835,11 @@ fhandler_pty_slave::setup_locale (void)
>    extern UINT __eval_codepage_from_internal_charset ();
>  
>    if (!get_ttyp ()->term_code_page)
> -    get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset ();
> +    {
> +      get_ttyp ()->term_code_page = __eval_codepage_from_internal_charset ();
> +      SetConsoleCP (get_ttyp ()->term_code_page);
> +      SetConsoleOutputCP (get_ttyp ()->term_code_page);
> +    }
>  }
>  
>  void
> -- 
> 2.28.0

Pushed.


Thanks,
Corinna
