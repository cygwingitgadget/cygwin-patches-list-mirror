Return-Path: <SRS0=h6vi=7T=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo001.btinternet.com (btprdrgo001.btinternet.com [65.20.50.6])
	by sourceware.org (Postfix) with ESMTP id E59974BA2E1E
	for <cygwin-patches@cygwin.com>; Wed, 14 Jan 2026 14:28:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E59974BA2E1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E59974BA2E1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.6
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1768400916; cv=none;
	b=vI+xsj6tPqrkN++ljETj2xdq5Xmjk86+ZVRuaz9b+UgFATiyDF2RnLGv5F/tj2qI3mzg6E82xmvbm0NbBUiAhXnO//1UVPK/fDc4mQQAlCrWDZ5Ns3ppwkS+XAETI/X/IFXMFnRh+Fk9J3zK/F2Qw8HhQHY9i1nLLkxxtWlABCI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1768400916; c=relaxed/simple;
	bh=Hk+EsH2yxZtYVYZI0/uIr41mWUxvZc3200Hye1C8mTk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UxgttnhYcCq8yfVLEENcTn+qBkftXyIa2ePk5gZhfmIA53GcL9xEvIZt8LKOkusfbu04IjGPQZNxNKq7XRXCoujGuWQpShhsGf+LOZsogNNxruzmlB5qA0zA1Bkt+hOj6mL1ycSBW0nuImeJ1SO/AGHVNFs58qb05R86Kz4xzag=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E59974BA2E1E
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 693FF9DF02DFFE98
X-Originating-IP: [86.140.194.7]
X-OWM-Source-IP: 86.140.194.7
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTFGrCyBOFjmQzOM4q3/KkCT109pX6Sjipy3ziruh8pBnhGGjimoHg2uUfrMorNJOQAloh57JROnGjS8x4K3W7HfAWaBrNakiNEZS/rof8yR3KuMke9AwJW5b2h4D3p+kidKxJNVDPSqifbhpD8kkTIJWmfkoB9+RCuvk24UemM0bWdHUxs/6dmYkFk14p74n987gA+imBQgCOC1iEPu9K8sHBf8MjpnxNEdfFQg4M4G3ncpQT/i5IFMw5CLZLKcxAu3asF5tlKMn7m++Ir6g8t4IkmUIw9gNVM7ObCeXKYhMfrQ6PBAHvtu6pZhg4rK/WttZtJO0bQndSmj1Dg04USyG5/S+VaexsvLcf0iRZ0h1rn6VpHSNYLz9HjU9eAMVATgg0CPHrexkUy4Z5z7SLVLhBP8QdVVLi1wqa2X8L6M3PWdGCu/mg9qKXb+ZBIq24EKFh8q+dQAGV9i1TJGYzF8siv/1SteQX1xZUXuIRqY+ZFJfjIMfARTnxhMZO0IEo2dYHy3slQ/nH/1QhM3pqaljI/q14Nggkzk4DmM80HiiJdbuCGk1HMhLAqNeHmAZHFBRyBq0f3JpfYv/ARGkqMiUJyxhg7qBN+6B3Sqfh4LNsqzEag0GPjEwS6cBLe9zEsZqYM2rE5nS/WcVxJ5LQw1jQdPdeVXgVR30Aoo1uSmGQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from tambora (86.140.194.7) by btprdrgo001.btinternet.com (authenticated as jonturney@btinternet.com)
        id 693FF9DF02DFFE98; Wed, 14 Jan 2026 14:28:33 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: doc: Explciitly name the output when building .info files
Date: Wed, 14 Jan 2026 14:28:03 +0000
Message-ID: <20260114142803.3097-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This works arounda bug in docbook2x-texi seen with current bash in
Fedora 42 during cross-building.

If the -output-dir option to db2x_texixml isn't specified (always the
case when invoked by docbook2x-texi), then the script attempts cd ''
which is now an error ("cd: null directory") rather being treated as
equivalent to cd '.'

Instead, explicitly name the output file when building .info files.
---
 winsup/doc/Makefile.am | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/doc/Makefile.am b/winsup/doc/Makefile.am
index 394c43596..043bbcba4 100644
--- a/winsup/doc/Makefile.am
+++ b/winsup/doc/Makefile.am
@@ -24,7 +24,7 @@ XMLTO_HTML_CHUNK_QUIET=$(XMLTO_HTML_CHUNK_QUIET_$(V))
 XMLTO_MAN_QUIET_=--stringparam man.output.quietly=1
 XMLTO_MAN_QUIET=$(XMLTO_MAN_QUIET_$(V))
 
-DOCBOOK2XTEXI=@DOCBOOK2XTEXI@ --xinclude --info --utf8trans-map=charmap
+DOCBOOK2XTEXI=@DOCBOOK2XTEXI@ --xinclude --info --utf8trans-map=charmap --to-stdout
 
 -include Makefile.dep
 
@@ -142,7 +142,7 @@ utils2man.stamp: $(cygwin-ug-net_SOURCES) man.xsl
 	@touch $@
 
 cygwin-ug-net.info: $(cygwin-ug-net_SOURCES) charmap
-	$(AM_V_GEN)$(DOCBOOK2XTEXI) $(srcdir)/cygwin-ug-net.xml --string-param output-file=cygwin-ug-net
+	$(AM_V_GEN)$(DOCBOOK2XTEXI) $(srcdir)/cygwin-ug-net.xml --string-param output-file=cygwin-ug-net >$@
 
 cygwin-api/cygwin-api.html: $(cygwin-api_SOURCES) html.xsl
 	$(AM_V_GEN)$(XMLTO) html -o cygwin-api/ -m $(srcdir)/html.xsl $(XMLTO_HTML_CHUNK_QUIET) $<
@@ -155,7 +155,7 @@ api2man.stamp: $(cygwin-api_SOURCES) man.xsl
 	@touch $@
 
 cygwin-api.info: $(cygwin-api_SOURCES) charmap
-	$(AM_V_GEN)$(DOCBOOK2XTEXI) $(srcdir)/cygwin-api.xml --string-param output-file=cygwin-api
+	$(AM_V_GEN)$(DOCBOOK2XTEXI) $(srcdir)/cygwin-api.xml --string-param output-file=cygwin-api >$@
 
 # this generates a custom charmap for docbook2x-texi which has a mapping for &reg;
 charmap:
-- 
2.51.0

