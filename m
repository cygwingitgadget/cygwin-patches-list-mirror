Return-Path: <SRS0=8yVf=OS=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	by sourceware.org (Postfix) with ESMTPS id 4CC913860745
	for <cygwin-patches@cygwin.com>; Thu, 18 Jul 2024 16:30:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4CC913860745
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4CC913860745
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1721320212; cv=none;
	b=tq2c8PV7OVJxE+ouwXRDThUiekX95QKkJafSR8UvyGvsZQNOnsgmJIvxUgAzZataD0/sIAthOgPijmcHICOERFobSxioMmN1gLHdzuV0mR1osUxMxbfmtEOUA9dfu/TLy2Phx1pVuqIv1sAaAWwMzl3sFtGzTHTCMUZrwKaXDd4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1721320212; c=relaxed/simple;
	bh=Vr8NbnCxegqMRLjoQHHYQaHPZDLcacx9LaFPSRajx1Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=thKpeNB+/1B11bP82ueWtUYjewkNEfcOz6BLpE+C+ksrs6CpOal6CsTBCMzQRWzuLEepQO2kPUHg3yd70mYj525FEQAqmcvw+++4/5LoG7Nwk2pH930TLXF3bv19v9RojtMNHoxt/aALVtcCudf1KQp84VevdMgAI7yki2m55Kw=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 97A6F141B1A;
	Thu, 18 Jul 2024 16:29:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf16.hostedemail.com (Postfix) with ESMTPA id 32FCC2000D;
	Thu, 18 Jul 2024 16:29:40 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/3] Cygwin: fhandler/proc.cc(format_proc_cpuinfo): add newlines
Date: Thu, 18 Jul 2024 10:27:49 -0600
Message-ID: <26de498eb03171540f99a7f721129173c56a0659.1721213593.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1721213593.git.Brian.Inglis@SystematicSW.ab.ca>
References: <cover.1721213593.git.Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 32FCC2000D
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout07
X-Stat-Signature: gjto7fcg7j1149q811zoi7nax619ffkx
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/2Owa9j4pc/ZqWxp1vivb55YG7kn8P6dc=
X-HE-Tag: 1721320180-452603
X-HE-Meta: U2FsdGVkX1+tIO76tPS8OD6aEFsu7MCA8J9G/x4VVX551WgMkSG3azbv8ZhZaqTFuM/2PTQJfNez62sbQbKas/aq1xEYLRcvul1rPQHg4T8TUqsVA60lA0rVlrlzBzAXbiNRKW96oLyjWQ9ntZPE2IAmferdO7FfBbjev+Chn/ZpmyTTWc+OgzXYioo5osB2ENkcCSes+TrTH8fEgxqYi8uAeK+t+384HNUR8BX+2dzDnhvHrq5hvmgc9xDZbEChNQw5Q5KfbkhAgYphQOLp8bUbX1U7seGOQ3xDpC4HCo2zE3DxuMrVuB6xRDtf6M9U1PjDPcb8n6J4xVusr6+O1Elhot7wGGzxVG8stw+QPiZ7CVpewjgpyaIj/rIQgSen2iqwmkmf0EwX0o5+Ecq4+1NWLhMUEb1h
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Linux cpuinfo follows output for each processor with a blank line,
so we output newlines to get a blank line:
- newline after power management feature flags if printed;
- newline to give blank line after each processor output.

Reported-by: Achim Gratz https://cygwin.com/pipermail/cygwin/2024-July/256223.html
Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/cygwin/fhandler/proc.cc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
index d8ab522a8235..e85ed4ff06ed 100644
--- a/winsup/cygwin/fhandler/proc.cc
+++ b/winsup/cygwin/fhandler/proc.cc
@@ -1752,16 +1752,17 @@ format_proc_cpuinfo (void *, char *&destbuf)
 	  ftcprint (features1, 12, "acc_power");    /* core power reporting */
 /*	  ftcprint (features1, 13, "connstby"); */  /* connected standby */
 /*	  ftcprint (features1, 14, "rapl"); */	    /* running average power limit */
+
+	  print ("\n");
 	}
 
+      print ("\n");
+
       if (orig_affinity_mask != 0)
 	SetThreadGroupAffinity (GetCurrentThread (), &orig_group_affinity,
 				NULL);
-      print ("\n");
     }
 
-  print ("\n");
-
   destbuf = (char *) crealloc_abort (destbuf, bufptr - buf);
   memcpy (destbuf, buf, bufptr - buf);
   return bufptr - buf;
-- 
2.45.1

