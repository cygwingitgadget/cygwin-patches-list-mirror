Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 26E18382D83C
 for <cygwin-patches@cygwin.com>; Fri, 22 Jan 2021 12:22:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 26E18382D83C
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N5W0q-1m41Vy3Xha-016zed for <cygwin-patches@cygwin.com>; Fri, 22 Jan 2021
 13:22:16 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id CBC46A80D50; Fri, 22 Jan 2021 13:22:15 +0100 (CET)
Date: Fri, 22 Jan 2021 13:22:15 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/8] syscalls.cc: Deduplicate remove
Message-ID: <20210122122215.GF810271@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210120161056.77784-3-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120161056.77784-3-ben@wijen.net>
X-Provags-ID: V03:K1:Er7CIHOqXLzvdNX361iszvcy6ACdd2X+8KuObfzwttDgGe1yO//
 6NjH7p4YW63N5poOi1B9D5E8cpqzP/15I5cHI9G3oKTHqFEOPmgLSKAs5ilBYbCGOOBQufU
 IxJiwXWuFeBR374OK5vR7tbx81bVaG/WlmfsQx3rY1y6ES5os9F+z1xUIji3gdIwwIi2Pug
 ngw8iCp1lXBVFLJsB2tNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s1RXBg1oC60=:BmDotZI6Hh9Os2W7PPBU0z
 XB9/O6BhBsVTtWtaCvk+yB8I5mZSMMLx6oy/U3kifwn68UHN1Zn5RXOc/20oF/59GSZzPFZSd
 4qeK3cs4zy+4Usa7jQs0hFOvNPji/EVkjEeh+Jd9EqRea9rHf9hosEY9lZs19ZjPImcJO10Lr
 mcNa5/21Ah+/U2QgrCsOpwligtdBNJKhuZ/r6VPEvbL/l8bxCrbNjBzdldEDMkmrzFTlRtH19
 ZFbqvktKBGAR1tI9moQuUjrWhO5yht3CpuanoWAlUThy7c7k0xt0s8CDeON337TSpCE/Ntufv
 k0qXbG0+aHveFi/F+p1CwtgVZEtIJme//U685BMK1qk2O/CS5Q8AF1FkoU+vUafg/lEYGgTSA
 q8FKMODhYNKIHUyPMVff8o0Sg20DCRFCxljiwOsGqlCykOA3WhxzZAgDWIotLreFNYW08N9TO
 +O9fFmD4lQ==
X-Spam-Status: No, score=-107.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Fri, 22 Jan 2021 12:22:19 -0000

On Jan 20 17:10, Ben Wijen wrote:
> The remove code is already in the _remove_r function.
> So, just call the _remove_r function.
> ---
>  winsup/cygwin/syscalls.cc | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 2e50ad7d5..54b065733 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -1133,24 +1133,15 @@ _remove_r (struct _reent *, const char *ourname)
>        return -1;
>      }
>  
> -  return win32_name.isdir () ? rmdir (ourname) : unlink (ourname);
> +  int res = win32_name.isdir () ? rmdir (ourname) : unlink (ourname);
> +  syscall_printf ("%R = remove(%s)", res, ourname);
> +  return res;
>  }
>  
>  extern "C" int
>  remove (const char *ourname)
>  {
> -  path_conv win32_name (ourname, PC_SYM_NOFOLLOW);
> -
> -  if (win32_name.error)
> -    {
> -      set_errno (win32_name.error);
> -      syscall_printf ("-1 = remove (%s)", ourname);
> -      return -1;
> -    }
> -
> -  int res = win32_name.isdir () ? rmdir (ourname) : unlink (ourname);
> -  syscall_printf ("%R = remove(%s)", res, ourname);
> -  return res;
> +  return _remove_r(_REENT, ourname);
                    ^^^
		    space


Corinna
