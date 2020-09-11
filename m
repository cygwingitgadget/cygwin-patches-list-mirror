Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 618F0398603D
 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020 12:08:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 618F0398603D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mxlmw-1kSL3e3ssA-00zEXu for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020
 14:08:40 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 4215DA804E5; Fri, 11 Sep 2020 14:08:40 +0200 (CEST)
Date: Fri, 11 Sep 2020 14:08:40 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add workaround for ISO-2022 and ISCII in
 convert_mb_str().
Message-ID: <20200911120840.GH4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200911105401.153-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200911105401.153-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:aI4zsNW4sblOqcmnEn/VxkCzPpFuwQTNO1aSO4k0FNRI0Q+PRWr
 /7tvsypQpcXSkY4QsRoZSnh3hcMYfSfK8mK7D6Xt2mMIE39oako33W+mnqyp/jsyyJ17DMY
 +gplfqApxnI/vgNcmBMCrPEkUlM8uBuzwd4PMisFMZmp+jEzCb50ECgpGzjrQeZdVV9+RrZ
 pit/m3QN9pR0FwSCqdw8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wdeS6e65qpc=:WIlbN7NMCdFaIb2R8Kbit9
 s8ew6mxfxwxOT6Y76YbcmSiBHUaeqafzC9/yTerQbxv8CvYi773etrVRrGxeCFUl6SGK9SA11
 NikDoEA4Hlf7UiRmQKfsZ//jvdT+Ti0BdhdepqpHv4O/7gHXTAa6CWbW+wvC3LUlxD5jBd3kR
 Fsyjeng0oP+36W5ZI4KbNAVaI7huGcHae4HxTdomXLhRzr6iNUZSSUVK1ZFJoMUhdimWQo32F
 DI/4wsFuQZb2+rUJGwBv6KVKEwK07WGnEaMaKIb5M30NXGZzBot/BjwuBd6AphEvWWVfh4Hm4
 e0tEp0IVac+pxXChEMIJUpIi9KkTLv9n70OVpUSZbswPQ+jh+t9O9rg0KwvSfoDbFFlZ/mSV4
 SQPix4iVYMHMIAq8iFoxISA5RuwWEhN7GHeEJ0uh6zz/53cuDwsxvnHcP29SVxfKBcrxs1tSh
 0Obco7ZeFOn2Zk0+2IQAfg2RmlqI1mi63U7vcs2vzgQOc+oEckeacZeKvd38HQDdiu6mfFtZa
 ou64ULtp492JbfPTdqHxm5svYicVRxT6qkaC7zoHHvaZ7vINm4lz815ESCXxiQp/9fU9bpoHf
 /nr03y3eWdjTtCjEAxt4CxxBaG27iVSFqVVVX9Q4h7mfGSgCJie2OX3mIxnYMM8vpV8ZBcIpu
 K7u4EtciMG2snnhbxIRVaBOoDkh2B0sBFH2Evbw3xmyuz502naEU81hA/EOv11M1MGFXYNhez
 NY6Z5n78QxCgGhXEO7sM1Zs5GcCdagRcg56Qs5LvFnrdIGeltLPlq5O8HPlCQwnEs6CERMQ07
 QhFMDfHEz+8+CgAlYiT1FLy2MEyxq35u+cxkG8XsvUxCEyrehlp+wA4947SHIiTrc4e7csiJU
 p+afDQ3wff86fQ+H9uEw==
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
X-List-Received-Date: Fri, 11 Sep 2020 12:08:43 -0000

On Sep 11 19:54, Takashi Yano via Cygwin-patches wrote:
> - In convert_mb_str(), exclude ISO-2022 and ISCII from the processing
>   for the case that the multibyte char is splitted in the middle.
>   The reason is as follows.
>   * ISO-2022 is too complicated to handle correctly.
>   * Not sure what to do with ISCII.
> ---
>  winsup/cygwin/fhandler_tty.cc | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 37d033bbe..ee5c6a90a 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -117,6 +117,9 @@ CreateProcessW_Hooked
>    return CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
>  }
>  
> +#define IS_ISO_2022(x) ( (x) >= 50220 && (x) <= 50229 )
> +#define IS_ISCII(x) ( (x) >= 57002 && (x) <= 57011 )
> +
>  static void
>  convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
>  		UINT cp_from, const char *ptr_from, size_t len_from,
> @@ -126,8 +129,10 @@ convert_mb_str (UINT cp_to, char *ptr_to, size_t *len_to,
>    tmp_pathbuf tp;
>    wchar_t *wbuf = tp.w_get ();
>    int wlen = 0;
> -  if (cp_from == CP_UTF7)
> -    /* MB_ERR_INVALID_CHARS does not work properly for UTF-7.
> +  if (cp_from == CP_UTF7 || IS_ISO_2022 (cp_from) || IS_ISCII (cp_from))
> +    /* - MB_ERR_INVALID_CHARS does not work properly for UTF-7.
> +       - ISO-2022 is too complicated to handle correctly.
> +       - FIXME: Not sure what to do for ISCII.
>         Therefore, just convert string without checking */
>      wlen = MultiByteToWideChar (cp_from, 0, ptr_from, len_from,
>  				wbuf, NT_MAX_PATH);
> -- 
> 2.28.0

I'd prefer to not handle them at all.  We just don't support these
charsets, same as JIS, EBCDIC, you name it, which are not ASCII
compatible.  Let's please just drop any handling for these weird
or outdated codepages.


Thanks,
Corinna
