Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.12])
 by sourceware.org (Postfix) with ESMTPS id 0A0C23836C15
 for <cygwin-patches@cygwin.com>; Wed, 25 Nov 2020 06:49:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0A0C23836C15
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from BWINGLISD.cg.shawcable.net ([24.64.172.44])
 by shaw.ca with ESMTP
 id hocVkbxlCtdldhocXkEF1K; Tue, 24 Nov 2020 23:49:41 -0700
X-Authority-Analysis: v=2.4 cv=INe8tijG c=1 sm=1 tr=0 ts=5fbdfe85
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=r77TgQKjGQsHNAKrUKIA:9 a=4xSLHpMwukK1HERglk8A:9 a=QEXdDO2ut3YA:10
 a=OXe0Gg1GMEUA:10 a=zbzS7KU_AAAA:8 a=zfLpAKMzAAAA:8 a=TbbGrI9a3aIYNrneoigA:9
 a=B2y7HmGcmWMA:10 a=XoxtLrYzZpmZ5h8tRLTY:22 a=il4CN2_8hDwnfeKd1DiZ:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 2/2] winsup/doc/Makefile.in: create man5 dir and install
 proc.5
Date: Tue, 24 Nov 2020 23:49:31 -0700
Message-Id: <20201125064931.17081-3-Brian.Inglis@SystematicSW.ab.ca>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201125064931.17081-1-Brian.Inglis@SystematicSW.ab.ca>
References: <20201125064931.17081-1-Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------2.29.2"
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfD9S5uq4DjVFeTBIx4c5dWofnN2xc439GzfQOAbsM0Jec3q/v46GA0/35BaBOeGY09fmtsd0WxUpR/VHujiuqRH3YHOm9eYrXxWkPhH+u5w641GMzdcp
 Qla+Zjlq5jyML6KV6YsnTUEB36jrEaFp1A3FmizZ8USDUPnmmaHNQiqgIJKgNt+Mj50nEjJWgQSOcMduSqG7jMbFf+YEMPOWd03LWR7/A9pMATFN3QM1u519
 1XgdtTEL6XLJnSBhh4EEc22qbE4F8R8DHwQNoc7cmd8=
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KAM_NUMSUBJECT, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Wed, 25 Nov 2020 06:49:43 -0000

This is a multi-part message in MIME format.
--------------2.29.2
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit

---
 winsup/doc/Makefile.in | 4 ++++
 1 file changed, 4 insertions(+)


--------------2.29.2
Content-Type: text/x-patch; name="0002-winsup-doc-Makefile.in-create-man5-dir-and-install-g.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0002-winsup-doc-Makefile.in-create-man5-dir-and-install-g.patch"

diff --git a/winsup/doc/Makefile.in b/winsup/doc/Makefile.in
index cc4a1bec305b..f2a838a5dcf7 100644
--- a/winsup/doc/Makefile.in
+++ b/winsup/doc/Makefile.in
@@ -17,6 +17,7 @@ htmldir = @htmldir@
 mandir = @mandir@
 man1dir = $(mandir)/man1
 man3dir = $(mandir)/man3
+man5dir = $(mandir)/man5
 infodir:=@infodir@
 sysconfdir:=@sysconfdir@
 
@@ -61,6 +62,7 @@ clean:
 	rm -f api2man.stamp intro2man.stamp utils2man.stamp
 	rm -f *.1
 	rm -f *.3
+	rm -f *.5
 	rm -f *.info* charmap
 
 install: install-all
@@ -86,6 +88,8 @@ install-man: utils2man.stamp api2man.stamp intro2man.stamp
 	$(INSTALL_DATA) *.1 $(DESTDIR)$(man1dir)
 	@$(MKDIRP) $(DESTDIR)$(man3dir)
 	$(INSTALL_DATA) *.3 $(DESTDIR)$(man3dir)
+	@$(MKDIRP) $(DESTDIR)$(man5dir)
+	$(INSTALL_DATA) *.5 $(DESTDIR)$(man5dir)
 
 install-info: cygwin-ug-net.info cygwin-api.info
 	$(MKDIRP) $(DESTDIR)$(infodir)

--------------2.29.2--


