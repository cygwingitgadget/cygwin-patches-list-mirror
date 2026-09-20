Return-Path: <SRS0=sXPq=HM=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id D0DB94BA9028
	for <cygwin-patches@cygwin.com>; Sun, 20 Sep 2026 03:55:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D0DB94BA9028
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D0DB94BA9028
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789876531; cv=none;
	b=bQoYF9mcNHzyc1obTWrnRkWntoOb0hZx1l4NAsapcnrhT2t399a4z2L3j/uEIV54CIOftukSXinTqysthIKwjPAc/ENnXZUrgxVh6uu47Cg5wiLv+imZrgTP61aPggbud8GfvCboOTehjA6VB3ccMguC6x4gXx/JVPG+pJ9hqKg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789876531; c=relaxed/simple;
	bh=JMWyGyqcSr8LzpbsEaQOoEoBBXd3NVWPCB+O8YjjsCQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=xvvGaHTF3lWgrCTjafK1plDU/+5LvKZqoOzJiACDr8fDl5nm4SFWvVhyJIER3HW22EszlZ+apWZV/p4T43eyu/HDTU7DXmHtFLPYUZT8J7rogrKwR2QHXZqODGAYqyfE/5USble/UQPl6JJzfo3doH98c7kMGNBIU8r4sSWOns8=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D0DB94BA9028
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 68K49K7i050517;
	Sat, 19 Sep 2026 21:09:20 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "zotac"
 via SMTP by m0.truegem.net, id smtpdfSelua; Sat Sep 19 21:09:20 2026
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>, Lionel Cons <lionelcons1972@gmail.com>,
        Roland Mainz <roland.mainz@nrubsig.org>
Subject: [PATCH] Cygwin: Handle uids/gids correctly on NFSv4 filesystems
Date: Sat, 19 Sep 2026 20:54:07 -0700
Message-ID: <20260920035524.60008-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <https://cygwin.com/pipermail/cygwin-patches/2026q3/015275.html>
References: <https://cygwin.com/pipermail/cygwin-patches/2026q3/015275.html>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

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

diff --git a/winsup/cygwin/fhandler/disk_file.cc b/winsup/cygwin/fhandler/disk_file.cc
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
 
-	  domain = cygheap->dom.get_rfc2307_domain ();
-	  if ((ldap_open = (cldap.open (domain) == NO_ERROR)))
-	    map_uid = cldap.remap_uid (nfs_attr->uid);
-	  if (map_uid == ILLEGAL_UID)
-	    map_uid = MAP_UNIX_TO_CYGWIN_ID (nfs_attr->uid);
+          if (pc.fs_is_nfs4())
+            map_uid = nfs_attr->uid;
+          else {
+	    domain = cygheap->dom.get_rfc2307_domain ();
+	    if ((ldap_open = (cldap.open (domain) == NO_ERROR)))
+	      map_uid = cldap.remap_uid (nfs_attr->uid);
+	    if (map_uid == ILLEGAL_UID)
+	      map_uid = MAP_UNIX_TO_CYGWIN_ID (nfs_attr->uid);
+          }
 	  cygheap->ugid_cache.add_uid (nfs_attr->uid, map_uid);
 	  buf->st_uid = map_uid;
 	}
@@ -255,11 +259,15 @@ fhandler_base::fstat_by_nfs_ea (struct stat *buf)
 	{
 	  gid_t map_gid = ILLEGAL_GID;
 
-	  domain = cygheap->dom.get_rfc2307_domain ();
-	  if ((ldap_open || cldap.open (domain) == NO_ERROR))
-	    map_gid = cldap.remap_gid (nfs_attr->gid);
-	  if (map_gid == ILLEGAL_GID)
-	    map_gid = MAP_UNIX_TO_CYGWIN_ID (nfs_attr->gid);
+          if (pc.fs_is_nfs4())
+            map_gid = nfs_attr->gid;
+          else {
+	    domain = cygheap->dom.get_rfc2307_domain ();
+	    if ((ldap_open || cldap.open (domain) == NO_ERROR))
+	      map_gid = cldap.remap_gid (nfs_attr->gid);
+	    if (map_gid == ILLEGAL_GID)
+	      map_gid = MAP_UNIX_TO_CYGWIN_ID (nfs_attr->gid);
+          }
 	  cygheap->ugid_cache.add_gid (nfs_attr->gid, map_gid);
 	  buf->st_gid = map_gid;
 	}
diff --git a/winsup/cygwin/local_includes/path.h b/winsup/cygwin/local_includes/path.h
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

