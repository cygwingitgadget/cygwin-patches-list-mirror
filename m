Return-Path: <SRS0=BcLe=IE=gmail.com=lionelcons1972@sourceware.org>
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by sourceware.org (Postfix) with ESMTPS id 848654BA2E09
	for <cygwin-patches@cygwin.com>; Wed, 14 Oct 2026 06:21:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 848654BA2E09
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 848654BA2E09
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a00:1450:4864:20::635
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1791958860; cv=pass;
	b=oMmxPQsm6j8kvbt+jULhOwFHsgwwC+HBkajyB5DK+QaOrvIIisqFwuWw0/JM1AH2NhC6rucAnT0PgY+xucU7Kv6HBfV+/izb7wf3Mj3sdTrh6Xvq09ABgstpgjeX10Li6MRbcSJZwWkixcp3zdotnL7vrIuKelIHCRMiaBWmqTM=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791958860; c=relaxed/simple;
	bh=Zu1QTgMCyEOtwNAAsLDrqNjoJfzccMFJws9AJO+QLvQ=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=OmUZ9pJik27vlrrTJyS24d18mO+mhKGGmo9ex+ZAsCjalcsN7wiVLZG2SxE2lvWUVJwGO6Y1e9c9zDpVCkpuTTMTmky5mElF3WGcZYE769hTyXqmCQP+IjPANn+Ob4+D/rw64+++cCwDGIxbzqN3cmUgN/MRNz4djXHOZnH4ZWA=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cWjqeLvy
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 848654BA2E09
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cWjqeLvy
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-c33bb2f3e6cso115316766b.0
        for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2026 23:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791958859; cv=none;
        d=google.com; s=arc-20260327;
        b=H+BU0fpLmVTS3ry5Z18ayHZO2Kj3SFRKhtDOX73eZ45OtrbgBFbt1vdwrceEGTphpg
         V51iZZpUqocTG4arBL7l9wXLjfssfq13cDuWZbsMmhD5Aq8lrD4F8ahJILGbM9JUSJHX
         i17cz3jG7ffICGaR/PjECOrplhSIFuNOR4MiMBAmwB7c7n9jgE9HlgI9AcgrJpHJOH8C
         q8YYvbAqRPA3FmrSh2PBgn89GJugySj4/OKSj3P2S/Bh4bPkRzPyqxbX/K3jY41CwN0/
         i+CbwYSonGijZfza1of9GaYvmM7zyektcKpDFkhfIWyJpPnemuWzdDk/pROFUWjLqUvo
         0/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YzGR4oy7CajgNrH2aFychXrPclhI+F3G8bByzfstekY=;
        fh=A8sImovv95F9n6Cr4jr8ca6rFu75ODyOxV1cnZb1VFY=;
        b=Lr1r5MNlp/fYHPOYQMoaLCNqbNgHbhUSARG52AffT685jAccqjTjP2aWKHhozHFjZm
         f+Nn7G+vfVTuj1B/c3xTt64+aaypY8Z3zmPNYz5LzBFelbmSamhVfXJ6KRtmS7H64ddd
         jD/Y4q1i1q4EU17D7JwG9JULbZLmQXsgylvQqmLwn+1auheqYb5pyc9JHD6fFTeJ+l3t
         yghpXJhledLYk0288Ueyv81T3mohKHo6OCs9toduU5etITPJ+lVF/988QF5OvXzVarlY
         Ue3Vh4UK/rO8bTzvUhd+Wrn9xDevI6kZvRAOoqHXDKpndWGK+K9u+xc4oY+j+k4iwOpS
         rXKg==;
        darn=cygwin.com
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791958859; x=1792563659; darn=cygwin.com;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YzGR4oy7CajgNrH2aFychXrPclhI+F3G8bByzfstekY=;
        b=cWjqeLvy7R/3C0GTClp/xDWp9qUXif+/vE1ehGZLUOQo5YjjdPSg5MEfVbIJ9cq/3S
         MRgEq9mhibDI+ncIWU9LNFhlTjV1MEwnWBK0Yrjykz/HBt34of+RAaJBOKjRYMwvq10y
         zdFr2/+nwdJFZFxLsOZVrjVGY891ZeczKP8Ih92exWxXCP3YnQwobF4ZN+huOidLRWw3
         QO0BlZOb85UktQ3ouZ3ZG8O0KNAjkBil4k2DqG/ydb5tSUCiZk20xy1ehZtoa5cEMncG
         CA1untkHvYYJPJmwXOOegPFP5rrA3vhn9UyhhGvGHhBvIO1L0zniFJLzdondeot/eABL
         DQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791958859; x=1792563659;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YzGR4oy7CajgNrH2aFychXrPclhI+F3G8bByzfstekY=;
        b=prxzwVVKIpEEMZ4QCISdia5j3K0FBe2+L9OcgZlvBWUoJwaGSMCrSAG2aQD2T3cFSW
         gCYRJfJ6MjbEibAVKUDJQ0PgSA/uphPpaK55Cuw+qwbt80asB6Eoslij+ND6Cn8w000k
         ZTg7t7IFKMMZtlULsy4xcZrP8VK5dncsGengkk8LMnILI5MRVCPQTNfD75s4Vg/mvq3Z
         MnmU3wUxG1tW2cqpfyo14k5P099+3U1imLXWmKK9j5YfaOgm9BorHXt1uO+ucWG836kC
         u+bTyJ7Mr09o7ZG8wRg5fNFiKyxbTCFDB34ZlCrm2mpBy7S1/wdKS+HvGAf6LFlvZl/u
         r5yw==
