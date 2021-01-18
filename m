Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 1CBAA3858025
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 12:13:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1CBAA3858025
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mr8O8-1lnPPK0o7y-00oEOV for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 13:13:44 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 36A07A80988; Mon, 18 Jan 2021 13:13:43 +0100 (CET)
Date: Mon, 18 Jan 2021 13:13:43 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 11/11] dir.cc: Try unlink_nt first
Message-ID: <20210118121343.GZ59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-12-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115134534.13290-12-ben@wijen.net>
X-Provags-ID: V03:K1:LzWRo849Hs6z5mYvsfiDltltM/Rlh0Ci5heq9TuaQ7y9Oi4PNrR
 xBwQzPIQzc3a+N+bwITRatTGTDlT7ssKAXH3FTL/UefiZ7AMvUuj6T2BAd19u8spH4YBhFw
 I94sRYb03xah571B1up22bWMnhZ4KKfzAtOchvVF+1L668jybSDeaT/ZRpli+7T2FkYn+12
 hs+M2JRL4awAYT4neorcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1nd8Wzo9t5s=:ia9i+Ue1TS8itU52v/k2EY
 zMOg47rAgACgw6Q6ng+UGIzwFJ64/tITlPuOBMwfgFnmpOUJrzqe5QreU/Qikd0+U/2ZbdK89
 KZBCdD+FOL2ikY7apbIhK6gDaluah5lGEUPGQ+PVbaYZhwCLe9JY1O/MP/45YLiAvNERPXX1H
 SxZEZK7GNhIFY33TPmUGqN3sr0aG4o+Pbjn1mg0oogk0OExgkCsJAh3F4EpNXLBADkl4vI5PR
 o+JgT+ckFKndmzRjFj4yxHg6hCBidFEeAYntWp2iFmTUVZd+aaP2yjCrshcl0yjI2/IUJtfNx
 UChmZfDqzJH1muqCkh/Nd1keUlLhRX6w5Nj7SwMHA4GoDqGXisQnONlACJ3akxlSXG4gLxL4F
 1xxjT6+W/F35xvTCkI1VhNfSHOepslWRPeTr/a7pwp+fK1S+JbGCcu/0zOrbp4mnghXjN8NlL
 FN3qQJ2fEA==
X-Spam-Status: No, score=-107.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 18 Jan 2021 12:13:56 -0000

On Jan 15 14:45, Ben Wijen wrote:
> Speedup deletion of directories.
> ---
>  winsup/cygwin/dir.cc | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/winsup/cygwin/dir.cc b/winsup/cygwin/dir.cc
> index f912a9e47..2e7da3638 100644
> --- a/winsup/cygwin/dir.cc
> +++ b/winsup/cygwin/dir.cc
> @@ -22,6 +22,8 @@ details. */
>  #include "cygtls.h"
>  #include "tls_pbuf.h"
>  
> +extern NTSTATUS unlink_nt (const char *ourname, ULONG eflags);
> +
>  extern "C" int
>  dirfd (DIR *dir)
>  {
> @@ -398,6 +400,10 @@ rmdir (const char *dir)
>  	  if (msdos && p == dir + 1 && isdrive (dir))
>  	    p[1] = '\\';
>  	}
> +      if(NT_SUCCESS(unlink_nt (dir, FILE_DIRECTORY_FILE))) {
          ^^         ^^
          spaces

Your code is skipping the safety checks and the has_dot_last_component()
check.  The latter implements a check required by POSIX.  Skipping
it introduces an incompatibility, see man 2 rmdir.


Corinna
