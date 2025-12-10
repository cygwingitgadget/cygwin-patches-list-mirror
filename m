Return-Path: <SRS0=tdPk=6Q=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo002.btinternet.com (btprdrgo002.btinternet.com [65.20.50.70])
	by sourceware.org (Postfix) with ESMTP id 773214BA2E1F
	for <cygwin-patches@cygwin.com>; Wed, 10 Dec 2025 11:18:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 773214BA2E1F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 773214BA2E1F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.70
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765365491; cv=none;
	b=GTD0HYjsjNDSicqudOc7iHY3JDf2nUt/AiLc24uFJ6ion0pzBgd5/yp/5g3F+h2WGrc1XxzEPFcVxMC2qsArW8cnhokCEvD0gp9Mlw+jm4mcKmfpw2pLe0htGUtVai/N02QorjLWREJbFu9ZvNoYw+N72ILRcpNW98qlR6KPRyY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765365491; c=relaxed/simple;
	bh=Feaj8UtGpPmVgP68gS2ZwIK1EI6/KxeCQa07KYDkZmY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=h/gxMpfc6AiSHsI/bZZ5r/GYMG1m6HZBi7O78PLMM4afvgCJuYUK4gJCczB1My0ELh+hcJVu8riXtFzYDKD8WriCIADwKV/gs4IYHuztW1WpmAz8Qc91UW0dXIutxdabqP6EkJ5qFgySKq8Arr348frsNMMfUeSnIhuBbZhVQkM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 773214BA2E1F
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 68CA1AB8086A75E3
X-Originating-IP: [81.158.20.216]
X-OWM-Source-IP: 81.158.20.216
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeehuedutdehhfeutefgieefgfelieettdeigfdtfffhvdevgeegteejfeeftdehgfenucfkphepkedurdduheekrddvtddrvdduieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehtrghmsghorhgrpdhinhgvthepkedurdduheekrddvtddrvdduiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddqudehkedqvddtqddvudeirdhrrghnghgvkeduqdduheekrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttddvpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhn
	vggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from tambora (81.158.20.216) by btprdrgo002.btinternet.com (authenticated as jonturney@btinternet.com)
        id 68CA1AB8086A75E3; Wed, 10 Dec 2025 11:18:10 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Drop __MINGW64_VERSION_MAJOR version conditionals
Date: Wed, 10 Dec 2025 11:18:03 +0000
Message-ID: <20251210111804.16215-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Unneeded now we check the version at configure-time.
---
 winsup/cygwin/local_includes/ntdll.h | 31 ----------------------------
 winsup/cygwin/sec/auth.cc            | 19 -----------------
 2 files changed, 50 deletions(-)

diff --git a/winsup/cygwin/local_includes/ntdll.h b/winsup/cygwin/local_includes/ntdll.h
index 19908935f..e7afeb564 100644
--- a/winsup/cygwin/local_includes/ntdll.h
+++ b/winsup/cygwin/local_includes/ntdll.h
@@ -490,30 +490,6 @@ typedef struct _FILE_DISPOSITION_INFORMATION_EX	// 64
   ULONG Flags;
 } FILE_DISPOSITION_INFORMATION_EX, *PFILE_DISPOSITION_INFORMATION_EX;
 
-#if __MINGW64_VERSION_MAJOR < 13
-
-typedef struct _FILE_STAT_INFORMATION		// 68
-{
-  LARGE_INTEGER FileId;
-  LARGE_INTEGER CreationTime;
-  LARGE_INTEGER LastAccessTime;
-  LARGE_INTEGER LastWriteTime;
-  LARGE_INTEGER ChangeTime;
-  LARGE_INTEGER AllocationSize;
-  LARGE_INTEGER EndOfFile;
-  ULONG FileAttributes;
-  ULONG ReparseTag;
-  ULONG NumberOfLinks;
-  ACCESS_MASK EffectiveAccess;
-} FILE_STAT_INFORMATION, *PFILE_STAT_INFORMATION;
-
-typedef struct _FILE_CASE_SENSITIVE_INFORMATION	// 71
-{
-  ULONG Flags;
-} FILE_CASE_SENSITIVE_INFORMATION, *PFILE_CASE_SENSITIVE_INFORMATION;
-
-#endif
-
 enum {
   FILE_LINK_REPLACE_IF_EXISTS				= 0x01,
   FILE_LINK_POSIX_SEMANTICS				= 0x02,
@@ -545,13 +521,6 @@ enum
   FILE_RENAME_IGNORE_READONLY_ATTRIBUTE			= 0x40
 };
 
-#if (__MINGW64_VERSION_MAJOR < 11)
-enum
-{
-  FILE_CS_FLAG_CASE_SENSITIVE_DIR			= 0x01
-};
-#endif
-
 enum
 {
   FILE_PIPE_QUEUE_OPERATION = 0,
diff --git a/winsup/cygwin/sec/auth.cc b/winsup/cygwin/sec/auth.cc
index f9906a55c..ac9c258a5 100644
--- a/winsup/cygwin/sec/auth.cc
+++ b/winsup/cygwin/sec/auth.cc
@@ -693,25 +693,6 @@ out:
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
 
-/* In w32api prior to 10.0.0, MsV1_0S4ULogon and MSV1_0_S4U_LOGON are only
-   defined in ddk/ntifs.h, which we can't include. */
-#if (__MINGW64_VERSION_MAJOR < 10)
-
-#define MsV1_0S4ULogon ((MSV1_0_LOGON_SUBMIT_TYPE) 12)
-
-typedef struct _MSV1_0_S4U_LOGON
-{
-  MSV1_0_LOGON_SUBMIT_TYPE MessageType;
-  ULONG Flags;
-  UNICODE_STRING UserPrincipalName;
-  UNICODE_STRING DomainName;
-} MSV1_0_S4U_LOGON, *PMSV1_0_S4U_LOGON;
-
-/* Missing in Mingw-w64 */
-#define KERB_S4U_LOGON_FLAG_IDENTIFY 0x08
-
-#endif
-
 /* If logon is true we need an impersonation token.  Otherwise we just
    need an identification token, e. g. to fetch the group list. */
 HANDLE
-- 
2.51.0

