Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-047.btinternet.com (mailomta2-sa.btinternet.com
 [213.120.69.8])
 by sourceware.org (Postfix) with ESMTPS id CC1D6385780C
 for <cygwin-patches@cygwin.com>; Tue, 12 Apr 2022 17:32:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CC1D6385780C
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-047.btinternet.com with ESMTP id
 <20220412173259.VRF16049.sa-prd-fep-047.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
 Tue, 12 Apr 2022 18:32:59 +0100
X-SNCR-Rigid: 6139417C1ED77F6E
X-Originating-IP: [86.139.167.41]
X-OWM-Source-IP: 86.139.167.41 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrudekkedgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudefledrudeijedrgedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudeijedrgedupdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.41) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 6139417C1ED77F6E; Tue, 12 Apr 2022 18:32:59 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/2] Cygwin: Fix typo KERB_S4U_LOGON_FLAG_IDENTITY -> IDENTIFY
Date: Tue, 12 Apr 2022 18:32:10 +0100
Message-Id: <20220412173210.50882-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412173210.50882-1-jon.turney@dronecode.org.uk>
References: <20220412173210.50882-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1199.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H5,
 RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, TXREP, T_SCC_BODY_TEXT_LINE,
 T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Tue, 12 Apr 2022 17:33:01 -0000

---
 winsup/cygwin/sec_auth.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/sec_auth.cc b/winsup/cygwin/sec_auth.cc
index 0e5aaeb0b..2b1ce2203 100644
--- a/winsup/cygwin/sec_auth.cc
+++ b/winsup/cygwin/sec_auth.cc
@@ -1247,7 +1247,7 @@ typedef struct _MSV1_0_S4U_LOGON
 } MSV1_0_S4U_LOGON, *PMSV1_0_S4U_LOGON;
 
 /* Missing in Mingw-w64 */
-#define KERB_S4U_LOGON_FLAG_IDENTITY 0x08
+#define KERB_S4U_LOGON_FLAG_IDENTIFY 0x08
 
 #endif
 
@@ -1368,7 +1368,7 @@ s4uauth (bool logon, PCWSTR domain, PCWSTR user, NTSTATUS &ret_status)
       RtlSecureZeroMemory (authinf, authinf_size);
       s4u_logon = (KERB_S4U_LOGON *) authinf;
       s4u_logon->MessageType = KerbS4ULogon;
-      s4u_logon->Flags = logon ? 0 : KERB_S4U_LOGON_FLAG_IDENTITY;
+      s4u_logon->Flags = logon ? 0 : KERB_S4U_LOGON_FLAG_IDENTIFY;
       /* Append user to login info */
       RtlInitEmptyUnicodeString (&s4u_logon->ClientUpn,
 				 (PWCHAR) (s4u_logon + 1),
-- 
2.35.1

