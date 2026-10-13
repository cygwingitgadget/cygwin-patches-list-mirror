Return-Path: <SRS0=Qr2z=ID=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id B94144BA23CD
	for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2026 17:50:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B94144BA23CD
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B94144BA23CD
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791913819; cv=none;
	b=Si21HFyy2wtMEiilnPK2Vjh5iqtUy2eVcC0SPhGcVNHc2ctS593tpRWpbjFcPE2Y3y5V4BqFVtwL8s7RNKnLNjHAtc3Mlh9yp/lLYyamtDUMDKo+ZYw2ZHeSMiZGPF7d17OkJmMS4TWmwm5JEIJMko2T1qzaP+J5XDPQf+6etKs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791913819; c=relaxed/simple;
	bh=8awjQP81n++OSNUP86zLlPUOUkrC9CDmbKBsSTu3h+A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=dS2WG4NzFDMc/XdRs9H1wq8S1wg8oldw+lMvOA6qufmZhHtJjD/V1myNerpUi1AFo0YvdOciltMMn6LbJ6qvMoZ8N96GTJoUCO8Ar+jWd0tSsU/BZJ5Yc5MOZm/P/vBfljVDZSLhZYXi7EG+v3beE8J+vB1IY8Hk6sqlac+6oqk=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=WFfamWmb
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B94144BA23CD
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=WFfamWmb
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 24C391C0D0D;
	Tue, 13 Oct 2026 17:50:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf13.hostedemail.com (Postfix) with ESMTPA id 9774F20011;
	Tue, 13 Oct 2026 17:50:16 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH] Cygwin: API winsup/doc/posix.xml: update ISO to final 9945:2026 Edition 2 2026-03-18
Date: Tue, 13 Oct 2026 11:49:51 -0600
Message-ID: <00d6c451303b15168f7ec6801c5435f8708cdd34.1791913465.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Organization: Systematic Software
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 9774F20011
X-Stat-Signature: mx9hm653ai8p58d1znzjanyg89ktkqkd
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18VwuJveTnH+ffVH0xUKswc/uhjIZLH4FU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:mime-version:content-type:content-transfer-encoding; s=he; bh=FwFKRNsLJ0w/YV5+6UQT88JV4LXvAYQZB5QnJtsgXCo=; b=WFfamWmbHL/1IOgpe08nRDVkWaMFAcvYsDFeDh6hnCtt7Tc85/frP9FnRqjjIONxTnBG5+twBdVq2SfurLRcYXR6YQsqb5TVGO6C5LxgLtC2iY0BIY/xie1s4pFtlgNmZvRMotJSlmT5KbVJZ1BHZnj900vTQn08PGrIYYVLo4CSa6IqSTig+S380wabKp1kZM4u1Jy3EvO0fnvc4O1yh06NswHFD7NCdejWAx0ZAhy977QZ6pzP4Kdg2GEj7ihJWbD4FSd3gJmJkGXAe24xqppux4LYrt9Zv9yIf6On3DzlhjXlp/heSdBi0szmkCK1XYLtCtOlx1PCe60lZ4Hd/A==
X-HE-Tag: 1791913816-595353
X-HE-Meta: U2FsdGVkX18HHEzOgwb+Izwzs4n+AJmaVLp7sUOxtSMtkSXqrPNuk0N87O2C04KXL01GGDULoGY0cW13g4AGaSzO2lxC+rkgs6DoVDn/nBwt+EztoxfVTzqBTqkX0Hiu3JlKl23Xl/2KRoGc9Kc2LJvscz9TD84fsA4U+NVr7bXBXm6nkCIdjRLL4XWs6anUWboIPKgXOhjFlI7UA+jn+TgPwn6GdAkBt4ht7d4yJuHLLuuM7TJVPm0hOMSILmjkeLjUOujUwHtvK4IrsQyt2MGsJ1xsNkRQ9Vdwh20bs2NIBMad5KDXLmy6whQUt4U/6FJ96tGmEDDGLmvQ2nb+NSHKPD5+OSucWJol6DagikRenlC3XZ3jrjs9g9F4c77Lb/1vxmEBroI00OC6/vWR8SK4Gn8rv6h2F6RwDF7WHn2FKrcfYlqc9ZEk/PwADYVWlwutKujUtsK8kDAwUZjeXg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 winsup/doc/posix.xml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index cec7ee38a533..f789e6baffaf 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -11,9 +11,9 @@
 POSIX®.1-2024 also simultaneously IEEE Std 1003.1™-2024 Edition,
 The ®Open Group Base Specifications Issue 8
 (see https://pubs.opengroup.org/onlinepubs/9799919799/), and
-ISO®/IEC DIS 9945 Information technology
-- Portable Operating System Interface (POSIX®) base specifications
-- Issue 8.</para>
+ISO/IEC/IEEE 9945:2026 Information technology
+- Portable Operating System Interface (POSIX™) Base Specifications,
+Issue 8 (Edition 2, 2026) published 2026-03-18.</para>
 
 <screen>
     CMPLX
-- 
2.51.0

