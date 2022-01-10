Return-Path: <yselkowi@redhat.com>
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by sourceware.org (Postfix) with ESMTPS id 03BC63857C4B
 for <cygwin-patches@cygwin.com>; Mon, 10 Jan 2022 03:35:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 03BC63857C4B
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641785704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n09WJ2HevYPndf3kOJK6piy7VfJNdrWgsNdtIzf41Ps=;
 b=VCGEuHM5AUx7bPOHIlXaT6gD7rzXyLj33DIBJzRxAvkdNBgZv5dIUk91nrTc0aMYp6y3I3
 qGo8KVTlWWxRRwtVmkfRhAbgu7jr9N6Sf3THn6m7Rho3MGqfIlQCSIio+O+5eSx8PsaoAL
 vIBm/pBpQTGMtE1JE5K5QjpKoPaHt2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-gGc0X5xSPXqTO0n6i2zhlQ-1; Sun, 09 Jan 2022 22:35:03 -0500
X-MC-Unique: gGc0X5xSPXqTO0n6i2zhlQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B1CA835BC3
 for <cygwin-patches@cygwin.com>; Mon, 10 Jan 2022 03:35:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.22.8.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B11DE519D0
 for <cygwin-patches@cygwin.com>; Mon, 10 Jan 2022 03:35:01 +0000 (UTC)
From: Yaakov Selkowitz <yselkowi@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: do not build MinGW testsuite/cygrun
 --with-cross-bootstrap
Date: Sun,  9 Jan 2022 22:34:49 -0500
Message-Id: <20220110033449.216876-1-yselkowi@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yselkowi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00, DKIMWL_WL_HIGH,
 DKIM_SIGNED, DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Mon, 10 Jan 2022 03:35:06 -0000

---
 winsup/testsuite/Makefile.am | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 4b8c7dbb7..ac68934d0 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -61,4 +61,6 @@ EXTRA_DEJAGNU_SITE_CONFIG = site-extra.exp
 clean-local:
 	rm -f *.log *.exe *.exp *.bak *.stackdump winsup.sum
 
+if CROSS_BOOTSTRAP
 SUBDIRS = cygrun
+endif
-- 
2.34.1

