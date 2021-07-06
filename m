Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 1CD24388A40C
 for <cygwin-patches@cygwin.com>; Tue,  6 Jul 2021 14:57:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 1CD24388A40C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MUXlA-1laHPi1YK8-00QQZ0; Tue, 06 Jul 2021 16:57:18 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 956B2A80D68; Tue,  6 Jul 2021 16:57:15 +0200 (CEST)
Date: Tue, 6 Jul 2021 16:57:15 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jeremy Drake <cygwin@jdrake.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: respect PC_SYM_FOLLOW and PC_SYM_NOFOLLOW_REP
 with inner links
Message-ID: <YORvS4cn1fQX3O70@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jeremy Drake <cygwin@jdrake.com>, cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2105291322180.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105291600460.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105292259570.30039@resin.csoft.net>
 <alpine.BSO.2.21.2105301213380.30039@resin.csoft.net>
 <YLSYIC/yYFz2IdMS@calimero.vinschen.de>
 <alpine.BSO.2.21.2106031321380.30039@resin.csoft.net>
 <alpine.BSO.2.21.2106031355540.30039@resin.csoft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.BSO.2.21.2106031355540.30039@resin.csoft.net>
X-Provags-ID: V03:K1:jn3cn7bpykprjiTfB+eHWUqizHnHMSgXxO9T6Yd0+yTgzeuC9I7
 KI1dcJrXOQ6pS7NwJQjinwVyY9fiadnU8PFNQVB1dg7K+uSJL5FOPESG2a1GSx6ifEeulBR
 FdVMRo3Zq5odwYmlv54hJoK/KtNa4Py04MuQqhdU2i5HFcRhQG1mi5A5LwkmBa2yGR5SZzv
 jfo/kexef+etyA2OhzaUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mnhLZURmqGY=:3nIi4IwlHPG2igBK9xbKqR
 7aHipifUtmcX6mOHYwYGq7sw2lqsUVFwdcg+a8Y5j43zFeIph3Ntbrwf0w10izGoSthWbSkC5
 2hOJ6tc5B+f0pmXK0j8j2n1U16F49hWGeIRhw1yr7eT5t8PkRwyAu4g0gPBZ0BVZtsDDkGjmb
 xezHx2zxCtO5eSfGxG1LcMn1hh66rQ2CYy6LpaGU/Xnj0JYP09JHEdrFaRRbB9Ys5HBauDWD3
 RrOBBC7BUXy/zTsU/LSw2IAE6FObRVKodqy6RHLIHQTqAH3wHPDW9ZtGRjGCxs6ZmSAZeTDts
 F8a3wLmoyExGVImIJviWBxeH5LLuBX3b4Hcojaqdy3UrVpOi3dI2oTtSDpeW/mqUwKPxqlwMt
 MI05PnRJGq5uqNOFa81eUo2r8ReVzrOBidCNBYFS8DpXCh23Zr7XgDJYhrRakJqO08weF85c+
 M5RXypDQTeN6If1UjgdUoVd0uGZg90mzxJ/2sVlUM6VoWg7palEDQFGstG+X45UlJW4PNLl6U
 vAWiLw7ERxGfXqe/r08C6Sttjl4KI5wPLs5RFMrIYCFb5Z62KNiz3cJmv4vj/NwiN70zR9qDP
 der9qADKOr1BYqoXZ0xQ7Wlx+2RxIjrqrLjHO4DF/JF/SzFswlmDttESjtODeRWSylos6JpbS
 +T5/cgNxVD3MZrMT50YNTg/NGd9cgQra6Wr5g74mLwhce6q14nZ5fFCBn+BYCa24Xz57ecfA3
 HoOratxZ2SEQIyoG5mkM0vTt0xGCtEAb1Wu6p5EuOq9KS8jNiCpRqNd7kq6L/XcQpI/UCyKvw
 HksxkrT4SREIwh+MAy5LTqdoP3Y8wryO+5zNxHZPNc9T7BgOG8okHudeZxeY7mSafy41b5jdA
 TvtLyDxNd9cTN74tlYxQ==
