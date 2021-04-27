Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.137])
 by sourceware.org (Postfix) with ESMTPS id 6E6E33896C26
 for <cygwin-patches@cygwin.com>; Tue, 27 Apr 2021 23:29:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6E6E33896C26
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net. ([68.147.0.90])
 by shaw.ca with ESMTP
 id bX8Yl9p7luKh3bX8Zl0RtP; Tue, 27 Apr 2021 17:29:04 -0600
X-Authority-Analysis: v=2.4 cv=EaOr/NqC c=1 sm=1 tr=0 ts=60889e40
 a=T+ovY1NZ+FAi/xYICV7Bgg==:117 a=T+ovY1NZ+FAi/xYICV7Bgg==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=OqNVvETPx4XCAOYqvYUA:9 a=QEXdDO2ut3YA:10
 a=F5wKHVgBXtolARwweDQA:9 a=B2y7HmGcmWMA:10
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH] format_proc_cpuinfo: add v_spec_ctrl, bus_lock_detect
Date: Tue, 27 Apr 2021 17:28:52 -0600
Message-Id: <20210427232852.51759-1-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.31.1"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFNOYOFaP7cFnnKf/wYMis8z5xRx69LCVZvTPMs5m3BJ5kwAe0g9U8rhkTh00nJPS7xEi6XwGfrWotgpJKL5ngYB4iaFOfI5QBrI4PKziEJhai9PzCcF
 /P/cg6DmkMGl8ooHC36ODm889ajeEhD2tjS6maZGJz6vMO0k0NsXwUfTcnVWSh1NTxa92r07TWSh7EkNr224iLvQSBtg+E3U/HIXrcwnag0RyZ3vHK15SKqt
 ZqjSlRdy2bHSY1HCqnoXHAU4za8p9OF3DVxu6/t0T7k=
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_LOW, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Tue, 27 Apr 2021 23:29:07 -0000

This is a multi-part message in MIME format.
--------------2.31.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Linux 5.12 Frozen Wasteland added features and changes:
add AMD 0x8000000a EDX:20 v_spec_ctrl virtual speculation control support
add Intel 0x00000007 ECX:24 bus_lock_detect bus lock detect debug exception
---
 winsup/cygwin/fhandler_proc.cc | 2 ++
 1 file changed, 2 insertions(+)


--------------2.31.1
Content-Type: text/x-patch; name="0001-format_proc_cpuinfo-add-v_spec_ctrl-bus_lock_detect.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-format_proc_cpuinfo-add-v_spec_ctrl-bus_lo.patch"

diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
index 501c157daae5..7cd0b3af02a2 100644
--- a/winsup/cygwin/fhandler_proc.cc
+++ b/winsup/cygwin/fhandler_proc.cc
@@ -1519,6 +1519,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1, 13, "avic");             /* virt int control */
 	  ftcprint (features1, 15, "v_vmsave_vmload");  /* virt vmsave vmload */
 	  ftcprint (features1, 16, "vgif");             /* virt glb int flag */
+	  ftcprint (features1, 20, "v_spec_ctrl");	/* virt spec ctrl support */
 /*	  ftcprint (features1, 28, "svme_addr_chk");  *//* secure vmexit addr check */
         }
 
@@ -1542,6 +1543,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1, 14, "avx512_vpopcntdq"); /* vec popcnt dw/qw */
 	  ftcprint (features1, 16, "la57");             /* 5 level paging */
 	  ftcprint (features1, 22, "rdpid");            /* rdpid instruction */
+	  ftcprint (features1, 24, "bus_lock_detect");	/* bus lock detect dbg excptn */
 	  ftcprint (features1, 25, "cldemote");         /* cldemote instr */
 	  ftcprint (features1, 27, "movdiri");          /* movdiri instr */
 	  ftcprint (features1, 28, "movdir64b");        /* movdir64b instr */

--------------2.31.1--


