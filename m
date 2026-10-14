Return-Path: <SRS0=BcLe=IE=gmail.com=lionelcons1972@sourceware.org>
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by sourceware.org (Postfix) with ESMTPS id 88D3F4BA2E15
	for <cygwin-patches@cygwin.com>; Wed, 14 Oct 2026 06:25:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 88D3F4BA2E15
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 88D3F4BA2E15
Authentication-Results: sourceware.org; arc=pass smtp.remote-ip=2a00:1450:4864:20::633
ARC-Seal: i=2; a=rsa-sha256; d=sourceware.org; s=key; t=1791959140; cv=pass;
	b=GJG83Uis17ssigMnXF/KA9iIY2p+GPtJdrnBCbV1BFp4lmTaV0ezvEYckSjc3+2tGuIf0XL5HGFnMfuMc0VWqgkXx5haPPI4WLwIRFfWJXF9cK+iwLUx5af+I0XI+jWIuOidHm4s+DyhRzVisfAectMiOZp7v+p6y1i+WbTS11U=
ARC-Message-Signature: i=2; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791959140; c=relaxed/simple;
	bh=tZfzj4u5pzEcuihU3ZapdNhINpMZqf18lMeOfTWwGIc=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=DTvPpAB9h/4LYDrP2kFqvYlhDd7dNhSqK+zmgRDoRRMQJXkJfXeDJ2kjv90IkB067vqf0IBw/Q51BVWH0l+lMzLLl/jU/7kClZHR8ERkCWPVzT/yzgkC2D9/pyR7qzNlr1pla8Un5fNxgCpWIeXZAaABjkr532bP06NBpbcI4zU=
ARC-Authentication-Results: i=2; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ozhq3jKR
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 88D3F4BA2E15
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ozhq3jKR
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-c2e8c710847so461230566b.0
        for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2026 23:25:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791959139; cv=none;
        d=google.com; s=arc-20260327;
        b=eSAjfE5q59heOP9sxNio7CWkJovexdQyKj82hjeNw08Ecl5Jf0y4fEfHtMNMLrC3gw
         Qsi3DuJQH19VW5tl2eO5NmSJjoxIQNSAqPIcSmymQ0ZLSfSyUbWDsm//gQkPIeF4X3Ig
         /rWFkmRx6CXRhTPClToz8HmCc7HEGGlYUcZfmWRkeF/YWUQt/XowXam6UxrU3ItgaFJH
         PvWfLIeUwa85JYgNaR2/7AO4Z8LM+AQ8//5n4+5iPtfK8I2yWX/ns8kqYbJ2EtsAUNNG
         7mxauNprlMnA49K65mJe3L6bTr0DtEG/rr1cqCLAsZAxRZ9xfbICvCknplovdX9CVfkj
         6TGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=WcisubH5JkewUgXyjC6MUzWdacJf1WBtWZVrg1G5qXc=;
        fh=YLobnwiB6mlxg8mZw4jwzI5+9rNrzFWI954radGPi+I=;
        b=lxLu8beVJzfN32fWv93bZouJpSqp+klgTJN3YFJhNGov7HAlmckrEqTxCmHg0KnHpF
         3750Ek8MC+UzH1P7CRoRDUBrHZoZBBFyZAclOoKzVHfLLKymRmopUBVl7dXVlk8kQn4M
         jIysAOeDgm1k4Q8RAFbzrVf6pFZLp/URJnw5loJOL0Uqv+2FOAlLp+azgnU3OW06Dzwe
         IZFsPUM9nKAmAYihL49cINqBH1XUmIAqGe6bVEpEJxOL6AjniF3etb4rOYxrpwx+UC2g
         EHGQEtVgzZwv93cEEiDvKk7G7bShnJ/n8CDMNvRVNyn0RyaO/3VkB8BNEgIPt8ngX7yC
         QERQ==;
        darn=cygwin.com
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791959139; x=1792563939; darn=cygwin.com;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WcisubH5JkewUgXyjC6MUzWdacJf1WBtWZVrg1G5qXc=;
        b=Ozhq3jKR/+5HJW+75gsdN8Arqx0lHBZu+8pdxFQ6za+S8uZ4qq+NDP/enDRV6UEXk4
         XIXSkJFijJzGTYK3yi7HLoJ2DB3Ii72jB0qS5lYsqjLH5SAOBmijVbtKwSgyMyBR0NEp
         ejvwi1vTuft9OocOHk+BlD6gON1NLuv51LRLeL/t5Z6D74WgKmTHiemLVoByW1kHO4o5
         qAt9lxHvSTDjD4AZPFKgjVlNaLeomf/yoa7JTNmsJPmTFCq62bdrDCiYa0h23KTSdB//
         Xm+IQa4Sh+d4oakwGstLqcDWwCtXfxEWFJbJRBW5mXlY78+2XTDnM+mHvPxtKjiVJvzb
         VdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791959139; x=1792563939;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WcisubH5JkewUgXyjC6MUzWdacJf1WBtWZVrg1G5qXc=;
        b=YVj98P8S9XNtpuSZdC1wweDkhle6t3cAFiTNO1PwjIqacZhLHCWQe2lFBSKFcHoub1
         PVWj6QyHIAjCYsaaTG8FVQft+IK4aj53BtynNqGXFjOfV2He0RRvNTEFSLC7c+yHNsA1
         gzoA8ZVDl9HXbnHLgwQI/47GmBa2iEOZConTj3390MzIFRGqjhLAlXVRAZbfmu3mOZh6
         TySmUBIxKr6/niaXiwiC1xiXMFdica6E5fRe5V4WbzAv0lf5oR/FEsxCicuVGSF3HIEi
         5o6cP41dLEzfvuO4hmY1FtD7r1DBhqEIxGRf4OgrQMANK3TDeNgvF6vLWIIsAjs97/ne
         8WlA==
