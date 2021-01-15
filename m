Return-Path: <ben@wijen.net>
Received: from 14.mo1.mail-out.ovh.net (14.mo1.mail-out.ovh.net
 [178.32.97.215])
 by sourceware.org (Postfix) with ESMTPS id 76E17398580D
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 13:46:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 76E17398580D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player772.ha.ovh.net (unknown [10.108.54.94])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 6FC731EF7FC
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 14:46:04 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id D968B1A22021E;
 Fri, 15 Jan 2021 13:46:01 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0069ce0456e-3934-4783-ac3c-776462a5a569,
 A7E4B4729D754038BE6A0219279DD51DC757EBD6) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
From: Ben Wijen <ben@wijen.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH 09/11] mount.cc: Implement poor-man's cache
Date: Fri, 15 Jan 2021 14:45:32 +0100
Message-Id: <20210115134534.13290-10-ben@wijen.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115134534.13290-1-ben@wijen.net>
References: <20210115134534.13290-1-ben@wijen.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11284894770127521540
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtddvgdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuvghnucghihhjvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepieelvddtjeffgeetjeduffegkeeltdetffektdfgvdejledugfeffefgfeefffeknecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-13.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 15 Jan 2021 13:46:07 -0000

Try to avoid NtQueryVolumeInformationFile.
---
 winsup/cygwin/mount.cc | 78 ++++++++++++++++++++++++++++--------------
 winsup/cygwin/mount.h  |  2 +-
 winsup/cygwin/path.cc  |  2 +-
 winsup/cygwin/path.h   |  1 +
 4 files changed, 56 insertions(+), 27 deletions(-)

diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
index e0349815d..1d2b3a61a 100644
--- a/winsup/cygwin/mount.cc
+++ b/winsup/cygwin/mount.cc
@@ -82,6 +82,32 @@ win32_device_name (const char *src_path, char *win32_path, device& dev)
   return true;
 }
 
+static uint32_t
+hash_prefix (const PUNICODE_STRING upath)
+{
+  UNICODE_STRING prefix;
+  WCHAR *p;
+
+  if (upath->Buffer[5] == L':' && upath->Buffer[6] == L'\\')
+    p = upath->Buffer + 6;
+  else
+    {
+      /* We're expecting an UNC path.  Move p to the backslash after
+       "\??\UNC\server\share" or the trailing NUL. */
+      p = upath->Buffer + 7; /* Skip "\??\UNC" */
+      int bs_cnt = 0;
+
+      while (*++p)
+        if (*p == L'\\')
+          if (++bs_cnt > 1)
+            break;
+    }
+  RtlInitCountedUnicodeString (&prefix, upath->Buffer,
+                               (p - upath->Buffer) * sizeof(WCHAR));
+
+  return hash_path_name ((ino_t) 0, &prefix);
+}
+
 /* Beginning with Samba 3.0.28a, Samba allows to get version information using
    the ExtendedInfo member returned by a FileFsObjectIdInformation request.
    We just store the samba_version information for now.  Older versions than
@@ -106,14 +132,16 @@ class fs_info_cache
   struct {
     fs_info fsi;
     uint32_t hash;
+    uint32_t prefix_hash;
   } entry[MAX_FS_INFO_CNT];
 
   uint32_t genhash (PFILE_FS_VOLUME_INFORMATION);
 
 public:
   fs_info_cache () : count (0) { fsi_lock.init ("fsi_lock"); }
+  fs_info *search (uint32_t);
   fs_info *search (PFILE_FS_VOLUME_INFORMATION, uint32_t &);
-  void add (uint32_t, fs_info *);
+  void add (uint32_t, fs_info *, uint32_t);
 };
 
 static fs_info_cache fsi_cache;
@@ -142,22 +170,31 @@ fs_info_cache::search (PFILE_FS_VOLUME_INFORMATION pffvi, uint32_t &hash)
       return &entry[i].fsi;
   return NULL;
 }
+fs_info*
+fs_info_cache::search (uint32_t prefix_hash)
+{
+  for (uint32_t i = 0; i < count; ++i)
+    if (entry[i].prefix_hash == prefix_hash)
+      return &entry[i].fsi;
+  return NULL;
+}
 
 void
-fs_info_cache::add (uint32_t hashval, fs_info *new_fsi)
+fs_info_cache::add (uint32_t hashval, fs_info *new_fsi, uint32_t prefix_hash)
 {
   fsi_lock.acquire ();
   if (count < MAX_FS_INFO_CNT)
     {
       entry[count].fsi = *new_fsi;
       entry[count].hash = hashval;
+      entry[count].prefix_hash = prefix_hash;
       ++count;
     }
   fsi_lock.release ();
 }
 
 bool
-fs_info::update (PUNICODE_STRING upath, HANDLE in_vol)
+fs_info::update (PUNICODE_STRING upath, HANDLE in_vol, bool use_prefix_hash)
 {
   NTSTATUS status = STATUS_OBJECT_NAME_NOT_FOUND;
   HANDLE vol;
@@ -178,6 +215,17 @@ fs_info::update (PUNICODE_STRING upath, HANDLE in_vol)
   UNICODE_STRING fsname;
 
   clear ();
+
+  if (use_prefix_hash)
+    {
+      fs_info *fsi = fsi_cache.search (hash_prefix (upath));
+      if (fsi)
+        {
+          *this = *fsi;
+          return true;
+        }
+    }
+
   /* Always caseinsensitive.  We really just need access to the drive. */
   InitializeObjectAttributes (&attr, upath, OBJ_CASE_INSENSITIVE, NULL, NULL);
   if (in_vol)
