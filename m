Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id C567D385801F
 for <cygwin-patches@cygwin.com>; Tue, 18 Jan 2022 10:32:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C567D385801F
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N0WPK-1mMBPS02ia-00wYeZ for <cygwin-patches@cygwin.com>; Tue, 18 Jan 2022
 11:32:50 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 40107A8096F; Tue, 18 Jan 2022 11:32:49 +0100 (CET)
Date: Tue, 18 Jan 2022 11:32:49 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/5] Cygwin: resolver: Process options forward (not
 backwards)
Message-ID: <YeaXUdGyYg3uirHv@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220117180314.29064-1-lavr@ncbi.nlm.nih.gov>
 <20220117180314.29064-3-lavr@ncbi.nlm.nih.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220117180314.29064-3-lavr@ncbi.nlm.nih.gov>
X-Provags-ID: V03:K1:NkSammYISyVdtQSUSaYPrpR7NoS03HXf8Rvt9njfgkG81JdoeeN
 6WyS6O7bww+exjSzHZkLd3XOWwNDLgbbTNjRLBRtzSr+P+4RU0FMNEzwY+5AtyoIEU/2hkJ
 E9mbxilITGdKMVltok2qazb7xClrePLe6+nT8h0+QFVTw58y0jOWCBD0y+fJ1gmzJYHFokU
 SEgeTvMk/6TeHX+kf/mxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fY08pv9KyjI=:hEIQzYYA5N38Zw8Fqwc1ba
 UqDxjAfinsxGeFVWNPz7K7VyxyFHmV4Y6t2yu2SEPOQyfTk9K2xi8u1U1E4lbcRheYC2dEOxf
 gxGHn2eJ8WzgYQPEXvskTGA6A1N6/4QT4Ut0yGbuTJ3qnyjPhfWRnyQM0aXZ/C3EBOX2UAwaj
 S+f8n3GxT1PBbZwRWt4nfDQt49RaAaG7dp1r5j3xgBn613tplHppy7vanEqVftPb0QcLAIf6h
 tSqju8OvyXjv/NIzicCmxmQWye+Cv++48XLGhAZCTevDWeziSQPCuhw7xhnIBXgbrYA5HQR9c
 /xrMVIP5VciDpeq05GKYYkUQFMaokU01eRlnHPfxv6ZO/BXcooQEkSvJerXcnGsKghvj7LicV
 6jY1V5oSvoSY/at7RMS/e9QKKq4IVv3TT0sFnpKE38DDJcAk0n9iCSqqt0b10XyiWUvPwGOsm
 M0R+ORqHaqWQ2LwZXP4VO00juvZdQ/++XZkEOELtjem1595Cbp8oBgYszOrKII2sZF9iOzkpC
 4DIploUWdNepY6ZDwARmvvwPC44oRpsFcsPy+O40rwIsHO423kVLW/F0uv0wODrwXc5r24QwZ
 0GO6fe/kRv0EOujs2PzCG9KLeDRVT/5IIVZo/3jfwk1EA6jRy52xj02mtYkiKxMsUZH3ghcOe
 e7UGQkrnH2uIqq1VwEepXADxyOkTjb2AdLfX5ytwnAGUbqXSPRvcTNoAfgxcOsyKnErZeFmuf
 pUnvnhYBPGIsHsaj
X-Spam-Status: No, score=-102.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H5, RCVD_IN_MSPIKE_WL, SPF_FAIL, SPF_HELO_NONE,
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
X-List-Received-Date: Tue, 18 Jan 2022 10:32:53 -0000

Hi Anton,

I pushed patches 1 and 3 to 5.  I fixed the consitency typo
throughout.

As for this path 2:

On Jan 17 13:03, Anton Lavrentiev via Cygwin-patches wrote:
> ---
>  winsup/cygwin/libc/minires.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/winsup/cygwin/libc/minires.c b/winsup/cygwin/libc/minires.c
> index 0cf9efd9b..fdc6087f5 100644
> --- a/winsup/cygwin/libc/minires.c
> +++ b/winsup/cygwin/libc/minires.c
> @@ -86,12 +86,12 @@ Read options
>  
>  
>  ***********************************************************************/
> -static void get_options(res_state statp, int i, char **words)
> +static void get_options(res_state statp, int n, char **words)
>  {
>    char *ptr;
> -  int value;
> +  int i, value;
>  
> -  while (i-- > 0) {
> +  for (i = 0;  i < n;  ++i) {
>      if (!strcasecmp("debug", words[i])) {
>        statp->options |= RES_DEBUG;
>        DPRINTF(statp->options & RES_DEBUG, "%s: 1\n", words[i]);
> @@ -208,8 +208,10 @@ static void get_resolv(res_state statp)
>  	}
>        }
>        /* Options line */
> -      else if (!strncasecmp("options", words[0], sizes[0]))
> +      else if (!strncasecmp("options", words[0], sizes[0])) {
>  	get_options(statp, i - 1, &words[1]);
> +	debug = statp->options & RES_DEBUG;

This addition setting the debug flag needs a bit of explaining in the
log message, me thinks.  Why was it necessary or why is it better to do
it here?

Right now, the debug flag gets set in several places throughout the
code.  Given you set the debug flag above, doesn't that mean several
code snippets setting the debug flag later in the code can go away?


Thanks,
Corinna