X-Gm-Message-State: AFq9FYITze+xrJHFaAQV428iyl/fcBhzomlXUSy5E1gNTXWrMH2a0loH
	2dxtMgmbZWroztw35qWzWVLHLureg9B2mHx/+cnOlrrM054RCxnpl5t6J1D6X01OilWF+ls93bo
	11hCxtHCAsqXiiFTxrINPOsg87ZK6zDvuhg==
X-Gm-Gg: AYBFou1vcmm9OPEm/WLNxga84JGQZztvDZztDTCybcQCtje3hCbSdfCrPZF2MyaDQ9O
	K91eU0sHOD+nwmGsWXzhr48Pg6snMoiHZQSr7QL2h1vh+WY/o4z3WuhCJOoDBL2BX7hS0lFNMMM
	Z0cFnmaMBvk+JpL7UlYdXz2HWO3dF1Rp/5PC3OCRWMT5XYaLeGOW32nBts72w3tL1c/8imsemZh
	Epepgpgo1Pyd9hVJyokETUaK91HNHyE5BO7MFGfQ6pnj8/EQ6qj2wtnXLP2FCCFYae2pv0sX+KH
	yrHDms0v198uEsRPlSKV7E3whvrhqr5U3PpZGbECGtZQm9cp0MxX54Om1Q==
X-Received: by 2002:a17:907:2d26:b0:c2a:f571:312f with SMTP id
 a640c23a62f3a-c31a9d0eb21mr1358010666b.20.1791959138751; Tue, 13 Oct 2026
 23:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260920035524.60008-1-mark@maxrnd.com>