@@ -233,27 +281,7 @@ fs_info::update (PUNICODE_STRING upath, HANDLE in_vol)
 	 a unique per-drive/share hash. */
       if (ffvi_buf.ffvi.VolumeSerialNumber == 0)
 	{
-	  UNICODE_STRING path_prefix;
-	  WCHAR *p;
-
-	  if (upath->Buffer[5] == L':' && upath->Buffer[6] == L'\\')
-	    p = upath->Buffer + 6;
-	  else
-	    {
-	      /* We're expecting an UNC path.  Move p to the backslash after
-	         "\??\UNC\server\share" or the trailing NUL. */
-	      p = upath->Buffer + 7;  /* Skip "\??\UNC" */
-	      int bs_cnt = 0;
-
-	      while (*++p)
-		if (*p == L'\\')
-		    if (++bs_cnt > 1)
-		      break;
-	    }
-	  RtlInitCountedUnicodeString (&path_prefix, upath->Buffer,
-				       (p - upath->Buffer) * sizeof (WCHAR));
-	  ffvi_buf.ffvi.VolumeSerialNumber = hash_path_name ((ino_t) 0,
-							     &path_prefix);
+	  ffvi_buf.ffvi.VolumeSerialNumber = hash_prefix(upath);
 	}
       fs_info *fsi = fsi_cache.search (&ffvi_buf.ffvi, hash);
       if (fsi)
@@ -460,7 +488,7 @@ fs_info::update (PUNICODE_STRING upath, HANDLE in_vol)
 
   if (!in_vol)
     NtClose (vol);
-  fsi_cache.add (hash, this);
+  fsi_cache.add (hash, this, hash_prefix (upath));
   return true;
 }
 
diff --git a/winsup/cygwin/mount.h b/winsup/cygwin/mount.h
index 122a679a8..86b72fb4c 100644
--- a/winsup/cygwin/mount.h
+++ b/winsup/cygwin/mount.h
@@ -124,7 +124,7 @@ class fs_info
 
   const char *fsname () const { return fsn[0] ? fsn : "unknown"; }
 
-  bool __reg3 update (PUNICODE_STRING, HANDLE);
+  bool __reg3 update (PUNICODE_STRING, HANDLE, bool=false);
   bool inited () const { return !!status.flags; }
 };
 
diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index f00707e86..9e803f986 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -1179,7 +1179,7 @@ path_conv::check (const char *src, unsigned opt,
 	{
 	  /* If FS hasn't been checked already in symlink_info::check,
 	     do so now. */
-	  if (fs.inited ()|| fs.update (get_nt_native_path (), NULL))
+	  if (fs.inited ()|| fs.update (get_nt_native_path (), NULL, opt & PC_FS_USE_PREFIX_HASH))
 	    {
 	      /* Incoming DOS paths are treated like DOS paths in native
 		 Windows applications.  No ACLs, just default settings. */
diff --git a/winsup/cygwin/path.h b/winsup/cygwin/path.h
index 56855e1c9..b9264811e 100644
--- a/winsup/cygwin/path.h
+++ b/winsup/cygwin/path.h
@@ -60,6 +60,7 @@ enum pathconv_arg
   PC_NO_ACCESS_CHECK	 = _BIT (13),	/* helper flag for error check */
   PC_SYM_NOFOLLOW_DIR	 = _BIT (14),	/* don't follow a trailing slash */
   PC_SKIP_SYM_CHECK	 = _BIT (15),	/* skip symlink_info::check */
+  PC_FS_USE_PREFIX_HASH	 = _BIT (16),	/* in fs_info search by prefix hash */
   PC_DONT_USE		 = _BIT (31)	/* conversion to signed happens. */
 };
 
-- 
2.29.2

