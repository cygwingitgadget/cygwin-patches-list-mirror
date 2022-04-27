Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-045.btinternet.com (mailomta9-re.btinternet.com
 [213.120.69.102])
 by sourceware.org (Postfix) with ESMTPS id 07D85385741C
 for <cygwin-patches@cygwin.com>; Wed, 27 Apr 2022 20:35:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 07D85385741C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
 by re-prd-fep-045.btinternet.com with ESMTP id
 <20220427203531.UTGN3219.re-prd-fep-045.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
 Wed, 27 Apr 2022 21:35:31 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
 bimi=skipped
X-SNCR-Rigid: 61A69BAC14B12B8E
X-Originating-IP: [86.139.167.41]
X-OWM-Source-IP: 86.139.167.41 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvfedrudehgddugeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepheeuuddthefhueetgfeifefgleeitedtiefgtdffhfdvveeggeetjeeffedthefgnecukfhppeekiedrudefledrudeijedrgedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudeijedrgedupdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.41) by
 re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 61A69BAC14B12B8E; Wed, 27 Apr 2022 21:35:31 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Unconditionally require win32api >= 10.0.0
Date: Wed, 27 Apr 2022 21:35:14 +0100
Message-Id: <20220427203515.13607-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1198.9 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_NUMSUBJECT,
 RCVD_IN_DNSWL_NONE, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Wed, 27 Apr 2022 20:35:40 -0000

Unconditionally require win32api >= 10.0.0, and check for it at
configure time.

Note that there remains a use of __MINGW64_VERSION_MAJOR in
pseudo-reloc.cc under !CYGWIN (since that file is shared with the
MinGW and MinGW64 runtimes).
---
 winsup/configure.ac       |  9 +++++++++
 winsup/cygwin/ntdll.h     |  6 ------
 winsup/cygwin/sec_auth.cc | 19 -------------------
 winsup/cygwin/winlean.h   |  5 -----
 4 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/winsup/configure.ac b/winsup/configure.ac
index b8d2100db..41bf21c78 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -57,6 +57,15 @@ AC_CHECK_TOOL(RANLIB, ranlib, ranlib)
 AC_CHECK_TOOL(STRIP, strip, strip)
 AC_CHECK_TOOL(WINDRES, windres, windres)
 
+w32api_maj_ver_req=10
+AC_COMPILE_IFELSE([AC_LANG_PROGRAM([
+#include <windows.h>
+#if __MINGW64_VERSION_MAJOR < $w32api_maj_ver_req
+#error "w32api headers version doesn't meet requirements"
+#endif
+])],,
+AC_MSG_FAILURE("Version >= $w32api_maj_ver_req of w32api headers is required"))
+
 AC_ARG_ENABLE(debugging,
 [AS_HELP_STRING([--enable-debugging],[Build a cygwin DLL which has more consistency checking for debugging])],
 [case "${enableval}" in
diff --git a/winsup/cygwin/ntdll.h b/winsup/cygwin/ntdll.h
index 59c396676..f6b31a19d 100644
--- a/winsup/cygwin/ntdll.h
+++ b/winsup/cygwin/ntdll.h
@@ -1467,12 +1467,6 @@ extern "C"
   NTSTATUS NTAPI NtMapViewOfSection (HANDLE, HANDLE, PVOID *, ULONG_PTR, SIZE_T,
 				     PLARGE_INTEGER, PSIZE_T, SECTION_INHERIT,
 				     ULONG, ULONG);
-
-/* For the extended memory API. */
-#if __MINGW64_VERSION_MAJOR < 8
-#error "Version >= 8 of the w32api headers is required"
-#endif
-
   NTSTATUS NTAPI NtMapViewOfSectionEx (HANDLE, HANDLE, PVOID *, PLARGE_INTEGER,
 				       PSIZE_T, ULONG, ULONG,
 				       PMEM_EXTENDED_PARAMETER, ULONG);
diff --git a/winsup/cygwin/sec_auth.cc b/winsup/cygwin/sec_auth.cc
index 2b1ce2203..9ac476284 100644
--- a/winsup/cygwin/sec_auth.cc
+++ b/winsup/cygwin/sec_auth.cc
@@ -1232,25 +1232,6 @@ out:
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
diff --git a/winsup/cygwin/winlean.h b/winsup/cygwin/winlean.h
index de7305e26..6f9c1df24 100644
--- a/winsup/cygwin/winlean.h
+++ b/winsup/cygwin/winlean.h
@@ -99,11 +99,6 @@ details. */
 extern "C" {
 #endif
 
-/* For the extended memory API. */
-#if __MINGW64_VERSION_MAJOR < 8
-#error "Version >= 8 of the w32api headers is required"
-#endif
-
 /* IsWow64Process2 should be declared in <w32api/wow64apiset.h> but
    isn't yet. */
 BOOL WINAPI IsWow64Process2(HANDLE, USHORT *, USHORT *);
-- 
2.36.0

