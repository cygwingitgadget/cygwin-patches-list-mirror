Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id BCD15385782C
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 11:51:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BCD15385782C
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M9nlN-1l4TL31kMH-005mx3 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 12:51:04 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D9219A80B92; Mon, 18 Jan 2021 12:51:03 +0100 (CET)
Date: Mon, 18 Jan 2021 12:51:03 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 09/11] mount.cc: Implement poor-man's cache
Message-ID: <20210118115103.GY59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-10-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115134534.13290-10-ben@wijen.net>
X-Provags-ID: V03:K1:hqBG9ULbxIOIXfgqeRELU94PWM+ypVnOy5DNaesPueNZGhSna/8
 RntRmSHvlKFjY2bU6kFNKoWueDWmwPnP1Tz1R8eZo3L6076kgObbPzuoyFECLDliqcIWzq+
 g1A3nFazx29KBoFrALie7LCIP6l4+RcEvosu9ERQNHoErYO303GWZpxR4wezrnYh42TZdyn
 xEkYOReTiTESOqZbJlWcQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nyaHf3sP+7A=:8P9xGhkf+Tq5H+kE3YXXxC
 gGUoEe5XUnscEfXymhk3L+zcxjugoNxYHp5pKEr7W7ooG9Q/Yly2iHF++i0nKJn2cBp99pfLF
 JFNtophSt7dM4BVvrJEJGQvGqQqWIg0Ey8AVqKtRmjNHg1HojbzhJt+mZSq6gDJkSNJdeewMx
 Z8/Z6HTjiV5SmgVJrC/RftpqE5gjpATPDUTSODLaHSBBwAc68E9F2pJowY55o6y6uD+o30dqT
 F6/vNuSdZNiHUWpKPoZg6A5hrku2pIj4sd6IqOJDGRVTqNWw1Y8s1EWCjX9A+NJOIqCmO1ihN
 atPUxeWWOmvaGfK6+n8uQZs0w0LBCiNqFeR0nxFTn+uPnmLlczbObpnMbikE90b3VsrGV0tcV
 DPPxT5Emoqj2uFJbQ5foOqz28CMCmU5Ufi209KffetpJD/glwM0M7fFQcEQuPghqxMD91x4+R
 NJV1XK2HoQ==
X-Spam-Status: No, score=-106.8 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
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
X-List-Received-Date: Mon, 18 Jan 2021 11:51:07 -0000

On Jan 15 14:45, Ben Wijen wrote:
> Try to avoid NtQueryVolumeInformationFile.
> ---
>  winsup/cygwin/mount.cc | 78 ++++++++++++++++++++++++++++--------------
>  winsup/cygwin/mount.h  |  2 +-
>  winsup/cygwin/path.cc  |  2 +-
>  winsup/cygwin/path.h   |  1 +
>  4 files changed, 56 insertions(+), 27 deletions(-)
> 
> diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
> index e0349815d..1d2b3a61a 100644
> --- a/winsup/cygwin/mount.cc
> +++ b/winsup/cygwin/mount.cc
> @@ -82,6 +82,32 @@ win32_device_name (const char *src_path, char *win32_path, device& dev)
>    return true;
>  }
>  
> +static uint32_t
> +hash_prefix (const PUNICODE_STRING upath)
> +{
> +  UNICODE_STRING prefix;
> +  WCHAR *p;
> +
> +  if (upath->Buffer[5] == L':' && upath->Buffer[6] == L'\\')
> +    p = upath->Buffer + 6;
> +  else
> +    {
> +      /* We're expecting an UNC path.  Move p to the backslash after
> +       "\??\UNC\server\share" or the trailing NUL. */
> +      p = upath->Buffer + 7; /* Skip "\??\UNC" */
> +      int bs_cnt = 0;
> +
> +      while (*++p)
> +        if (*p == L'\\')
> +          if (++bs_cnt > 1)
> +            break;
> +    }
> +  RtlInitCountedUnicodeString (&prefix, upath->Buffer,
> +                               (p - upath->Buffer) * sizeof(WCHAR));
> +
> +  return hash_path_name ((ino_t) 0, &prefix);
> +}
> +

Ok, so hash_prefix reduces the path to a drive letter or the UNC path
prefix and hashes it.  However, what about partitions mounted to a
subdir of, say, drive C?  In that case the hashing goes awry, because
you're comparing with the hash of drive C while the path is actually
pointing to another partition.

> @@ -233,27 +281,7 @@ fs_info::update (PUNICODE_STRING upath, HANDLE in_vol)
>  	 a unique per-drive/share hash. */
>        if (ffvi_buf.ffvi.VolumeSerialNumber == 0)
>  	{
> -	  UNICODE_STRING path_prefix;
> -	  WCHAR *p;
> -
> -	  if (upath->Buffer[5] == L':' && upath->Buffer[6] == L'\\')
> -	    p = upath->Buffer + 6;
> -	  else
> -	    {
> -	      /* We're expecting an UNC path.  Move p to the backslash after
> -	         "\??\UNC\server\share" or the trailing NUL. */
> -	      p = upath->Buffer + 7;  /* Skip "\??\UNC" */
> -	      int bs_cnt = 0;
> -
> -	      while (*++p)
> -		if (*p == L'\\')
> -		    if (++bs_cnt > 1)
> -		      break;
> -	    }
> -	  RtlInitCountedUnicodeString (&path_prefix, upath->Buffer,
> -				       (p - upath->Buffer) * sizeof (WCHAR));
> -	  ffvi_buf.ffvi.VolumeSerialNumber = hash_path_name ((ino_t) 0,
> -							     &path_prefix);
> +	  ffvi_buf.ffvi.VolumeSerialNumber = hash_prefix(upath);

Please note that we did this *only* for border case FSes returning a VSN
of 0.  This was sufficient for these cases, but not in a a general sense.


Corinna
