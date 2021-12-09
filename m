Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id 2F5AB385803D
 for <cygwin-patches@cygwin.com>; Thu,  9 Dec 2021 08:18:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2F5AB385803D
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 1B98Hlp0023800;
 Thu, 9 Dec 2021 17:17:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 1B98Hlp0023800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1639037873;
 bh=97urM7xY+aG03YPvBUAFevLqJoAbxuYBGUDRRUsOTzE=;
 h=From:To:Cc:Subject:Date:From;
 b=TBn+zgJVmsMor6KmVqt0A1+UUzBxxMTHa7t4zBgdgmA/oyHzCBX7QnuZLLtmJI6gG
 +mD1t1rdTEXxoYZXpkJ7xwuu9P9VA+coqatZVl4ObHlCQ2h+MCEBGa/5s2LqcmWJ+1
 JMkvlOjah5VUvC8LPW3RIfjfQURciYNQpvzeqm+Sibp4dQ+kGbZPXtJ5pVsJ7sVTwH
 tfvRY+hmb3VGw2r/O9upzzl1XQWL2/kdAtLeQ8eJGJt4sALwN9PYftZG9ElVhodYKy
 xzSCUK06PD+S59YNQfVz3aH/ZbWbS2UjJJbooU5VIaXtlRI4lBAVhH9pCoApew+qWA
 Q63+5Tr99DMeA==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: path: Fix path conversion of virtual drive.
Date: Thu,  9 Dec 2021 17:17:50 +0900
Message-Id: <20211209081750.4970-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Thu, 09 Dec 2021 08:18:25 -0000

- The last change in path.cc introduced a bug that causes an error
  when accessing a virtual drive which mounts UNC path such as
  "\\server\share\dir" rather than "\\server\share". This patch
  fixes the issue.
---
 winsup/cygwin/path.cc | 50 +++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index eb1255849..6682d2a58 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -3507,29 +3507,37 @@ restart:
 		  if (RtlEqualUnicodePathPrefix (&fpath, &ro_u_uncp, TRUE)
 		      && !RtlEqualUnicodePathPrefix (&upath, &ro_u_uncp, TRUE))
 		    {
-		      /* ...get the remote path from the volume path name,
-			 replace remote path with drive letter, check again. */
+		      /* ...get the remote path, replace remote path
+			 with drive letter, check again. */
+		      WCHAR drive[3] =
+			{(WCHAR) towupper (upath.Buffer[4]), L':', L'\0'};
 		      WCHAR remote[MAX_PATH];
 
-		      fpbuf[1] = L'\\';
-		      BOOL r = GetVolumePathNameW (fpbuf, remote, MAX_PATH);
-		      fpbuf[1] = L'?';
-		      if (r)
-			{
-			  int remlen = wcslen (remote);
-			  if (remote[remlen - 1] == L'\\')
-			    remlen--;
-			  /* Hackfest */
-			  fpath.Buffer[4] = upath.Buffer[4]; /* Drive letter */
-			  fpath.Buffer[5] = L':';
-			  WCHAR *to = fpath.Buffer + 6;
-			  WCHAR *from = to + remlen - 6;
-			  memmove (to, from,
-				   (wcslen (from) + 1) * sizeof (WCHAR));
-			  fpath.Length -= (from - to) * sizeof (WCHAR);
-			  if (RtlEqualUnicodeString (&upath, &fpath, !!ci_flag))
-			    goto file_not_symlink;
-			}
+		      if (!QueryDosDeviceW (drive, remote, MAX_PATH))
+			goto file_not_symlink; /* fallback */
+
+		      int remlen = wcslen (remote);
+		      if (remote[remlen - 1] == L'\\')
+			remlen--;
+		      WCHAR *p;
+		      if (wcsstr (remote, L"\\??\\UNC\\") == remote)
+			remlen -= 6;
+		      else if ((p = wcschr (remote, L';') + 1)
+			       && wcsstr (p, drive) == p
+			       && (p = wcschr (p + 2, L'\\')))
+			remlen -= p - remote - 1;
+		      else
+			goto file_not_symlink; /* fallback */
+		      /* Hackfest */
+		      fpath.Buffer[4] = drive[0]; /* Drive letter */
+		      fpath.Buffer[5] = L':';
+		      WCHAR *to = fpath.Buffer + 6;
+		      WCHAR *from = to + remlen;
+		      memmove (to, from,
+			       (wcslen (from) + 1) * sizeof (WCHAR));
+		      fpath.Length -= (from - to) * sizeof (WCHAR);
+		      if (RtlEqualUnicodeString (&upath, &fpath, !!ci_flag))
+			goto file_not_symlink;
 		    }
 		  issymlink = true;
 		  /* upath.Buffer is big enough and unused from this point on.
-- 
2.34.1

