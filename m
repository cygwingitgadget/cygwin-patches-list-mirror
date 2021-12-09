Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 6A9613858C39
 for <cygwin-patches@cygwin.com>; Thu,  9 Dec 2021 10:08:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6A9613858C39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mdva2-1mNZhB0b3u-00azpj for <cygwin-patches@cygwin.com>; Thu, 09 Dec 2021
 11:08:47 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 4E4EEA807B0; Thu,  9 Dec 2021 11:08:46 +0100 (CET)
Date: Thu, 9 Dec 2021 11:08:46 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: path: Fix path conversion of virtual drive.
Message-ID: <YbHVrmn+hm7sH23S@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211209081750.4970-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211209081750.4970-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:Q8MI0X0dfQ0YuZNnkkQppgXZybvte+mxYBsGsxKltPki1ytPqfI
 WB4UG6QYdc3+DfFZS4FcKPnWDyPkhTv1WbCYOOyGVK7yZhfqwtHRZzmwa7qqV8Ns/NID/aa
 ovSzgAvu7mPaEFjWlMTMev2zeHEKEIIDtHQ/aLtk+9Qe/v3sVNTwg8rIjJqdUSrmyCBUj0G
 LjiUeBp8m8zd3bVMrYT+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BDhmb5lPSag=:XG8hRsWG9D4bLTK4poofG7
 CeHWSfGmnF0haDfpwMKsWHedr/gSnoX1Q+tgMcPEqNdb2RJHc1jeYeG9ypxS1Q111hYm6i04q
 gwdLA1KKlERUlaTY4JqnVAtm06q0C5gM+A29JIPVygpmsGLoUCgymvwMdLIFEK/i66VwhwIg1
 IhdT/8sYMZwvcb22ccUGhTMywluKyyAjmgfNZwtGcuhSm05Q6/VRMPOUIdy6b79UaokX37Foe
 Txrtd05wQWnkH5Vb0FK9N1PGbwOjJTAm32JVdvBRmBRNF7a7eVi7SLZXRWNZZHqrDUDkCWLQl
 zAebleuxNNQngaxbzpPBsPSSw7xcdMR11Jx0WSF0NBD5d/iXrYJqBJs3akk1VSfZTO2xsJwbU
 wBQ3JaMbq16LjgxEPbVfzCzbmnNs5cpfhh9lKjHVJbHXeXx6oS9l5lermnByYl3O/YPloxvKO
 HSRDr2MRYlwvAS4Fj3kMyxyzMaEB74IsqFZMw01nLka7XDd0phNx
X-Spam-Status: No, score=-105.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Thu, 09 Dec 2021 10:08:51 -0000

Hi Takashi,

On Dec  9 17:17, Takashi Yano wrote:
> - The last change in path.cc introduced a bug that causes an error
>   when accessing a virtual drive which mounts UNC path such as
>   "\\server\share\dir" rather than "\\server\share". This patch
>   fixes the issue.
> ---
>  winsup/cygwin/path.cc | 50 +++++++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 21 deletions(-)
> 
> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index eb1255849..6682d2a58 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -3507,29 +3507,37 @@ restart:
>  		  if (RtlEqualUnicodePathPrefix (&fpath, &ro_u_uncp, TRUE)
>  		      && !RtlEqualUnicodePathPrefix (&upath, &ro_u_uncp, TRUE))
>  		    {
> -		      /* ...get the remote path from the volume path name,
> -			 replace remote path with drive letter, check again. */
> +		      /* ...get the remote path, replace remote path
> +			 with drive letter, check again. */
> +		      WCHAR drive[3] =
> +			{(WCHAR) towupper (upath.Buffer[4]), L':', L'\0'};
>  		      WCHAR remote[MAX_PATH];
>  
> -		      fpbuf[1] = L'\\';
> -		      BOOL r = GetVolumePathNameW (fpbuf, remote, MAX_PATH);
> -		      fpbuf[1] = L'?';
> -		      if (r)
> -			{
> -			  int remlen = wcslen (remote);
> -			  if (remote[remlen - 1] == L'\\')
> -			    remlen--;
> -			  /* Hackfest */
> -			  fpath.Buffer[4] = upath.Buffer[4]; /* Drive letter */
> -			  fpath.Buffer[5] = L':';
> -			  WCHAR *to = fpath.Buffer + 6;
> -			  WCHAR *from = to + remlen - 6;
> -			  memmove (to, from,
> -				   (wcslen (from) + 1) * sizeof (WCHAR));
> -			  fpath.Length -= (from - to) * sizeof (WCHAR);
> -			  if (RtlEqualUnicodeString (&upath, &fpath, !!ci_flag))
> -			    goto file_not_symlink;
> -			}
> +		      if (!QueryDosDeviceW (drive, remote, MAX_PATH))
> +			goto file_not_symlink; /* fallback */
> +
> +		      int remlen = wcslen (remote);

QueryDosDeviceW returns the string followed by two \0 chars, and that's
reflected by its return value.  You could skip the wcslen call:

                      int remlen;
		      remlen = QueryDosDeviceW (drive, remote, MAX_PATH);
		      if (!remlen)
		      	goto file_not_symlink;
		      remlen -= 2;


> +		      if (remote[remlen - 1] == L'\\')
> +			remlen--;
> +		      WCHAR *p;
> +		      if (wcsstr (remote, L"\\??\\UNC\\") == remote)

That should be wcsncmp.  The subst'ed UNC path always begins with that
string.  Alternatively:

		      UNICODE_STRING rpath;
		      RtlInitCountedUnicodeString (&rpath, remote,
						   remlen * sizeof (WCHAR));
		      if (RtlEqualUnicodePathPrefix (&rpath, &ro_u_uncp, TRUE))


> +			remlen -= 6;
> +		      else if ((p = wcschr (remote, L';') + 1)

This expression is always true, even if wcschr returns a NULL pointer.

> +			       && wcsstr (p, drive) == p

                               && wcsncmp (p, drive, 2) == 2?

Alternatively just skip the additional drive letter check and move
the pointer immediately forward to the next backslash:

> +			       && (p = wcschr (p + 2, L'\\')))
> +			remlen -= p - remote - 1;
> +		      else
> +			goto file_not_symlink; /* fallback */
> +		      /* Hackfest */
> +		      fpath.Buffer[4] = drive[0]; /* Drive letter */
> +		      fpath.Buffer[5] = L':';
> +		      WCHAR *to = fpath.Buffer + 6;
> +		      WCHAR *from = to + remlen;
> +		      memmove (to, from,
> +			       (wcslen (from) + 1) * sizeof (WCHAR));
> +		      fpath.Length -= (from - to) * sizeof (WCHAR);
> +		      if (RtlEqualUnicodeString (&upath, &fpath, !!ci_flag))
> +			goto file_not_symlink;
>  		    }
>  		  issymlink = true;
>  		  /* upath.Buffer is big enough and unused from this point on.
> -- 
> 2.34.1

Thanks,
Corinna