X-Spam-Status: No, score=-106.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Tue, 06 Jul 2021 14:57:24 -0000

On Jun  3 13:57, Jeremy Drake via Cygwin-patches wrote:
> [...]
> The new GetFinalPathNameW handling for native symlinks in inner path
> components is disabled if caller doesn't want to follow symlinks, or
> doesn't want to follow reparse points.  Set flag to not follow reparse
> points in chdir, allowing native processes to see their cwd potentially
> including native symlinks, rather than dereferencing them.
> ---
>  winsup/cygwin/path.cc | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index e62f8fe2b..a6bb3aeff 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -722,9 +722,10 @@ path_conv::check (const char *src, unsigned opt,
>  	  int symlen = 0;
>  
>  	  /* Make sure to check certain flags on last component only. */
> -	  for (unsigned pc_flags = opt & (PC_NO_ACCESS_CHECK | PC_KEEP_HANDLE);
> +	  for (unsigned pc_flags = opt & (PC_NO_ACCESS_CHECK | PC_KEEP_HANDLE
> +					 | PC_SYM_FOLLOW | PC_SYM_NOFOLLOW_REP);
>  	       ;
> -	       pc_flags = 0)
> +	       pc_flags = opt & (PC_SYM_FOLLOW | PC_SYM_NOFOLLOW_REP))
>  	    {
>  	      const suffix_info *suff;
>  	      char *full_path;
> @@ -3452,6 +3453,8 @@ restart:
>  	    break;
>  	}
>  
> +      if ((pc_flags & (PC_SYM_FOLLOW | PC_SYM_NOFOLLOW_REP)) == PC_SYM_FOLLOW)
> +      {
>        /* Check if the inner path components contain native symlinks or
>  	 junctions, or if the drive is a virtual drive.  Compare incoming
>  	 path with path returned by GetFinalPathNameByHandleA.  If they
> @@ -3522,6 +3525,7 @@ restart:
>  	      }
>  	  }
>        }
> +      }

This formatting is just ugly.  I suggest to move the PC_SYM_* test
to the block after the 32 bit code and reuse the existing braces,
just with adapted indentation, i. e.:

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 6a07f0d06850..cb0386e24005 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -3480,43 +3480,44 @@ restart:
 	    goto file_not_symlink;
 	}
 #endif /* __i386__ */
-      {
-	PWCHAR fpbuf = tp.w_get ();
-	DWORD ret;
+      if ((pc_flags & (PC_SYM_FOLLOW | PC_SYM_NOFOLLOW_REP)) == PC_SYM_FOLLOW)
+	{
+	  PWCHAR fpbuf = tp.w_get ();
+	  DWORD ret;
[...indent all lines inside the block accordingly...] 
-      }
+	}
 
     /* Normal file. */
     file_not_symlink:

> @@ -3704,7 +3708,8 @@ chdir (const char *in_dir)
> 
>        /* Convert path.  PC_NONULLEMPTY ensures that we don't check for
>          NULL/empty/invalid again. */
> -      path_conv path (in_dir, PC_SYM_FOLLOW | PC_POSIX | PC_NONULLEMPTY);
> +      path_conv path (in_dir, PC_SYM_FOLLOW | PC_POSIX | PC_NONULLEMPTY
> +                             | PC_SYM_NOFOLLOW_REP);
>        if (path.error)
>         {
>           set_errno (path.error);

I'm still not convinced that we should do this.  I'm pretty certain this
will result in problems in Cygwin processes when you least expect them.

Consider that the output of getcwd and realpath/readlink on the same
path may differ after this patch.  Using PC_SYM_NOFOLLOW_REP like this
also changes the normal sym follow handling for the last path component
in path_copnv::check, potentially.

This looks like here be dragons.  A good solution would change the
used native tools to allow paths > MAX_PATH finally, or to use other,
equivalent tools already allowing that.

Patch 1 is ok, of course.  I pushed it.


Thanks,
Corinna
