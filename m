Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	by sourceware.org (Postfix) with ESMTPS id 07F973858D39
	for <cygwin-patches@cygwin.com>; Mon,  3 Apr 2023 18:37:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 07F973858D39
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mbiak-1qH4qU2f42-00dEuL; Mon, 03 Apr 2023 20:37:04 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3E142A8190A; Mon,  3 Apr 2023 20:37:04 +0200 (CEST)
Date: Mon, 3 Apr 2023 20:37:04 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 2/3] Respect `db_home` setting even for
 SYSTEM/Microsoft accounts
Message-ID: <ZCsc0EHN3bmWGyId@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	cygwin-patches@cygwin.com
References: <cover.1679991274.git.johannes.schindelin@gmx.de>
 <cover.1680532960.git.johannes.schindelin@gmx.de>
 <085d4dd8b67f603f0de49999d8e877a27a6751e1.1680532960.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <085d4dd8b67f603f0de49999d8e877a27a6751e1.1680532960.git.johannes.schindelin@gmx.de>
X-Provags-ID: V03:K1:/QuiAosYrEIYxHXpS/rXk1NiYgP2wLvtttAd2djKpF1O9JU40CA
 uAqTWVuCSvpreQl7NS5EHz3WWalRtCXDPpFq1UfTsEp1JYDNqyS8HEkZHf9vbRH9gntkIqn
 Yds+zCd46Clw4SsE3UpI4SkE9D1Y5hYYlO1L2dikSk5SB6/Ku6Ufzxwg2EqOzK9m8iNVbfC
 surydXW0RpP3tn3WamrEw==
UI-OutboundReport: notjunk:1;M01:P0:o6hpNEPvmIU=;d7ocerPLOXFYDnLonb6+Qx/spUU
 pHufmPYdAXAZdk2YtccQFj3P8hAZlyCMBaHuP7aynpdMKxrKx+rBgkGzxrG1QR0qOn64oTyo3
 M6KNllnu1l7ZxUOx9LVv4bZ/iVqRUJ504zS02VfBpOJBgwEueLwsxq3tOfS/UN93Oioey/wst
 KaQoh4LZbnrmtJ5663MzpDfLmlMZzseqoku+mPVtJLCX086ysBEiIutGHZCv8jPe6LBfAdVSD
 LEhYG9V4KmWp3wVHSh/txr1KhWJ4ODpIC3T/0bmqxHsn6I+r/E657NxX2/pOfSJttyT5ziLkr
 ICJMbX9Z20AB1udE7FkxnUN855cl6UYJ3pdZU36I2JMGeXehCCdZkKi7ZpbQUI/yRRvBoztwQ
 QM0DzpVBPOkJ3FauXS8CzHVBXXUTegiQdGgM1BWtrz8mjk+DIjn5nc/AynIZW7BfScH4N9DSi
 SlosYpx6/cQakvKctKmXVAENYsGIgh1++qy+F9Dp9QPzMUzYE7q53SC0jW7/RMqcSPnpIfQuR
 IySZ2ea/PjhYRaqnkPlJMft3VWTdINZT9U/bXEDZ421oskzW4+4xHMkWPu6VHfn2Vr0tz0vrP
 x9/4e+wSbRe2SdNeyhJMPAo6u37c/O5bivDX1lhpk2DCUDA0X9Wf1WIJqZ7d82+LKjF1eOan3
 B6Xegvi0Gc+ogBz9trwUZLAATJRZDK+DKRrarELtzg==
X-Spam-Status: No, score=-103.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Apr  3 16:45, Johannes Schindelin wrote:
> We should not blindly set the home directory of the SYSTEM account (or
> of Microsoft accounts) to `/home/<name>`, especially
> `/etc/nsswitch.conf` defines `db_home: env`, in which case we want to
> respect the `HOME` variable.
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

Pushed.


Thanks,
Corinna
