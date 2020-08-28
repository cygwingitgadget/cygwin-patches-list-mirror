Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id A523C3943541
 for <cygwin-patches@cygwin.com>; Fri, 28 Aug 2020 13:45:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A523C3943541
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MKsaz-1jskMX0spR-00LIVu for <cygwin-patches@cygwin.com>; Fri, 28 Aug 2020
 15:45:04 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C0405A83A79; Fri, 28 Aug 2020 15:45:03 +0200 (CEST)
Date: Fri, 28 Aug 2020 15:45:03 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable pseudo console if TERM is dumb or
 not set.
Message-ID: <20200828134503.GL3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200826120015.1188-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200826120015.1188-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:vGYHUzU0JBzBFR7UczKaWhHUNxgx4sOJn8/pSLTQN+Aqee7ibAY
 umNRN6FF4eLrVYheLBT85h/9zMjUo5AlKCWiQF+FNSHdkQKXOYfqN7mXBeT2qXrKmlSw6Xz
 BC5c5wSzQtegcbWOv5Juf5mUlSfdJ4NWfIXsyl8slrt7v1LFStxDnYXHFV91T18Pst9/RS0
 14dzb9iLtyZfmknl4Duww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O3+GaQ/mvjU=:J43YxdXa4knOS53L1mTPG/
 6Tw+gDjjBIRee2f2VEXZFo7ls9HvlzyzQENy8lSraShzEiHi/xKyYsK/HaMAh2pz+qpjBb1Y9
 0QDDCpKq0J7X59EyRDIP5i1tIKMr9zOpE2asN4uqnxk4DPCaAXGj98CxhUrQ8kn2czydP2jdu
 5CDk4e3Cl0t/TlxwwXoXaTZmT9jB/b+h7qxzMJsbNvpGhI2OdkqaZjivd467OQQFPo0dui7wN
 TahgAAGa4W5FbitWQeOoVN8ae2Hx92cLpofOME4u2BxOrC7OyMZdiFlmXWrVWsyi5UeqOUNBx
 r9dCs70Dl2nq9EvRIJDtP5jLt1eTpCSCmLRZr6oTQ2qbLrsavS8UEhs6vg3a/rHpQq/yFLz7I
 CwYiOfATGjFuGf3R1O0A7i/XNBsJzRI1duIjSlWGycXQ73Ik3ALHHtpLPvSJnNxrlrmnaT1yy
 kX1VHQpV387yagfhAgFOdM/Ps6WX7ubvM+rBExSFQgNGb/eHUjgqqPlALQs0l7pAcCQlj+STz
 RG8zDuNs+MH183f8rHG5dbXQyEIs4yALBYwLf9mUJrPcut/Zk4one2LHxdNWNM5qd7IoV0JvI
 rwYRvrwxQZL35jGYO41kIwAxc+0YbMFIsUS2lABVDbY8ZbbGh6EljfZe722q0ru8P5YGsxjVB
 od2ynpHg+PN2cSFJO4jYFbraJMw1LffBx+PIskBwTo6jVr4a2i5Mnu6x4P1eJaOnMrXwWXYdl
 68VNJj2HmXQO1n/ob2GAe+4Xzk2YXa1ryo6TRgrcdeGDct8EZFeG9+R1ne3ELG7cXml+05y8C
 nLKZqr0TSvr7K+t8qvU1X6K7rmvZUWoRk+uet2A3P+sJHu9SCSJ+IVZgH6swV258ryZyJ4Mi6
 ZLtkWX9r69Y9BaibrRAA==
X-Spam-Status: No, score=-104.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Fri, 28 Aug 2020 13:45:07 -0000

Hi Takashi,

On Aug 26 21:00, Takashi Yano via Cygwin-patches wrote:
> Pseudo console generates escape sequences on execution of non-cygwin
> apps.  If the terminal does not support escape sequence, output will
> be garbled. This patch prevents garbled output in dumb terminal by
> disabling pseudo console.
> ---
>  winsup/cygwin/spawn.cc | 36 +++++++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
> index 8308bccf3..b6d58e97a 100644
> --- a/winsup/cygwin/spawn.cc
> +++ b/winsup/cygwin/spawn.cc
> @@ -647,13 +647,35 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
>        ZeroMemory (&si_pcon, sizeof (si_pcon));
>        STARTUPINFOW *si_tmp = &si;
>        if (!iscygwin () && ptys_primary && is_console_app (runpath))
> -	if (ptys_primary->setup_pseudoconsole (&si_pcon,
> -			     mode != _P_OVERLAY && mode != _P_WAIT))
> -	  {
> -	    c_flags |= EXTENDED_STARTUPINFO_PRESENT;
> -	    si_tmp = &si_pcon.StartupInfo;
> -	    enable_pcon = true;
> -	  }
> +	{
> +	  bool nopcon = mode != _P_OVERLAY && mode != _P_WAIT;
> +	  /* If TERM is "dumb" or not set, disable pseudo console */
> +	  if (envblock)
> +	    {
> +	      bool term_is_set = false;
> +	      for (PWCHAR p = envblock; *p != L'\0'; p += wcslen (p) + 1)
> +		{
> +		  if (wcscmp (p, L"TERM=dumb") == 0)
> +		    nopcon = true;
> +		  if (wcsncmp (p, L"TERM=", 5) == 0)
> +		    term_is_set = true;
> +		}
> +	      if (!term_is_set)
> +		nopcon = true;
> +	    }
> +	  else
> +	    {
> +	      const char *term = getenv ("TERM");
> +	      if (!term || strcmp (term, "dumb") == 0)
> +		nopcon = true;
> +	    }
> +	  if (ptys_primary->setup_pseudoconsole (&si_pcon, nopcon))
> +	    {
> +	      c_flags |= EXTENDED_STARTUPINFO_PRESENT;
> +	      si_tmp = &si_pcon.StartupInfo;
> +	      enable_pcon = true;
> +	    }
> +	}
>  
>      loop:
>        /* When ruid != euid we create the new process under the current original
> -- 
> 2.28.0

Would you mind to encapsulate the TERM checks into a fhandler_pty_slave
method so the TERM specific stuff is done in the fhandler code, not
in spawn.cc?


Thanks,
Corinna
