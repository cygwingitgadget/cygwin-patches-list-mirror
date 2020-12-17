Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.12])
 by sourceware.org (Postfix) with ESMTPS id 2D235386EC5B
 for <cygwin-patches@cygwin.com>; Thu, 17 Dec 2020 07:12:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2D235386EC5B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id pnSSkL1fU34axpnSTkZ06c; Thu, 17 Dec 2020 00:12:17 -0700
X-Authority-Analysis: v=2.4 cv=LvQsdlRc c=1 sm=1 tr=0 ts=5fdb04d1
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=1aU8EytXyWyOelARygEA:9 a=QEXdDO2ut3YA:10
 a=3SSaSaTa4kKZ3wpe8fAA:9 a=B2y7HmGcmWMA:10
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): report Intel SGX bits
Date: Thu, 17 Dec 2020 00:11:28 -0700
Message-Id: <20201217071127.60537-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.29.2
Reply-To: <cygwin-patches@cygwin.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.29.2"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGn81bUZdC+iKF/HD+75vCNRZeuTUy8qyls/HGFhDZ3Oa1wSE2WAKMS9mb6Kx43r8Z/gVnNYCZOzhBxZo35MUdFCMKtw6WWizNqQWxRsfTsyBpEYYNwo
 Qty59TYqDb4lPkZzzvk/Of/smlSDegdiWPW7z6nbXBrcJle5w79Bze3fU2ceERlZOezXYaruk+UODSQN2+2PeFFBmeb5vN1J4X6D5mz/4j8m1Y9J2yhq2TaY
 x64w2YKIaq3gHut2t/knSqZFUFRDw0RDQx8Vt9w8sDs=
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Thu, 17 Dec 2020 07:12:19 -0000

This is a multi-part message in MIME format.
--------------2.29.2
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit

Update to Linux next 5.10 cpuinfo flags for Intel SDM 36.7.1 Software
Guard Extensions, and 38.1.4 SGX Launch Control Configuration.
Launch control restricts what software can run with enclave protections,
which helps protect the system from bad enclaves.
---
 winsup/cygwin/fhandler_proc.cc | 2 ++
 1 file changed, 2 insertions(+)

--------------2.29.2
Content-Type: text/x-patch; name="0001-fhandler_proc.cc-format_proc_cpuinfo-add-Intel-SGX-h.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-fhandler_proc.cc-format_proc_cpuinfo-add-Intel-SGX-h.patch"

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 13397150ff53..8e23c0609485 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -1414,6 +1414,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
 	  ftcprint (features1,  0, "fsgsbase");	    /* rd/wr fs/gs base */
 	  ftcprint (features1,  1, "tsc_adjust");   /* TSC adjustment MSR 0x3B */
+	  ftcprint (features1,  2, "sgx");	    /* software guard extensions */
 	  ftcprint (features1,  3, "bmi1");         /* bit manip ext group 1 */
 	  ftcprint (features1,  4, "hle");          /* hardware lock elision */
 	  ftcprint (features1,  5, "avx2");         /* AVX ext instructions */
@@ -1564,6 +1565,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1, 27, "movdiri");          /* movdiri instr */
 	  ftcprint (features1, 28, "movdir64b");        /* movdir64b instr */
 	  ftcprint (features1, 29, "enqcmd");		/* enqcmd/s instructions*/
+	  ftcprint (features1, 30, "sgx_lc");		/* sgx launch control */
         }
 
       /* AMD MCA cpuid 0x80000007 ebx */

--------------2.29.2--