In-Reply-To: <20260920035524.60008-1-mark@maxrnd.com>
From: Lionel Cons <lionelcons1972@gmail.com>
Date: Wed, 14 Oct 2026 08:24:00 +0200
X-Gm-Features: AclHuK-KzgwHme-ASMqY3q34arAqe-2AnGiu0-NErh1oLw9BqRcE-FHP5jifacY
Message-ID: <CAPJSo4UaKfnUZCB1zjYD1mVXzUcE38c+e_Nu2QTXH0VJUg_k0g@mail.gmail.com>
Subject: Porting "Cygwin: Handle uids/gids correctly on NFSv4 filesystems" to
 Cygwin 3.6? Fwd: [PATCH] Cygwin: Handle uids/gids correctly on NFSv4 filesystems
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Can this patch please be ported to Cygwin 3.6-branch? The scope,
impact and risk is clearly defined as being limited to NFSv4
filesystems. As the current code in Cygwin3.6-release does not work
with NFSv4 filesystems this patch would fix things without impacting
anything else.

Lionel

---------- Forwarded message ---------
From: Mark Geisert <mark@maxrnd.com>
Date: Sun, 20 Sept 2026 at 05:55
Subject: [PATCH] Cygwin: Handle uids/gids correctly on NFSv4 filesystems
To: <cygwin-patches@cygwin.com>
Cc: Mark Geisert <mark@maxrnd.com>, Lionel Cons
<lionelcons1972@gmail.com>, Roland Mainz <roland.mainz@nrubsig.org>


Currently, Cygwin assumes that all Windows NFS clients operate
similarly to the Windows NFSv3 client. It expects that account names
and numeric uid/gid values are identical on both the client and server
sides, with LDAP acting as the sole authority for these numeric
values.

However, the NFSv4 protocol fundamentally changes this paradigm. As
defined in RFC 7530 (Section 5.9) and expanded upon in RFC 8178 (Rules
for NFSv4 Domain and ID Mapping), NFSv4 deprecates raw numeric uid/gid
protocol representation in favor of string-based identifiers (e.g.,
user@domain and group@domain).

To handle this, all NFSv4 clients implement a local "idmapper"
component that translates these string-based identities from the
network side into local account data (in the case of Windows, mapping
user/group names and uid/gid values via nfs3attr XATTR). Because NFSv4
clients manage their own uid/gid translation locally, Cygwin's
reliance on raw LDAP data fails in these environments and results in
the dreaded "Unix_User+<1234>" and "Unix_Group+<5678>"-kind of
owner/group output in Cygwin ls -l.

The [...] patch addresses this by detecting whether the underlying
filesystem is NFSv4. If it is, Cygwin bypasses the LDAP assumption and
performs a direct pass-through of the uid/gid values supplied by the
NFSv4 client's idmapper.

[Lionel has] successfully tested this fix against several major clients,
including:
- Exceed NFSv4 client
- OpenText NFSv4 client
- ms-nfs41-client
- ms-nfs42-client
- Windows NFSv3 client (no change, it continues to use LDAP raw data)

Reported-by: Lionel Cons <lionelcons1972@gmail.com>
Addresses: https://cygwin.com/pipermail/cygwin-patches/2026q3/015287.html
Authored-by: Roland Mainz <roland.mainz@nrubsig.org>
Reviewed-by: Mark Geisert <mark@maxrnd.com>
Fixes: 88dce3a (Try harder to avoid LDAP access for RFC2307 mapping)

---
 winsup/cygwin/fhandler/disk_file.cc | 30 ++++++++++++++++++-----------
 winsup/cygwin/local_includes/path.h |  2 ++
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/winsup/cygwin/fhandler/disk_file.cc
b/winsup/cygwin/fhandler/disk_file.cc
index f284b4a05..e4d20b6c5 100644
--- a/winsup/cygwin/fhandler/disk_file.cc
+++ b/winsup/cygwin/fhandler/disk_file.cc
@@ -214,7 +214,7 @@ fhandler_base::fstat_by_nfs_ea (struct stat *buf)
      access through another handle invalidates the caching within the
      NFS client.  Skip this for Cygwin-created Symlinks playing FIFOs
      (this sets the filler1 member to NF3FIFO). */