X-Gm-Message-State: AFq9FYKzCBaBfx9yGkzbZK5lan3QuT9A+n813s9qgIjlNH2mXEgAU9FV
	MzX/PjclrVegNEqfPZYdpudId1SAFIm2jo+lWOE+KZrbtZbyECQ8YQYgyOq9xuG4TlbaTvidwhn
	a6eXL5FZeW0L3j6srKqvDEe+6YmCxkdEGmQ==
X-Gm-Gg: AYBFou3Ejgs7V5tBG8z/YrdSE6SDwjUqQO/MY16zBsOQgSOHZ2YIWd0Illj59c1SsZ8
	rlV20vK+E3a7HMdqkM0v+xvuzBjJpBH3w1mEpCdCmfil5LEUMTtejzbfAWSUVZU6MP8r7PaIBrO
	NFthY0K76rP6+RDSIOGYGdSkt0qe7h4sqVUhKgDAp7G1ePodBAJpNWzGSabWDlpS9S8GYheUxwV
	/0pJ14G25hSWX55aWS7niIbeP5SNetUfXwxgwLtYCRKu3b5EXhQbkKPwkBlvRBRvb0zLqtMbXCp
	tkaOhMdrpeueMCLYefOgQ/qhK4CTqQtwA1tBhQtkcbbtdCRx9+z6NwE+uA==
X-Received: by 2002:a17:907:c07:b0:c2e:3d17:5259 with SMTP id
 a640c23a62f3a-c31aa0bf51amr1365700866b.41.1791958859078; Tue, 13 Oct 2026
 23:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260920035524.60008-1-mark@maxrnd.com>
In-Reply-To: <20260920035524.60008-1-mark@maxrnd.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Wed, 14 Oct 2026 08:19:00 +0200
X-Gm-Features: AclHuK9clxeEASJpgcG-_-dfJEnw81JDbobYI4KuP5WIwFEOUD3ShBZ1jkzGrA0
Message-ID: <CAPJSo4U3-y7Bz9KqJ-NBFeiHq8YYaECMckzTHDk=jPSsNMDK_Q@mail.gmail.com>
Subject: Re: [PATCH] Cygwin: Handle uids/gids correctly on NFSv4 filesystems
To: Mark Geisert <mark@maxrnd.com>
Cc: cygwin-patches@cygwin.com, Roland Mainz <roland.mainz@nrubsig.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

I can happily confirm that this bug is now fixed after installing the
latest Cygwin 3.7.0 version today.

Thank you!

Lionel

