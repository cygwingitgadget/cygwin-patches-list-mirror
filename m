Return-Path: <cygwin-patches-return-8419-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63266 invoked by alias); 19 Mar 2016 17:46:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63144 invoked by uid 89); 19 Mar 2016 17:46:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches
X-HELO: mail-qk0-f196.google.com
Received: from mail-qk0-f196.google.com (HELO mail-qk0-f196.google.com) (209.85.220.196) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Sat, 19 Mar 2016 17:46:15 +0000
Received: by mail-qk0-f196.google.com with SMTP id e124so5022186qkc.3        for <cygwin-patches@cygwin.com>; Sat, 19 Mar 2016 10:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to         :references;        bh=I9sbk5BjroES3SPHFPKE9304sicpSq3KOjPO++TvHP0=;        b=jX2l0fNMbYWrmSWvDbiRfzLa+/lSYCJ1NeE2xjb6bK7xytO/LNROlJ4I5ImNclBrA6         +VQvYFQTi0UEwg9qnEg07SWXhwlo1bbomEMO6p+XuO4+76K2LgBwCNJEGsnb2gzaFpuh         Qvg41M/J5LjlX3hbPyJVcKrO5XHS0Rjxf5tWwYFPv0RsD4aIuBEBpyIQiuIZzxguF2Vr         Hev1h0pPG+e3rx8TEyAXKjczsf2R72oDqPli3iabA5Y0ZgJaRnF8u4BXaxJ6j/jKRSwE         9WR2KSoHeUEUw5IAcMzv6d1ehgLxUK/+CKoSXxYYq0vwGB6Xfpp/jPJCaC3Kdm1DqQFd         4HqA==
X-Gm-Message-State: AD7BkJKafkPpCfWt/yP4vzDBseKRbSiI7oV9t+zhq1kU8ul2v8ly1Az27jOR3l2fG3SMkg==
X-Received: by 10.55.48.80 with SMTP id w77mr31021393qkw.7.1458409573866;        Sat, 19 Mar 2016 10:46:13 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id 78sm8582720qgt.1.2016.03.19.10.46.13        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Sat, 19 Mar 2016 10:46:13 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 03/11] Add necessary braces to if statements
Date: Sat, 19 Mar 2016 17:46:00 -0000
Message-Id: <1458409557-13156-3-git-send-email-pefoley2@pefoley.com>
In-Reply-To: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00125.txt.bz2

The missing braces cause only the first expression to be guarded by the
else clause.

winsup/cygwin/ChangeLog
* fhandler_disk_file.cc (facl): Add missing braces to if statement.
* mount.cc (dos_drive_mappings): Add missing braces to if statement.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/cygwin/fhandler_disk_file.cc | 3 ++-
 winsup/cygwin/mount.cc              | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc
index 470dae8..2cf738f 100644
--- a/winsup/cygwin/fhandler_disk_file.cc
+++ b/winsup/cygwin/fhandler_disk_file.cc
@@ -1055,11 +1055,12 @@ cant_access_acl:
 	  case GETACL:
 	    if (!aclbufp)
 	      set_errno(EFAULT);
-	    else
+	    else {
 	      res = getacl (get_stat_handle (), pc, nentries, aclbufp);
 	      /* For this ENOSYS case, see security.cc:get_file_attribute(). */
 	      if (res == -1 && get_errno () == ENOSYS)
 		goto cant_access_acl;
+            }
 	    break;
 	  case GETACLCNT:
 	    res = getacl (get_stat_handle (), pc, 0, NULL);
diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
index ece8745..22bc49c 100644
--- a/winsup/cygwin/mount.cc
+++ b/winsup/cygwin/mount.cc
@@ -1962,7 +1962,7 @@ dos_drive_mappings::dos_drive_mappings ()
   HANDLE sh = FindFirstVolumeW (vol, 64);
   if (sh == INVALID_HANDLE_VALUE)
     debug_printf ("FindFirstVolumeW, %E");
-  else
+  else {
     do
       {
 	/* Skip drives which are not mounted. */
@@ -2023,6 +2023,7 @@ dos_drive_mappings::dos_drive_mappings ()
       }
     while (FindNextVolumeW (sh, vol, 64));
     FindVolumeClose (sh);
+  }
 }
 
 wchar_t *
-- 
2.7.4
