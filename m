Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	by sourceware.org (Postfix) with ESMTPS id D3F2B3858D39
	for <cygwin-patches@cygwin.com>; Tue, 28 Mar 2023 10:17:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D3F2B3858D39
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MAtoX-1pajfU3gdd-00BPOn; Tue, 28 Mar 2023 12:16:57 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id BFA74A80BFF; Tue, 28 Mar 2023 12:16:56 +0200 (CEST)
Date: Tue, 28 Mar 2023 12:16:56 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 2/3] Respect `db_home` setting even for
 SYSTEM/Microsoft accounts
Message-ID: <ZCK+mOdyaAQnLBwF@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	cygwin-patches@cygwin.com
References: <cover.1663761086.git.johannes.schindelin@gmx.de>
 <cover.1679991274.git.johannes.schindelin@gmx.de>
 <a70c77dc8f0d8417537557ea8e3a38f85bc582dd.1679991274.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a70c77dc8f0d8417537557ea8e3a38f85bc582dd.1679991274.git.johannes.schindelin@gmx.de>
X-Provags-ID: V03:K1:nUK/yjQRddZAytgKuZE9Agx9i4ESFoZNvW/dn5LHcLwBLOE58C/
 k0gA6hwlu0UbE29ucv/kyKRuKOJX6C3FtwWIJ7mRaRJy2jwxiuZ1ebJdSrmikDi5tgbFPQF
 mbndDzcmSQ+fyjROCQ4HHOMWuYW4cYGwdFGdyng65tBCnIeAZBPqbmauVobg31+3C/ZYab2
 CZGN12oVc16n67l2efGwA==
UI-OutboundReport: notjunk:1;M01:P0:flcDPGQGtxE=;o0tf4gBSCRULZz/VY9fL1YYyYnx
 DZBdPBfRchFx0Oq2qJ3MtqeTlTPSBMJz2mc0pMCwFHXyCVI9WtUVrJ870Zqokm6S8Fv4xU0HH
 R0j3aE1hzSP1BBAIJOZyrfhoU80TBPbS/qBbk6GY1cqPWc4iN609BNQPIgKlyaSUWTYAWwezp
 lt+XoxMVWOLYW7DQ9Og954oSHjxWwY08NU+ijUxTS9FA+IA2esOREKP+uXTdmLiLznua4RUf2
 +soaqzQ3oOp5mAzCjI3XLegxzJJykPxM16v5BTi4iu/KjengynICvbx2YebaSX3fKOKdoqjW7
 4gSH51p2uhkvgoRClWCdsAsQxomOlJSSf8oDvOaA8DrcTFhX8ow95Qs7/vPi8TnsgWSPpPy84
 Cyh9v0P5YNKeoBoVTV5E6TtRbO5Bw54V0u/0fpHVkO9T2FcSg7d6fPyU4+U0bSfLDbg4KSBZP
 qF2/dSZVPcWR5eU9tz6tTkPjqLMJV6587QXo299KQbBC5Pgo8sFQ1HBBAmm/FDviez4PWhQdo
 EALc1d9xtO7OFfoj3IOzBKrMhUtOC5rFB8Oie/1h00jj+U9LwkHPiX1bkOs/6qWXMu+4CQ+C6
 RKV11ckleG39zKx+2hvxqeCubichpcZZ3WYd0ElGR94KSGZEgkVj2x1MfD0N+xnpTCVd8Qu3G
 +ZAIWEECk7bs3FZLeW9gZ0ddzXrEzM4JivzhxYUPqg==
X-Spam-Status: No, score=-103.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mar 28 10:17, Johannes Schindelin wrote:
> We should not blindly set the home directory of the SYSTEM account (or
> of Microsoft accounts) to /home/SYSTEM, especially not when that value
                                  ^^^^^^
That should probably better be <username>, no?

> disagrees with what is configured via the `db_home` line in the
> `/etc/nsswitch.conf` file.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/uinfo.cc | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> index baa670478d..d493d29b3b 100644
> --- a/winsup/cygwin/uinfo.cc
> +++ b/winsup/cygwin/uinfo.cc
> @@ -2234,7 +2234,11 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_t &arg, cyg_ldap *pldap)
>  	 it to a well-known group here. */
>        if (acc_type == SidTypeUser
>  	  && (sid_sub_auth_count (sid) <= 3 || sid_id_auth (sid) == 11))
> -	acc_type = SidTypeWellKnownGroup;
> +	{
> +	  acc_type = SidTypeWellKnownGroup;
> +	  home = cygheap->pg.get_home ((PUSER_INFO_3) NULL, sid, dom, name,
> +				       fully_qualified_name);
> +	}
>        switch ((int) acc_type)
>  	{
>  	case SidTypeUser:
> --
> 2.40.0.windows.1
> 
