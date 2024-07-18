Return-Path: <SRS0=8yVf=OS=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id 106583860C39
	for <cygwin-patches@cygwin.com>; Thu, 18 Jul 2024 16:30:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 106583860C39
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 106583860C39
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1721320206; cv=none;
	b=maL9Ptdi3ou3hkVXVQCcZU/J/m1wqxVWNPajwdiREzA6GPKD7OIcTckzJm9I35FFeSlOTWHci4gNZtxaiqwzfIO0MYvZLTpFoJd3u3LuufYlMh4fBawwg9nII+6TtsO9exiI9MF4ToLDqWzof8Y1E32mTLeAaNmLfxQpC8RyU/I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1721320206; c=relaxed/simple;
	bh=Q33Mh94OBLEeOXn7+vJnn1bGIeIP6yomfARZVDgo0aM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tEWNXI54CVJahe0tOegPmkImj9szPi4RoqTC60wJXsf9QtZayB1C6NSA+OZLWcs48OhsedELofodY3iizHrUfCiwsUhIEdUaPDQQSHro6q50b7SMmKZTxzg+bJhmAdghEVOLEuYcnmgUZ8XTxcituxy0RktCdPKk5BLApxqKZPs=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 0DB691C41DD;
	Thu, 18 Jul 2024 16:29:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf16.hostedemail.com (Postfix) with ESMTPA id 968CC2000D;
	Thu, 18 Jul 2024 16:29:38 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/3] Cygwin: fhandler/proc.cc(format_proc_cpuinfo): Linux 6.10 flags added
Date: Thu, 18 Jul 2024 10:27:48 -0600
Message-ID: <5d91be2c32825ba2bd92655ad55b406859ce969b.1721213593.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1721213593.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1721213593.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 968CC2000D
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout07
X-Stat-Signature: oxqn7yjdzpctqy81g485a1xfnxp86umu
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/YxdC9i+fASHbUnyLQLL12+FMMV1/jRPs=
X-HE-Tag: 1721320178-79431
X-HE-Meta: U2FsdGVkX1+ZelBwZkuEsoPVaytXOIBpOiX8owNAYGI1gMxDu9asR/Xqch9xOCxLkbOdh7krgI3Awe+Z/1pK+zWRrnVmLlqcGPkAlg4Z7GkffHNmAUMgmDQKoNJCXMvneuzmD/M59JFTu7t0mCEUrydw48+9CVuGvxsRFofDAkIVDnb+avZBwvw9ybHJYYwbr+9ctJKzrPZCKDQTOlKHsGcEuFNVDOtaTmSiK/+JF7EiJqOOx5xLSsMRLkt4jSCL4IOcQmqtDkzgDzE/QUaaLWGpQ44xaDSNdlwlIa4dsEHM823ureUK+JjGvZ3qYXuiCW/7bOR0w58=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

0x8000000a EDX 18 x2avic	     virtual x2apic
0x80000022 EAX  2 amd_lbr_pmc_freeze AMD last br rec and perf mon ctrs freeze

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/cygwin/fhandler/proc.cc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
index baf0cae1e8f9..d8ab522a8235 100644
--- a/winsup/cygwin/fhandler/proc.cc
+++ b/winsup/cygwin/fhandler/proc.cc
@@ -1593,6 +1593,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1, 13, "avic");             /* virt int control */
 	  ftcprint (features1, 15, "v_vmsave_vmload");  /* virt vmsave vmload */
 	  ftcprint (features1, 16, "vgif");             /* virt glb int flag */
+	  ftcprint (features1, 18, "x2avic");           /* virt x2apic */
 	  ftcprint (features1, 20, "v_spec_ctrl");	/* virt spec ctrl support */
 	  ftcprint (features1, 25, "vnmi");             /* virt NMI */
 /*	  ftcprint (features1, 28, "svme_addr_chk");  *//* secure vmexit addr check */
@@ -1687,6 +1688,13 @@ format_proc_cpuinfo (void *, char *&destbuf)
 /*	  ftcprint (features2, 16, "vte");    *//* virtual transparent encryption */
 	}
 
+      /* cpuid 0x80000022 eax */
+      if (is_amd && maxe >= 0x80000022)
+	{
+	  cpuid (&features1, &unused, &unused, &unused, 0x80000022);
+	  ftcprint (features1,  2, "amd_lbr_pmc_freeze ");/* AMD LBR & PMC Freeze */
+	}
+
       print ("\n");
 
       bufptr += __small_sprintf (bufptr, "bogomips\t: %d.00\n",
-- 
2.45.1