-  if (get_handle () && nfs_attr->filler1 != NF3FIFO)
+  if (get_handle () && pc.fs_is_nfs3() && (nfs_attr->filler1 != NF3FIFO))
     {
       if (get_access () & GENERIC_WRITE)
        FlushFileBuffers (get_handle ());
@@ -236,11 +236,15 @@ fhandler_base::fstat_by_nfs_ea (struct stat *buf)
        {
          uid_t map_uid = ILLEGAL_UID;

-         domain = cygheap->dom.get_rfc2307_domain ();
-         if ((ldap_open = (cldap.open (domain) == NO_ERROR)))
-           map_uid = cldap.remap_uid (nfs_attr->uid);
-         if (map_uid == ILLEGAL_UID)
-           map_uid = MAP_UNIX_TO_CYGWIN_ID (nfs_attr->uid);
+          if (pc.fs_is_nfs4())
+            map_uid = nfs_attr->uid;
+          else {
+           domain = cygheap->dom.get_rfc2307_domain ();
+           if ((ldap_open = (cldap.open (domain) == NO_ERROR)))
+             map_uid = cldap.remap_uid (nfs_attr->uid);
+           if (map_uid == ILLEGAL_UID)
+             map_uid = MAP_UNIX_TO_CYGWIN_ID (nfs_attr->uid);
+          }
          cygheap->ugid_cache.add_uid (nfs_attr->uid, map_uid);
          buf->st_uid = map_uid;
        }
@@ -255,11 +259,15 @@ fhandler_base::fstat_by_nfs_ea (struct stat *buf)
        {
          gid_t map_gid = ILLEGAL_GID;

-         domain = cygheap->dom.get_rfc2307_domain ();
-         if ((ldap_open || cldap.open (domain) == NO_ERROR))
-           map_gid = cldap.remap_gid (nfs_attr->gid);
-         if (map_gid == ILLEGAL_GID)
-           map_gid = MAP_UNIX_TO_CYGWIN_ID (nfs_attr->gid);
+          if (pc.fs_is_nfs4())
+            map_gid = nfs_attr->gid;
+          else {
+           domain = cygheap->dom.get_rfc2307_domain ();
+           if ((ldap_open || cldap.open (domain) == NO_ERROR))
+             map_gid = cldap.remap_gid (nfs_attr->gid);
+           if (map_gid == ILLEGAL_GID)
+             map_gid = MAP_UNIX_TO_CYGWIN_ID (nfs_attr->gid);
+          }
          cygheap->ugid_cache.add_gid (nfs_attr->gid, map_gid);
          buf->st_gid = map_gid;
        }
diff --git a/winsup/cygwin/local_includes/path.h
b/winsup/cygwin/local_includes/path.h
index ad142ddd3..b8550c05c 100644
--- a/winsup/cygwin/local_includes/path.h
+++ b/winsup/cygwin/local_includes/path.h
@@ -423,6 +423,8 @@ class path_conv
   bool fs_is_refs () const {return fs.is_refs ();}
   bool fs_is_samba () const {return fs.is_samba ();}
   bool fs_is_nfs () const {return fs.is_nfs ();}
+  bool fs_is_nfs3 () const {return fs.is_nfs () && !fs.has_acls ();}
+  bool fs_is_nfs4 () const {return fs.is_nfs () && fs.has_acls ();}
   bool fs_is_netapp () const {return fs.is_netapp ();}
   bool fs_is_cdrom () const {return fs.is_cdrom ();}
   bool fs_is_mvfs () const {return fs.is_mvfs ();}
diff --git a/winsup/cygwin/release/3.7.0 b/winsup/cygwin/release/3.7.0
index 3f6a0ecd7..84039cea8 100644
--- a/winsup/cygwin/release/3.7.0
+++ b/winsup/cygwin/release/3.7.0
@@ -26,6 +26,8 @@ What's new:
   runs on a pty rather than on the console device originating from the pseudo
   console.

+- Support for uid/gid passthru on NFSv4 without involving LDAP.
+
 Fixes:
 ------
--
2.51.0



-- 
Lionel
