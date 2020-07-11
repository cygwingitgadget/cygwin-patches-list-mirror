Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id 34EC33857C41
 for <cygwin-patches@cygwin.com>; Sat, 11 Jul 2020 04:14:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 34EC33857C41
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id u6uPjTshQYYpxu6uQjEza2; Fri, 10 Jul 2020 22:14:43 -0600
X-Authority-Analysis: v=2.3 cv=OubUNx3t c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=s65VDQUBSGUqEhDE5UoA:9
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygport install infinite loop when symlink in path
Date: Fri, 10 Jul 2020 22:14:10 -0600
Message-Id: <20200711041409.24929-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.27.0
Reply-To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfP/aMUTWpLtgzu+ZLOxhFv8T/IhcEFUC3pdXVd7RwcFawpM2niS6AkLLjWC10gfbiuTxqEJ5kVhwTok2Ajn6mcjq7efEOBeA2vPCbAMRJvH2muCVA0K/
 L7wW/n133hweOI5VWgr+zwBp+a5QXZ/C9pYA0XU7MxTotSk4VYG41AHGxiz6bQikruu/zIx2qWAPSW3zXP0BgYP42rjNfPdGAZDhYnxjwTtmDVD526rBcvi2
 uZ9KYHE/7Yd0M3kRu0vzUQ==
X-Spam-Status: No, score=-14.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_BL, RCVD_IN_MSPIKE_L3, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 11 Jul 2020 04:14:44 -0000

src_postinstall(_prep_libtool_modules): infinite loop when symlink in path
added readlink to also resolve symlinks in path to DEST host prefix
---
 lib/src_postinst.cygpart | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/src_postinst.cygpart b/lib/src_postinst.cygpart
index 68381a0..091994a 100644
--- a/lib/src_postinst.cygpart
+++ b/lib/src_postinst.cygpart
@@ -1293,8 +1293,10 @@ __prep_libtool_modules() {
 					mv ${ltlibdir}/${dlname} ${D}/usr/${CTARGET}/sys-root/$(__target_prefix)/bin/
 				else
 					origdlname=${dlname}
+					# do full symlink resolution on both paths compared to avoid issues
+					local dest_prefix=$(readlink -f ${D}$(__host_prefix))
 
-					while [ $(readlink -f ${ltlibdir}/${dlname%/bin/*}) != ${D}$(__host_prefix) ]
+					while [ $(readlink -f ${ltlibdir}/${dlname%/bin/*}) != $dest_prefix ]
 					do
 						dlname=../${dlname}
 					done
-- 
2.27.0

