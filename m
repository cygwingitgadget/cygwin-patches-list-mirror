Return-Path: <SRS0=yFXp=UX=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by sourceware.org (Postfix) with ESMTPS id 2A9873858D21
	for <cygwin-patches@cygwin.com>; Fri, 31 Jan 2025 03:40:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2A9873858D21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2A9873858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.10
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1738294816; cv=none;
	b=XLAQdWqe3DgzDI2rFBP06/v8Vgn7IxnFFZm1LTCzsL3/xKRUhjaubOfllUXS67bBQR3JIWGJbnCgZnWQLRVRrPnLlnol7pfgLlTzoqioulgL1xQBBVG3LZtNG50UgInadloduGaTfCUbwC1SsDAcP5I8jOdB6gXz9QVSaRBHZMo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1738294816; c=relaxed/simple;
	bh=SXDFTWuJVWdVICkeJKhRbW4SDS7CcrEP6wDAGDW1eiI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=vUVAZcjT+A2a6JBz3EVyaC3/evPV+tZU4kZ0xkVpO0Ga91jOKcueAkOVAWOat5VtIZu+6RiZmccltSMKcDhoXA8jNA+e5hW0OuTIdqAesq2P6gMlO6cLMmKqEbzfKncVArvXez+Riqt/FnnM54kz4BFtVwG2HQ2isLywRO2M8Zk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2A9873858D21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=hTum8d2O
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id A7724AEF08;
	Fri, 31 Jan 2025 03:40:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf10.hostedemail.com (Postfix) with ESMTPA id 601AE32;
	Fri, 31 Jan 2025 03:40:14 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: Patches <cygwin-patches@cygwin.com>
Subject: [PATCH v2] update Cygwin-X news page X.Org and Cygwin release announcements to current stable releases
Date: Thu, 30 Jan 2025 20:39:21 -0700
Message-ID: <4c395f96efe5f7e7026c91125c832d431dcc145f.1738294648.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 601AE32
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout04
X-Stat-Signature: 8pq9ypxyqdqoh9gnp36qd4qd8r8xy7rd
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+S1NDSKXHWMk9XGoTUC1Xtv83H19OdLdc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=he; bh=5RIjHZI9j502L+v+StMJt/TM2bEenK1A1cxRZLKCubE=; b=hTum8d2OsMiVVh9Ykkek19cqPlO1/rSNeW1h/r/iFzAuBZVUqc8rLS7S4NRy8e/PKhRJoUDCA5xFWQf94lZaLK/QJJ1PCamS2hZLzdhyKPPDPL/N0E2D3yHfifzz+BR69qMwQv7htgjy2BPH9HLb6tv+BpJJUV4aVVVGtQn32jZwZlnMkSWZ2qJ1lFlOllEM0eD40xnj++OduR/vWXRTY1hUUCSJacWYwNcFVe3dj47T9AnHKhbm78KgCaVMa5e2BZ3JQpBYCLktPWGGFouzvk+js8MF1AgLlmCH5uy0VsX6iw3tiLufny47rvTJhZjwGpU+Y/HhilkFiGi/Zspjdg==
X-HE-Tag: 1738294814-954044
X-HE-Meta: U2FsdGVkX1/RADjgMB8UoupttRAke9zfvHlVzyas1ntcmv8qw6bTIe4B2hB4cMTA+m3qx+vUNVnh+zIvzh23WzyLiTAHmZpmNGXnqMrPdCGWhHDj3wLliGwAabCTF68BW2BpasZfndh/M0l92aznpWIckvPl7BGRy7qzt/1rQ3TAvv95d5x6PXvclQEJhHa3l87ALcyKcHaixR5Hd8z56iZFgTcUMFSXcn/Uc+qRWZjMLOyhLiy7BSmmD2uLWDDyOolOB8DcXW5+OpWGjF8RwzXxyi9r4S4gQL2fcWdec6zZQ3de6juoE8b6MFuHC+zv4YV72mNLVQJruKYWxBCCKhXdnyt6vJO5NR62KxT48WHINNlJNEnShi3v/dRcgAD1Gwx/zUvjt65xL4VFyut4oC3Cg0X52vx/6gxAA/Ez3XxD7zeM16+oehYH5DMIX5Ma9diZcMJxNyrie2oXVImnDbevERdY8j0+1BPVvCUAs9dRRw0eHdUIoc44Y0XDHd9FhODtPBo/sDoYXneUqiQKHTokWYXhaJuEc/4ugAq0z4/8ab7tlZYqKk+ZO1IuxRQ/G5qNKvdPNNkl6ILuR9DMHppsfQzx/7wi5nG+k8joCxAn6d/oIm1R6AMvqg8g0E/ZeifEvOYhHS8qXZkKZ9xGggNDTxa3udDT2lWD6lYCFhiz/lTgU9iJ6HTnkEBxDAAV9jNbRwc+3gU=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

might want to change the older messages to a more general Cygwin-X FAQ reference

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 xfree/cygx-news-new.html | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/xfree/cygx-news-new.html b/xfree/cygx-news-new.html
index e326fa084c2c..a9ff136ea684 100644
--- a/xfree/cygx-news-new.html
+++ b/xfree/cygx-news-new.html
@@ -1,14 +1,14 @@
 <p>
-<a href="https://lists.x.org/archives/xorg-announce/2021-October/003115.html">
-X server 21.1</a> and
-<a href="http://lists.x.org/archives/xorg-announce/2012-June/001977.html">
-X.Org X11 Release 7.7</a>
+<a href="https://lists.x.org/archives/xorg-announce/2024-December/003576.html">
+X.Org X Server 21.1.15</a> and
+<a href="https://lists.x.org/archives/xorg-announce/2024-July/003521.html">
+X.Org X11 Release 1.8.10</a>
 are included in Cygwin.
-Details are available in the announcements
-<a href="https://cygwin.com/pipermail/cygwin-announce/2021-November/010286.html">
-here</a> and
-<a href="http://cygwin.com/ml/cygwin-xfree-announce/2012-07/msg00001.html">
-here</a>.
+Details are available in the announcements of the respective Cygwin packages
+<a href="https://cygwin.com/pipermail/cygwin-announce/2025-January/012120.html">
+X.Org Server 21.1.15</a> and
+<a href="https://cygwin.com/pipermail/cygwin-announce/2025-January/012082.html">
+X.Org X11 refresh</a>.
 </p>
 
 <p>
-- 
2.45.1

