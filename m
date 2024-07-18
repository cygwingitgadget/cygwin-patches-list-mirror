Return-Path: <SRS0=8yVf=OS=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	by sourceware.org (Postfix) with ESMTPS id CBB523858C53
	for <cygwin-patches@cygwin.com>; Thu, 18 Jul 2024 16:29:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CBB523858C53
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CBB523858C53
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1721320186; cv=none;
	b=FkhxYJrpxVWaEqITIjbiMTZ2IsMakqjzJcx56Asuxvk+5D4nJPYgOsFghSlm22Se76Kq4TL9C8fRZeXQ6g5hSMACo2NVmsIfXfErNmowzesiehNSqHirylZgzu63b3H6JMY8mvFAtDY/jjogzKu/kEp5tOdv/KjjySs/iz8UCQE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1721320186; c=relaxed/simple;
	bh=XHJaLb9ClBeGf+JYkmLFarSevzqNKUpL05pgeuEJzWM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UOyyiiOvanFdRbBb9E0TPv3MkCleLBi/fcbGRtxAzDGgkI9KYRGyZt1xvN0w4HMbCHJbrU/EvA5OFivzV3SyejzrpnX2doVU3sl2qrDmNSGLvZ9SrK1+gq0/IxcWcx2Lpi4UY7jFlUD36l9otcLkW0iEiluSO8RE3P6Gjf6nVLM=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 47536C0E69;
	Thu, 18 Jul 2024 16:29:43 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf16.hostedemail.com (Postfix) with ESMTPA id B663C2000D;
	Thu, 18 Jul 2024 16:29:41 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/3] Cygwin: fhandler/proc.cc(format_proc_cpuinfo): Linux 6.10 flags resync
Date: Thu, 18 Jul 2024 10:27:50 -0600
Message-ID: <c38594a898a54618fed29535832e60aa54265147.1721213593.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1721213593.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1721213593.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B663C2000D
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout07
X-Stat-Signature: uhwkfu3kmhq746n15t3c6ufr6dmy65mo
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19fEXf6xQ0jb1myDyA1Us63H88om1hs8TA=
X-HE-Tag: 1721320181-132390
X-HE-Meta: U2FsdGVkX18OMdlCF3ZsoLZg2dsEL7KGpvGQTFC2cS4mkBT2K4E8yHYOZtQABR6a8yMr9WrLeu90cg0MRpaCJJ7I5faTiaLsVcsMB04ohtwfFAJ/SCt6+Gm+V8YxjH+niuCtEYN0p/8LM6kwZqvnivmh/DantTm+Gxqme8n8mnFouZwUZI9A7dGx2poeOAkYrarv+BcYvfPTiYmvdPX2E2Dkvzmxlo5JPoBnUZjPBZi7AS1zqhpP1pDZMONzf5hQH+MHw2vF47ZyXd6gvePTETe/AppOgdn7KwzX0bXSX+iXWuJknt0nGsNYMZselU05CH62OP0UMv0=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Linux 6.10 changed the content of cpufeatures.h to require explicit
quoted flag names for output in comments, instead of requiring a null
quoted string "" at the start of comments to suppress flag name output.
As a result, some flags (not all for output) were renamed and others moved:

- change dts to ds; move intel_ppin down; swap ibpd and ibrs;
- change some flag names and descriptions that are not output.

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/cygwin/fhandler/proc.cc | 35 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
index e85ed4ff06ed..8c7a4ab06a51 100644
--- a/winsup/cygwin/fhandler/proc.cc
+++ b/winsup/cygwin/fhandler/proc.cc
@@ -1021,14 +1021,14 @@ format_proc_cpuinfo (void *, char *&destbuf)
       ftcprint (features1,  9, "apic"); /* APIC enabled */
       ftcprint (features1, 11, "sep");  /* sysenter/sysexit */
       ftcprint (features1, 12, "mtrr"); /* memory type range registers */
-      ftcprint (features1, 13, "pge");  /* page global extension */
+      ftcprint (features1, 13, "pge");  /* page global enable */
       ftcprint (features1, 14, "mca");  /* machine check architecture */
       ftcprint (features1, 15, "cmov"); /* conditional move */
       ftcprint (features1, 16, "pat");  /* page attribute table */
       ftcprint (features1, 17, "pse36");/* 36 bit page size extensions */
       ftcprint (features1, 18, "pn");   /* processor serial number */
       ftcprint (features1, 19, "clflush"); /* clflush instruction */
-      ftcprint (features1, 21, "dts");  /* debug store */
+      ftcprint (features1, 21, "ds");	/* debug store */
       ftcprint (features1, 22, "acpi"); /* ACPI via MSR */
       ftcprint (features1, 23, "mmx");  /* multimedia extensions */
       ftcprint (features1, 24, "fxsr"); /* fxsave/fxrstor */
@@ -1326,13 +1326,6 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
 	  ftcprint (features1,  3, "epb");	/* energy perf bias */
 	}
