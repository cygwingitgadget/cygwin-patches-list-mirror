Return-Path: <SRS0=KYMU=II=nexgo.de=Stromeko@sourceware.org>
Received: from mr4.vodafonemail.de (mr4.vodafonemail.de [145.253.228.164])
	by sourceware.org (Postfix) with ESMTPS id BF9994BA2E11
	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 18:36:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BF9994BA2E11
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=nexgo.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nexgo.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BF9994BA2E11
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=145.253.228.164
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792348619; cv=none;
	b=wOU8rREHw9MQT/Vos8IfmYNAQM9ItK/D8mMow5IOTuIcHdxB3hGNNZUL1TAx88/E1f+CpR35vTlIn7JvhVpPGfJ9jo7djsXdiZWmXp5EjuOsVsDEBuh8OZC+91fpGhtdjVrRE36KYi9FEP1BOPJoIhsJ9dXsyGk2yt8Oh9OLY0g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792348619; c=relaxed/simple;
	bh=DvyuMyzPv1Yd6gnj8Y6W6Xr1vPNPoKZRDjXFL7F5C/E=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Av2gZHd2wBBhXTdCLjaVd2an8dVwCemjSI+HrSsR5XUAxFrchr6A2HuR8eezL1ENMMjvn2QJ+XRJXqXdWvsoUSMDJxs25MHQhld+PhhgL8cLxTDW4yrUJBra1Z47seiq7ZVYljubAbXPL3kki+6HolcEHgVj8I3upyx6OVs7gEw=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (1024-bit key, secure) header.d=nexgo.de header.i=@nexgo.de header.a=rsa-sha256 header.s=vfde-mb-mr2-23sep header.b=JgGMVxCT
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BF9994BA2E11
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, secure) header.d=nexgo.de header.i=@nexgo.de header.a=rsa-sha256 header.s=vfde-mb-mr2-23sep header.b=JgGMVxCT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
	s=vfde-mb-mr2-23sep; t=1792348613;
	bh=ABy4EAkEKzCaHEOEqxZGEkz9IH3Rp+jqI2dSBBWVsRc=;
	h=From:To:Subject:Date:Message-ID:User-Agent:Content-Type:From;
	b=JgGMVxCTcfjZiKpaWeKiDjCgypqcf0BaSQtPrC8gwQxsZWbYSM7jJHvFOCXOSzrRy
	 1vBd/YXcqdWjlIy33AjnmFbU10yqK0J2q4dt/xNF6moKJXuSxbbpdZQsdIt5WUSrJc
	 ggfcbyj+C/Sam5xETxiUNHqw3xDyBSyZvUNWKZ3I=
Received: from smtp.vodafone.de (unknown [10.5.0.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mr4.vodafonemail.de (Postfix) with ESMTPS id 4j76pY1Cclz3sHps
	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 18:36:53 +0000 (UTC)
Received: from Gerda (p54a0cc16.dip0.t-ipconnect.de [84.160.204.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.vodafone.de (Postfix) with ESMTPSA id 4j76pS52BDz8sY2
	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 18:36:45 +0000 (UTC)
From: ASSI <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH] tgid reported incorrectly in /proc/<pid>/status
Date: Sun, 18 Oct 2026 20:36:41 +0200
Message-ID: <87wlreyhxi.fsf@Gerda.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-purgate-server: smtpa06
X-purgate-type: clean
X-purgate: clean
X-purgate-size: 3306
X-purgate-ID: 155817::1792348608-527B09FD-E4D1331A/0/0
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_LOW,RCVD_IN_PBL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>


From b9f66fe5a55ac39f0bbbcfe9d96cade9927f672d Mon Sep 17 00:00:00 2001
From: Achim Gratz <Stromeko@Stromeko.DE>
Date: Sun, 18 Oct 2026 19:56:13 +0200
Subject: [PATCH] winsup/cygwin/fhandler/process.cc: correct tgid value

Cygwin has historically (and incorrectly) reported the pgid as the
tgid in /proc/<pid>/status even though LWP don't exist on Cygwin.
Since the Threads parameter was missing at the time, this latent bug
was lying dormant as that signifies an invalid tgid on Linux (the same
as for a Threads parameter of zero).  However, commit 9756b33 changed
that to reporting a number of threads in the Threads parameter that is
totally unrelated to LWP, which triggered the bug: procps now reports
the tgid instead of the pid as it does on Linux and expects that only
the leader process (tgid==pid) should get reported unless you ask for
all LWP to be shown.  This either suppresses the output for that
process completely or shows the wrong PID for many processes.  Regain
some sanity by ensuring tgid==pid for all Cygwin processes as LWP
don't exist.

This patch does not change the reporting of parameter Threads (which
should probably always be 0 on Cygwin to conform to the expectations
set by Linux), however it is currently unknown if that deviation is
actually causing problems in existing programs.  Any program using
this number should expect the number of threads to change between
reading this parameter and actually getting to the point where it
could enumerate them.  However, seeing a Thread value different from
zero might reasonably enable code paths that try to open directory
/proc/<pid>/task (which contains all threads in that thread group on
Linux).  Cygwin doesn't have this unless someone whips up an LWP
emulation for it, so for that reason it might be better to revert to
reporting zero.

Signed-off-by: Achim Gratz <Stromeko@Stromeko.DE>
Reported-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/cygwin/fhandler/process.cc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/process.cc b/winsup/cygwin/fhandler/process.cc
index 404668661..86ca05e5e 100644
--- a/winsup/cygwin/fhandler/process.cc
+++ b/winsup/cygwin/fhandler/process.cc
@@ -1335,7 +1335,9 @@ format_process_status (void *data, char *&destbuf)
 				   "SigIgn:\t%016lx\n",
 			  cmd,
 			  state, state_str,
-			  p->pgid,
+			  p->pid, /* this is the tgid on Linux, but
+				     Cygwin doesn't have LWP -- treat
+				     all processes as leaders */
 			  p->pid,
 			  p->ppid,
 			  p->uid, p->uid, p->uid, p->uid,
@@ -1343,7 +1345,11 @@ format_process_status (void *data, char *&destbuf)
 			  vmsize * kb_per_page, 0UL, vmrss * kb_per_page,
 			  vmdata * kb_per_page, 0UL, vmtext * kb_per_page,
 			  vmlib * kb_per_page,
-			  num_threads,
+			  num_threads, /* should really be the number
+					  of LWP in the same thread
+					  group, not the number of NT
+					  threads attached to this
+					  process */
 			  pnd, blk, ign
 			  );
 }
-- 
2.56.0


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Waldorf MIDI Implementation & additional documentation:
http://Synth.Stromeko.net/Downloads.html#WaldorfDocs