On Sun, 20 Sept 2026 at 05:55, Mark Geisert <mark@maxrnd.com> wrote:
>
> Currently, Cygwin assumes that all Windows NFS clients operate
> similarly to the Windows NFSv3 client. It expects that account names
> and numeric uid/gid values are identical on both the client and server
> sides, with LDAP acting as the sole authority for these numeric
> values.
>
> However, the NFSv4 protocol fundamentally changes this paradigm. As
> defined in RFC 7530 (Section 5.9) and expanded upon in RFC 8178 (Rules
> for NFSv4 Domain and ID Mapping), NFSv4 deprecates raw numeric uid/gid
> protocol representation in favor of string-based identifiers (e.g.,
> user@domain and group@domain).
>
> To handle this, all NFSv4 clients implement a local "idmapper"
> component that translates these string-based identities from the
> network side into local account data (in the case of Windows, mapping
> user/group names and uid/gid values via nfs3attr XATTR). Because NFSv4
> clients manage their own uid/gid translation locally, Cygwin's
> reliance on raw LDAP data fails in these environments and results in
> the dreaded "Unix_User+<1234>" and "Unix_Group+<5678>"-kind of
> owner/group output in Cygwin ls -l.
>
> The [...] patch addresses this by detecting whether the underlying
> filesystem is NFSv4. If it is, Cygwin bypasses the LDAP assumption and
> performs a direct pass-through of the uid/gid values supplied by the
> NFSv4 client's idmapper.
>
> [Lionel has] successfully tested this fix against several major clients,
> including:
> - Exceed NFSv4 client
> - OpenText NFSv4 client
> - ms-nfs41-client
> - ms-nfs42-client
> - Windows NFSv3 client (no change, it continues to use LDAP raw data)
>
> Reported-by: Lionel Cons <lionelcons1972@gmail.com>
> Addresses: https://cygwin.com/pipermail/cygwin-patches/2026q3/015287.html
> Authored-by: Roland Mainz <roland.mainz@nrubsig.org>
> Reviewed-by: Mark Geisert <mark@maxrnd.com>
> Fixes: 88dce3a (Try harder to avoid LDAP access for RFC2307 mapping)
>
> ---
>  winsup/cygwin/fhandler/disk_file.cc | 30 ++++++++++++++++++-----------
>  winsup/cygwin/local_includes/path.h |  2 ++
>  2 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/winsup/cygwin/fhandler/disk_file.cc b/winsup/cygwin/fhandler/disk_file.cc
> index f284b4a05..e4d20b6c5 100644
> --- a/winsup/cygwin/fhandler/disk_file.cc
> +++ b/winsup/cygwin/fhandler/disk_file.cc
> @@ -214,7 +214,7 @@ fhandler_base::fstat_by_nfs_ea (struct stat *buf)
>       access through another handle invalidates the caching within the
>       NFS client.  Skip this for Cygwin-created Symlinks playing FIFOs
>       (this sets the filler1 member to NF3FIFO). */
> -  if (get_handle () && nfs_attr->filler1 != NF3FIFO)
> +  if (get_handle () && pc.fs_is_nfs3() && (nfs_attr->filler1 != NF3FIFO))
>      {
>        if (get_access () & GENERIC_WRITE)
>         FlushFileBuffers (get_handle ());
> @@ -236,11 +236,15 @@ fhandler_base::fstat_by_nfs_ea (struct stat *buf)
>         {
>           uid_t map_uid = ILLEGAL_UID;
>
> -         domain = cygheap->dom.get_rfc2307_domain ();
> -         if ((ldap_open = (cldap.open (domain) == NO_ERROR)))
> -           map_uid = cldap.remap_uid (nfs_attr->uid);
> -         if (map_uid == ILLEGAL_UID)
> -           map_uid = MAP_UNIX_TO_CYGWIN_ID (nfs_attr->uid);
> +          if (pc.fs_is_nfs4())
> +            map_uid = nfs_attr->uid;
> +          else {
> +           domain = cygheap->dom.get_rfc2307_domain ();
> +           if ((ldap_open = (cldap.open (domain) == NO_ERROR)))
> +             map_uid = cldap.remap_uid (nfs_attr->uid);
> +           if (map_uid == ILLEGAL_UID)
> +             map_uid = MAP_UNIX_TO_CYGWIN_ID (nfs_attr->uid);
> +          }
>           cygheap->ugid_cache.add_uid (nfs_attr->uid, map_uid);
>           buf->st_uid = map_uid;
>         }
> @@ -255,11 +259,15 @@ fhandler_base::fstat_by_nfs_ea (struct stat *buf)
>         {
>           gid_t map_gid = ILLEGAL_GID;
>
> -         domain = cygheap->dom.get_rfc2307_domain ();
> -         if ((ldap_open || cldap.open (domain) == NO_ERROR))
> -           map_gid = cldap.remap_gid (nfs_attr->gid);
> -         if (map_gid == ILLEGAL_GID)
> -           map_gid = MAP_UNIX_TO_CYGWIN_ID (nfs_attr->gid);
> +          if (pc.fs_is_nfs4())
> +            map_gid = nfs_attr->gid;
> +          else {
> +           domain = cygheap->dom.get_rfc2307_domain ();
> +           if ((ldap_open || cldap.open (domain) == NO_ERROR))
> +             map_gid = cldap.remap_gid (nfs_attr->gid);
> +           if (map_gid == ILLEGAL_GID)
> +             map_gid = MAP_UNIX_TO_CYGWIN_ID (nfs_attr->gid);
> +          }
>           cygheap->ugid_cache.add_gid (nfs_attr->gid, map_gid);
>           buf->st_gid = map_gid;
>         }
> diff --git a/winsup/cygwin/local_includes/path.h b/winsup/cygwin/local_includes/path.h
> index ad142ddd3..b8550c05c 100644
> --- a/winsup/cygwin/local_includes/path.h
> +++ b/winsup/cygwin/local_includes/path.h
> @@ -423,6 +423,8 @@ class path_conv
>    bool fs_is_refs () const {return fs.is_refs ();}
>    bool fs_is_samba () const {return fs.is_samba ();}
>    bool fs_is_nfs () const {return fs.is_nfs ();}
> +  bool fs_is_nfs3 () const {return fs.is_nfs () && !fs.has_acls ();}
> +  bool fs_is_nfs4 () const {return fs.is_nfs () && fs.has_acls ();}
>    bool fs_is_netapp () const {return fs.is_netapp ();}
>    bool fs_is_cdrom () const {return fs.is_cdrom ();}
>    bool fs_is_mvfs () const {return fs.is_mvfs ();}
> diff --git a/winsup/cygwin/release/3.7.0 b/winsup/cygwin/release/3.7.0
> index 3f6a0ecd7..84039cea8 100644
> --- a/winsup/cygwin/release/3.7.0
> +++ b/winsup/cygwin/release/3.7.0
> @@ -26,6 +26,8 @@ What's new:
>    runs on a pty rather than on the console device originating from the pseudo
>    console.
>
> +- Support for uid/gid passthru on NFSv4 without involving LDAP.
> +
>  Fixes:
>  ------
> --
> 2.51.0
>


-- 
Lionel