-      /* cpuid 0x00000007:1 ebx */
-      if (maxf >= 0x00000007)
-	{
-	  cpuid (&unused, &features1, &unused, &unused, 0x00000007, 1);
-
-	  ftcprint (features1,  0, "intel_ppin"); /* Prot Proc Id No */
-	}
       /* cpuid 0x00000010 ebx */
       if (maxf >= 0x00000010)
 	{
@@ -1360,6 +1353,13 @@ format_proc_cpuinfo (void *, char *&destbuf)
 
 /*	  ftcprint (features1, 11, "pti");*//* Page Table Isolation reqd with Meltdown */
 
+      /* cpuid 0x00000007:1 ebx */
+      if (maxf >= 0x00000007)
+	{
+	  cpuid (&unused, &features1, &unused, &unused, 0x00000007, 1);
+
+	  ftcprint (features1,  0, "intel_ppin"); /* Prot Proc Id No */
+	}
       /* cpuid 0x00000010:2 ecx */
       if (maxf >= 0x00000010)
 	{
@@ -1406,8 +1406,8 @@ format_proc_cpuinfo (void *, char *&destbuf)
 /*	  ftcprint (features1,  4, "rdpru");	*//* user level rd proc reg */
 /*	  ftcprint (features1,  6, "mba");	*//* memory BW alloc */
 /*	  ftcprint (features1,  9, "wbnoinvd"); *//* wbnoinvd instruction */
-	  ftcprint (features1, 12, "ibpb");	/* ind br pred barrier */
 	  ftcprint (features1, 14, "ibrs");	/* ind br restricted spec */
+	  ftcprint (features1, 12, "ibpb");	/* ind br pred barrier */
 	  ftcprint (features1, 15, "stibp");	/* 1 thread ind br pred */
 	  ftcprint (features1, 16, "ibrs_enhanced"); /* ibrs_enhanced IBRS always on */
 /*	  ftcprint (features1, 17, "stibp_always_on"); */ /* stibp always on */
@@ -1442,14 +1442,14 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1,  3, "bmi1");         /* bit manip ext group 1 */
 	  ftcprint (features1,  4, "hle");          /* hardware lock elision */
 	  ftcprint (features1,  5, "avx2");         /* AVX ext instructions */
-/*	  ftcprint (features1,  6, "fpdx"); */	    /* "" FP data ptr upd on exc */
+/*	  ftcprint (features1,  6, "fdp_excptn_only"); *//* FP data ptr upd on exc */
 	  ftcprint (features1,  7, "smep");         /* super mode exec prot */
 	  ftcprint (features1,  8, "bmi2");         /* bit manip ext group 2 */
 	  ftcprint (features1,  9, "erms");         /* enh rep movsb/stosb */
 	  ftcprint (features1, 10, "invpcid");      /* inv proc context id */
 	  ftcprint (features1, 11, "rtm");          /* restricted txnal mem */
 	  ftcprint (features1, 12, "cqm");          /* cache QoS monitoring */
-/*	  ftcprint (features1, 13, "fpcsdsz"); */   /* "" zero FP cs/ds */
+/*	  ftcprint (features1, 13, "zero_fcs_fds");*//* zero FP CS/DS */
 	  ftcprint (features1, 14, "mpx");          /* mem prot ext */
 	  ftcprint (features1, 15, "rdt_a");        /* rsrc dir tech alloc */
 	  ftcprint (features1, 16, "avx512f");      /* vec foundation */
@@ -1541,11 +1541,11 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1,  4, "rdpru");	    /* user level rd proc reg */
 /*	  ftcprint (features1,  6, "mba"); */	    /* memory BW alloc */
 	  ftcprint (features1,  9, "wbnoinvd");     /* wbnoinvd instruction */
-/*	  ftcprint (features1, 12, "ibpb" ); */	    /* ind br pred barrier */
-/*	  ftcprint (features1, 14, "ibrs" ); */	    /* ind br restricted spec */
-/*	  ftcprint (features1, 15, "stibp"); */	    /* 1 thread ind br pred */
-/*	  ftcprint (features1, 16, "ibrs_enhanced"); */  /* ibrs_enhanced IBRS always on */
-/*	  ftcprint (features1, 17, "stibp_always_on"); */ /* stibp always on */
+/*	  ftcprint (features1, 12, "amd_ibpb" ); */ /* ind br pred barrier */
+/*	  ftcprint (features1, 14, "amd_ibrs" ); */ /* ind br restricted spec */
+/*	  ftcprint (features1, 15, "amd_stibp"); */ /* 1 thread ind br pred */
+/*	  ftcprint (features1, 16, "ibrs_enhanced");*//* ibrs_enhanced IBRS always on */
+/*	  ftcprint (features1, 17, "amd_stibp_always_on");*//* stibp always on */
 /*	  ftcprint (features1, 18, "ibrs_pref"); */ /* ibrs_pref IBRS preferred */
 	  ftcprint (features1, 23, "amd_ppin");     /* protected proc id no */
 /*	  ftcprint (features1, 24, "ssbd"); */	    /* spec store byp dis */
@@ -1572,6 +1572,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1,  9, "hwp_act_window"); /* HWP activity window */
 	  ftcprint (features1, 10, "hwp_epp");  /* HWP energy perf pref */
 	  ftcprint (features1, 11, "hwp_pkg_req"); /* HWP package level req */
+/*	  ftcprint (features1, 15, "hwp_highest_perf_change");*//* HWP highest perf change */
 	  ftcprint (features1, 19, "hfi");	/* Hardware Feedback Interface */
 	}
 
-- 
2.45.1

