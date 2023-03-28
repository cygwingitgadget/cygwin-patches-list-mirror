Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	by sourceware.org (Postfix) with ESMTPS id B279D3858D39
	for <cygwin-patches@cygwin.com>; Tue, 28 Mar 2023 10:17:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B279D3858D39
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MGQax-1pgDKn1LWn-00GtX8; Tue, 28 Mar 2023 12:17:36 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EED74A80BFF; Tue, 28 Mar 2023 12:17:35 +0200 (CEST)
Date: Tue, 28 Mar 2023 12:17:35 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 3/3] Respect `db_home: env` even when no uid can be
 determined
Message-ID: <ZCK+v7yBxRBft3UK@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	cygwin-patches@cygwin.com
References: <cover.1663761086.git.johannes.schindelin@gmx.de>
 <cover.1679991274.git.johannes.schindelin@gmx.de>
 <4cd6ae73074f327064b54a08392906dbc140714a.1679991274.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4cd6ae73074f327064b54a08392906dbc140714a.1679991274.git.johannes.schindelin@gmx.de>
X-Provags-ID: V03:K1:/Y8B6tIQOepK5u1iZEwWqZzEs8bxurvaY4j2iCYrLdOsAv9fNMa
 W2NLxnmUEKnsB9F2j0MShsv7XX5+IjDUrJN0LchZoNn50MvXdlWsm0H46+zB6BBvgPCZ59N
 dPoGKHz+1GHFcIsKBKjzQ6aTDy90422v8TqlJVpFFheRgsUChx1cQ1A7wLpm4HKRtFdA/Wv
 vWv7wASo6SE2GdR/5eaFw==
UI-OutboundReport: notjunk:1;M01:P0:n5EqAceEExk=;p8VcPXa25xKCOBZuOMuPHLm4mek
 ppk3WhkJUYHtu2AOFDZ8nHuMM7DrebzgDlWiO1GGsbXg3YHX9XR8+x+/FdsxAoiaHJvmmE13r
 RBQjh96mHdMLLJwON9XFtO6Ta1aOYOqTlKxefmxpwD2VOcRVSMDlmHuemO4xUcLrMUum/yVDJ
 5/d5uGStZdWEMP/ulWDq/iyykZvXighRnB8poJwwuZcssY1GfR1XJSFEWcFMJsxuxTl9FCV21
 P/mTGRf9RLJVuNsHvymLAtOZ2pQS0OjABiY1kV5mJfQTewD7AlaU1+L6UEHd2XFpe1VBSlAyf
 +780aofTsQjQDlz3SG4B2jeam4VFb+zbbbe/BUFTRdNl3lffjmq3LQYNqW6SOLbLQg4YsqnRb
 cetxRHADeG8luHn4zQB0VIyoPMD+vAPQ7A6hX8uV1Mij2fdrbvbOnU2D4AkQXTb63UmUs/n16
 3YKBXt0UZ8hYgOvOCG7fIz8Xgg7PdjQtU54jJL22u890+oKwst9RPZXNqbdmuE91FD3GbbDut
 xDchzoyIY0DBAogM15w6FMR/Rx+ocsZXp5NjrsmQOgqnKIDzqaGV5Qpb4VKDwDj3kGdCTHMo5
 /eoPUfxXbykJkurPGXOiJqkNzZ+wpLS2gNBCQMmSqgocLtR9zBR6Tz+dUXJwRHdQ67e2Udx2S
 E+Nt1yR0yYJNYHPbTvRko/frI/t1IaeihE7d+HqBfg==
X-Spam-Status: No, score=-103.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mar 28 10:17, Johannes Schindelin wrote:
> In particular when we cannot figure out a uid for the current user, we
> should still respect the `db_home: env` setting. Such a situation occurs
> for example when the domain returned by `LookupAccountSid()` is not our
> machine name and at the same time our machine is no domain member: In
> that case, we have nobody to ask for the POSIX offset necessary to come
> up with the uid.
> 
> It is important that even in such cases, the `HOME` environment variable
> can be used to override the home directory, e.g. when Git for Windows is
> used by an account that was generated on the fly, e.g. for transient use
> in a cloud scenario.

How does this kind of account look like?  I'd like to see the contants
of name, domain, and the SID.  Isn't that just an account closely
resembling Micorosft Accounts or AzureAD accounts?  Can't we somehow
handle them alike?

> Reported by David Ebbo.

This should be

  Reported-By: David Ebbo <email address>

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  winsup/cygwin/uinfo.cc | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
> index d493d29b3b..b01bcff5cb 100644
> --- a/winsup/cygwin/uinfo.cc
> +++ b/winsup/cygwin/uinfo.cc
> @@ -883,6 +883,8 @@ fetch_from_path (cyg_ldap *pldap, PUSER_INFO_3 ui, cygpsid &sid, PCWSTR str,
>  	    case L'u':
>  	      if (full_qualified)
>  		{
> +		  if (!dom)
> +		    break;

No domain?  Really?


Corinna
