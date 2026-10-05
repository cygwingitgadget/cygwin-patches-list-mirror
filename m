Return-Path: <SRS0=aV9+=H3=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id 9D8114BA79A4
	for <cygwin-patches@cygwin.com>; Mon,  5 Oct 2026 19:44:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9D8114BA79A4
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9D8114BA79A4
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791229460; cv=none;
	b=VGjZdBiLmInFoay6onQweZ3TrH+lTV78NRC/hKjLj8qvm1K3j2glQNJpFEa+xqqTobf5Tfdi8FxqvghASIeDeb3qDm1t6cjm5cnjrnnHEoE7FxdN9EP3RtPacf4B00MQ4m3h7dLty0xYB7e+pwOGG1TLe4pmTQ5orLgQXx17uMc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791229460; c=relaxed/simple;
	bh=ulHUGwGfZgW3bsKvUcMpqMVcfzAeKzucNG4EEAl14O0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=OycShTgzRR0s3XajVDuHEYOnSP6pT45xQV0NcL+l5i1M2sbKMVDbq3oXokU5FuLr9WcJCJ7BwbZpznSrUUU4+NVtIRdI+rsM0JCviTgLGKQCGOwqebHp4WwN3iyhdItHep9Mn+cl+NLCR0Xg+y8vqWmE60zPnj4NS0NO3v3BpFg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=q9GhLxBW
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9D8114BA79A4
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=q9GhLxBW
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 4E7BAA72FD;
	Mon,  5 Oct 2026 19:44:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf12.hostedemail.com (Postfix) with ESMTPA id DB11517;
	Mon,  5 Oct 2026 19:44:16 +0000 (UTC)
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com (Cygwin Patches)
Subject: [PATCH] cygwin-htdocs/packaging-hint-files.html: update SPDX spec to 3.0.1
Date: Mon,  5 Oct 2026 13:42:42 -0600
Message-ID: <0de3fd2021ffe58cc5657c1ebb5aaa1decd89ae0.1791229333.git.Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Organization: Systematic Software
Content-Transfer-Encoding: 8bit
X-Stat-Signature: 5ad7sks9axxoatwgcb39wcjs1uhkpr9b
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: DB11517
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_SHORT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/XzIPDG9bAKOGY2pKtJ/vSvqmWeD90/zA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=from:to:subject:date:message-id:mime-version:content-transfer-encoding; s=he; bh=DFjKtQD9UMQS1s0O1ITIbmMFyH2jw4vBt71z1n+7jGg=; b=q9GhLxBW5xLiOcn8xp5XmgBiyltYiKg3+zk8eHgyZ4jnTV5e27WjX3ao26uVC3iYMa9Q2kSDQgBSyknLT9V9Fjjtalqn5wGCFINvqcJwcmyfvOjbh4h0lsf4CYNTupYifKmK3gYvduqOEMpUUPxVxgEiyRFkHu+wve3RiaRF0yYZCJq8MTqOe/joDl+bZ9zyzdHye/DzL7OxUeqTJj6CbLzQBnpVqoDfu/7KFHc0AT86G7OCFzBpnXwpVtHUAQZJ/Q9idjmFOybjj4k7n2HVmr5eAWyQ6ghdR+ICmxqHFtgsOdME3kPF5yxSOmaE4M4nTqF49q0LfYGw1oj4m938qA==
X-HE-Tag: 1791229456-704446
X-HE-Meta: U2FsdGVkX18Ul4cp0abyi8holua2N6gkuVW0oAPfQVmhl2tb849VC4tQVUCJaqb6mbw3s7/30lwL6u58hNPe7/vkJv+mmo6+wJjtyU3cD00JeyegIVftfVb+DfjrAlvgnINt/PW8j8uxJtOjNM7zpRH4K8FHwS1EukXB+7U13SbYlAOcWNkYvOvZQvh+ONkKK/hmkVbk/egiHKZDujpz3SMeIEDnSr6foOzki9VJLYy6A2jiz+XtmpavV2UEWmsGHo4RK0f9M4S85gIp92ZMDA2ZBKSkb9lxQraTUisD0xJA1r6XXI1gYU0OdzVYV7k70YvGcPoSMKJn/L1BsMIBvRito/4ipryEg1DbHYkI7GFJexgpqF+gRVc9yGc1vinw67T3ZUxczktnIr5C+kMw30Bt6EoLlucw/ULWN182Kxa0thZqKaN0oxHW1gUMOjt8r/mtVphGJeHLiOKmLUJqR/+gu8COtbA9B29bq6TKDydLPaz4ozZhAQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
---
 packaging-hint-files.html | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/packaging-hint-files.html b/packaging-hint-files.html
index 291f9ddc6244..c5108fbd5906 100755
--- a/packaging-hint-files.html
+++ b/packaging-hint-files.html
@@ -418,10 +418,11 @@ version: <i>version-identifier</i>
 
   <li>
     <p>
-      <code>license</code> is
-      an <a href="https://spdx.github.io/spdx-spec/v2.3/SPDX-license-expressions/">SPDX
-      license expression</a> for the <a href="https://spdx.org/licenses/">open
-      source license(s)</a> of the package source code.
+      <code>license</code> is an
+      <a href="https://spdx.github.io/spdx-spec/v3.0.1/annexes/spdx-license-expressions/">
+	  SPDX license expression</a> for the
+      <a href="https://spdx.org/licenses/">open source license(s)</a>
+      of the package source code.
     </p>
   </li>
 
-- 
2.51.0

