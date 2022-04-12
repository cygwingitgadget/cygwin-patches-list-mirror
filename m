Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-044.btinternet.com (mailomta2-sa.btinternet.com
 [213.120.69.8])
 by sourceware.org (Postfix) with ESMTPS id 49164385840C
 for <cygwin-patches@cygwin.com>; Tue, 12 Apr 2022 17:32:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 49164385840C
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
 by sa-prd-fep-044.btinternet.com with ESMTP id
 <20220412173256.UTHD24689.sa-prd-fep-044.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
 Tue, 12 Apr 2022 18:32:56 +0100
X-SNCR-Rigid: 6139417C1ED77EE7
X-Originating-IP: [86.139.167.41]
X-OWM-Source-IP: 86.139.167.41 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrudekkedgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeetgeevhefhgfehteduveffhfduueeikefgvdduvdekhfehtdfgheeijeeigeffhfenucfkphepkeeirddufeelrdduieejrdegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduieejrdeguddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.41) by
 sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 6139417C1ED77EE7; Tue, 12 Apr 2022 18:32:56 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/2] Cygwin: Fix build with w32api 10.0.0
Date: Tue, 12 Apr 2022 18:32:09 +0100
Message-Id: <20220412173210.50882-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412173210.50882-1-jon.turney@dronecode.org.uk>
References: <20220412173210.50882-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1199.4 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_NUMSUBJECT, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H5, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE,
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
X-List-Received-Date: Tue, 12 Apr 2022 17:32:58 -0000

> ../../../../src/winsup/cygwin/sec_auth.cc:1240:16: error: redefinition of ‘struct _MSV1_0_S4U_LOGON’
>  1240 | typedef struct _MSV1_0_S4U_LOGON
>       |                ^~~~~~~~~~~~~~~~~
> In file included from ../../../../src/winsup/cygwin/ntsecapi.h:10,
>                  from ../../../../src/winsup/cygwin/sec_auth.cc:13:
> /usr/include/w32api/ntsecapi.h:1425:18: note: previous definition of ‘struct _MSV1_0_S4U_LOGON’
>  1425 |   typedef struct _MSV1_0_S4U_LOGON {
>       |                  ^~~~~~~~~~~~~~~~~
> ../../../../src/winsup/cygwin/sec_auth.cc:1246:3: error: conflicting declaration ‘typedef int MSV1_0_S4U_LOGON’
>  1246 | } MSV1_0_S4U_LOGON, *PMSV1_0_S4U_LOGON;
>       |   ^~~~~~~~~~~~~~~~
> In file included from ../../../../src/winsup/cygwin/ntsecapi.h:10,
>                  from ../../../../src/winsup/cygwin/sec_auth.cc:13:
> /usr/include/w32api/ntsecapi.h:1430:5: note: previous declaration as ‘typedef struct _MSV1_0_S4U_LOGON MSV1_0_S4U_LOGON’
>  1430 |   } MSV1_0_S4U_LOGON, *PMSV1_0_S4U_LOGON;
>       |     ^~~~~~~~~~~~~~~~
> ../../../../src/winsup/cygwin/sec_auth.cc:1246:22: error: conflicting declaration ‘typedef int* PMSV1_0_S4U_LOGON’
>  1246 | } MSV1_0_S4U_LOGON, *PMSV1_0_S4U_LOGON;
>       |                      ^~~~~~~~~~~~~~~~~
> In file included from ../../../../src/winsup/cygwin/ntsecapi.h:10,
>                  from ../../../../src/winsup/cygwin/sec_auth.cc:13:
> /usr/include/w32api/ntsecapi.h:1430:24: note: previous declaration as ‘typedef struct _MSV1_0_S4U_LOGON* PMSV1_0_S4U_LOGON’
>  1430 |   } MSV1_0_S4U_LOGON, *PMSV1_0_S4U_LOGON;
---
 winsup/cygwin/sec_auth.cc | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/sec_auth.cc b/winsup/cygwin/sec_auth.cc
index 121d55e05..0e5aaeb0b 100644
--- a/winsup/cygwin/sec_auth.cc
+++ b/winsup/cygwin/sec_auth.cc
@@ -1232,8 +1232,9 @@ out:
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
 
-/* In Mingw-w64, MsV1_0S4ULogon and MSV1_0_S4U_LOGON are only defined
-   in ddk/ntifs.h.  We can't include this. */
+/* In w32api prior to 10.0.0, MsV1_0S4ULogon and MSV1_0_S4U_LOGON are only
+   defined in ddk/ntifs.h, which we can't include. */
+#if (__MINGW64_VERSION_MAJOR < 10)
 
 #define MsV1_0S4ULogon ((MSV1_0_LOGON_SUBMIT_TYPE) 12)
 
@@ -1248,6 +1249,8 @@ typedef struct _MSV1_0_S4U_LOGON
 /* Missing in Mingw-w64 */
 #define KERB_S4U_LOGON_FLAG_IDENTITY 0x08
 
+#endif
+
 /* If logon is true we need an impersonation token.  Otherwise we just
    need an identification token, e. g. to fetch the group list. */
 HANDLE
-- 
2.35.1

