Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.137])
 by sourceware.org (Postfix) with ESMTPS id F0F0F3850437
 for <cygwin-patches@cygwin.com>; Wed, 17 Feb 2021 16:28:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org F0F0F3850437
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net. ([24.64.172.44])
 by shaw.ca with ESMTP
 id CPgwlIV36HmS3CPgxlRZTs; Wed, 17 Feb 2021 09:28:43 -0700
X-Authority-Analysis: v=2.4 cv=MaypB7zf c=1 sm=1 tr=0 ts=602d443b
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=nz-5sxVJmLUA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=8L7xa9t9fFj9cOl_nrEA:9
 a=QEXdDO2ut3YA:10 a=Y-1JPCvTZhdlGxiK3gkA:9 a=XnpLslqENqAA:10
 a=B2y7HmGcmWMA:10 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 1/2] cpuinfo: fix check for cpuid 0x80000007 support
Date: Wed, 17 Feb 2021 09:28:35 -0700
Message-Id: <20210217162836.57947-2-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210217162836.57947-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20210217162836.57947-1-Brian.Inglis@SystematicSW.ab.ca>
Reply-To: patches
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.30.0"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDPEFV+r2F08XOu+6V/0BaXXsJT6A7GtFOAD3MTXYbwDIe1D8WfIqfogkNz82stbVPZxeKim7eN2auGmLNXcN0YvCwHZszfPPXlErLIYbv44KlkGbNXc
 BnumnOp5e3TnaHxZ4l+AvruSlSRhQcAmZy2oWm+WNirLqFXntjYU0wWmTw9uUTc2nifk99HSHcWzr+dSI5+bltnlZARTCTIshrTvK82dDvDtxvQQKiOuCCuu
 V3jkhHyKavxVIz6AopjdH6Cz1k99tN1iXyi/DrCghtw=
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 17 Feb 2021 16:28:45 -0000

This is a multi-part message in MIME format.
--------------2.30.0
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit

---
 winsup/cygwin/fhandler_proc.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


--------------2.30.0
Content-Type: text/x-patch; name="0001-cpuinfo-fix-check-for-cpuid-0x80000007-support.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-cpuinfo-fix-check-for-cpuid-0x80000007-support.patch"

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 8e23c0609485..d4c8613eb392 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -1293,7 +1293,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
 /* features scattered in various CPUID levels. */
       /* cpuid 0x80000007 edx */
-      if (maxf >= 0x00000007)
+      if (maxe >= 0x80000007)
 	{
 	  cpuid (&unused, &unused, &unused, &features1, 0x80000007);
 

--------------2.30.0--


