Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.12])
 by sourceware.org (Postfix) with ESMTPS id 461483858034
 for <cygwin-patches@cygwin.com>; Sun,  7 Mar 2021 16:32:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 461483858034
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net. ([68.147.0.90])
 by shaw.ca with ESMTP
 id IwJxlO7Bv2SWTIwJylARpu; Sun, 07 Mar 2021 09:31:59 -0700
X-Authority-Analysis: v=2.4 cv=fdJod2cF c=1 sm=1 tr=0 ts=6044ffff
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=nz-5sxVJmLUA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=fh5gI7x97N_p-jr0LVUA:9
 a=QEXdDO2ut3YA:10 a=LF2dOfbMAAAA:8 a=QvAIt3kNAAAA:8 a=Nw0LwjvyqC6pTE07XZUA:9
 a=B2y7HmGcmWMA:10 a=TmiWL2DCWjWbbQwbIu5r:22 a=9oA7IM7z5FsGlzIePPOQ:22
 a=BPzZvq435JnGatEyYwdK:22 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] winsup/doc/dll.xml: update MinGW/.org to MinGW-w64/.org
Date: Sun,  7 Mar 2021 09:31:55 -0700
Message-Id: <20210307163155.63871-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.30.0
Reply-To: patches
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.30.0"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAOOj7fK0BVOtRLh0I0leeJ5V0oWsmOrSoBQ2MhTwiOkVQLW9FpuM77cnmoypkah+I3MxllhtHYOoI/5NXb8GUm18CKzVgEisAyiBIRKpIdmw7/NPXp3
 v5zl4Pvcmk/anUmKbHv4iuaieehf+ypti9bVeLWRe3HG5GE7y6/Vh/0hCj5GfvPbn7e4P+UQFLYXTDIlboikDorenGwVR/VXvJQG/4TygwERGL46O0a2+ChB
 9xBlwMLryg7pCJyTdWunD7eNmXefyRJO3i2TaPiWBn8=
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Sun, 07 Mar 2021 16:32:01 -0000

This is a multi-part message in MIME format.
--------------2.30.0
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit

---
 winsup/doc/dll.xml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


--------------2.30.0
Content-Type: text/x-patch; name="0001-winsup-doc-dll.xml-update-MinGW-.org-to-MinGW-w64-.org.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-winsup-doc-dll.xml-update-MinGW-.org-to-MinGW-w64-.org.patch"

diff --git a/winsup/doc/dll.xml b/winsup/doc/dll.xml
index f0369760f0ea..5cee0b708ead 100644
--- a/winsup/doc/dll.xml
+++ b/winsup/doc/dll.xml
@@ -103,8 +103,9 @@ you will probably want to use the complete syntax:</para>
 The name of your library is <literal>${module}</literal>, prefixed with
 <literal>cyg</literal> for the DLL and <literal>lib</literal> for the
 import library. Cygwin DLLs use the <literal>cyg</literal> prefix to 
-differentiate them from native-Windows MinGW DLLs, see 
-<ulink url="http://mingw.org">the MinGW website</ulink> for more details.
+differentiate them from native-Windows MinGW-w64 DLLs, see the 
+<ulink url="http://mingw-w64.org">GCC for Windows 64 &amp; 32 bits</ulink>
+website for more details.
 <literal>${old_libs}</literal> are all
 your object files, bundled together in static libs or single object
 files and the <literal>${dependency_libs}</literal> are import libs you 

--------------2.30.0--


