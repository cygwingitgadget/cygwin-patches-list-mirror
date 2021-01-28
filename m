Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id D1FDE398E430
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 09:41:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D1FDE398E430
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MVe9i-1lWep01QKi-00RcF5 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021
 10:41:02 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 463A8A80D85; Thu, 28 Jan 2021 10:41:01 +0100 (CET)
Date: Thu, 28 Jan 2021 10:41:01 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: fchmodat: add limited support for
 AT_SYMLINK_NOFOLLOW
Message-ID: <20210128094101.GV4393@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210127185348.44805-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210127185348.44805-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:URlDLQBX4FrjkUZHvoXiAiMYLer9FcuVS9vyuCpPKW2IoDlCzfj
 aKZlwlOFNdSN6hmPY8aQicj6tzjn/WyTbYZVFAjZjVg02eTGt1W+W7foGWm46XXNVOKn3gr
 CKmnHH54foHAnhfXmnszjPZrKiS+B6bRCpmwPwjErwS7QBsHvhrRmMkgn2jBA251zuLjoRl
 cASJ65/BmvWlWpqjWc31A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k4s8bbsezq0=:qUGw56c4vb1f2JCTKUXjAI
 7EOu0+l44mTMBqw9O7uKqoP5ZSJyA3JEAkAWl/ahTaWMqivkh/lvZOzj495fpLwmu/ER+Nis5
 djfwBQothPf0y8N6eNLr0qRqh2kALGyb5SWj0JW+a1rnhrLK+1khhoyrpo3gPC+Zk+Yg6PGm6
 OMrUOQUMN3haj0q/2jUeilRwS6hlsiOc0KO2FAuhSBH+wOBR3LtDoXEyKJE/AJyXlJg3fXiOZ
 xVUAyvSRy5YGth2CWVIVeLdihm2NtCszJNT/JtkXoF8TMNSk0mf1O11sk/wIhkJ/nz9CBMcS2
 vV3PR2qKiEPPbIXUutkFFFVZGOU/aGreeyc6+I4fVmW3LPQznfDOWVH3RBlFMNMzR4yPac+z1
 lkSBCWfCRpnFBcJSJgk/bDt2Z/lrCt1NIqYRqbX9VBUdPgtDFw6wIH6ygOc/qBBG3O9Q9W7XL
 UeHQfZDYpw==
X-Spam-Status: No, score=-107.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Thu, 28 Jan 2021 09:41:05 -0000

On Jan 27 13:53, Ken Brown via Cygwin-patches wrote:
> Allow fchmodat with the AT_SYMLINK_NOFOLLOW flag to succeed on
> non-symlinks.  Previously it always failed, as it does on Linux.  But
> POSIX permits it to succeed on non-symlinks even if it fails on
> symlinks.
> 
> The reason for following POSIX rather than Linux is to make gnulib
> report that fchmodat works on Cygwin.  This improves the efficiency of
> packages like GNU tar that use gnulib's fchmodat module.  Previously
> such packages would use a gnulib replacement for fchmodat on Cygwin.
> ---
>  winsup/cygwin/syscalls.cc | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 4cc8d07f5..5da05b18a 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -4787,17 +4787,27 @@ fchmodat (int dirfd, const char *pathname, mode_t mode, int flags)
>    tmp_pathbuf tp;
>    __try
>      {
> -      if (flags)
> +      if (flags & ~AT_SYMLINK_NOFOLLOW)
>  	{
> -	  /* BSD has lchmod, but Linux does not.  POSIX says
> -	     AT_SYMLINK_NOFOLLOW is allowed to fail on symlinks; but Linux
> -	     blindly fails even for non-symlinks.  */
> -	  set_errno ((flags & ~AT_SYMLINK_NOFOLLOW) ? EINVAL : EOPNOTSUPP);
> +	  set_errno (EINVAL);
>  	  __leave;
>  	}
>        char *path = tp.c_get ();
>        if (gen_full_path_at (path, dirfd, pathname))
>  	__leave;
> +      if (flags)

For clarity, and on the off-chance that new flags are added to fchmodat,
it might be better to check for (flags & AT_SYMLINK_NOFOLLOW) here
explicitely.  Your choice.

> +	{
> +          /* BSD has lchmod, but Linux does not.  POSIX says
> +	     AT_SYMLINK_NOFOLLOW is allowed to fail on symlinks.
> +	     Linux blindly fails even for non-symlinks, but we allow
> +	     it to succeed. */
> +	  path_conv pc (path, PC_SYM_NOFOLLOW, stat_suffixes);
> +	  if (pc.issymlink ())
> +	    {
> +	      set_errno (EOPNOTSUPP);
> +	      __leave;
> +	    }
> +	}
>        return chmod (path, mode);
>      }
>    __except (EFAULT) {}
> -- 
> 2.30.0

Looks good.


Thanks,
Corinna
