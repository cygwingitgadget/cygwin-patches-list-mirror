Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-045.btinternet.com (mailomta14-re.btinternet.com
 [213.120.69.107])
 by sourceware.org (Postfix) with ESMTPS id 2CA2F3857C40
 for <cygwin-patches@cygwin.com>; Mon, 12 Oct 2020 19:29:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2CA2F3857C40
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-045.btinternet.com with ESMTP id
 <20201012192957.CBFL4080.re-prd-fep-045.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Mon, 12 Oct 2020 20:29:57 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [86.141.130.13]
X-OWM-Source-IP: 86.141.130.13 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrheejgddufeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeuieejgeduvdeutdffieeileefffdufeekhefgjefffeehtdekjeegkeeftdfffeenucfkphepkeeirddugedurddufedtrddufeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugedurddufedtrddufedpmhgrihhlfhhrohhmpeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqpdhrtghpthhtohepoegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmqedprhgtphhtthhopeeojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.141.130.13) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC1588900D; Mon, 12 Oct 2020 20:29:57 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/8] Makefile/configure cleanups
Date: Mon, 12 Oct 2020 20:29:35 +0100
Message-Id: <20201012192943.15732-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 12 Oct 2020 19:30:20 -0000

Some Makefile.in and configure.ac cleanups and de-cruftification.  This is
preparatory to an Automakeification series still being worked on.

For ease of reviewing, this patch doesn't contain changes to generated files
which would be made by a autoreconf.

Jon Turney (8):
  Drop looking for w32api in winsup/w32api
  Drop STDINCFLAGS overrides
  Remove AC_PROG_MAKE_SET
  Remove AC_ARG_PROGRAM/program_transform_name
  Drop AC_SUBST(LIBSERVER)
  Remove autoconf variable INSTALL_LICENSE
  Remove empty MT_SAFE and MT_SAFE_OBJECTS
  Remove unused doc/ug-info.xml

 winsup/Makefile.in            |  4 +---
 winsup/acinclude.m4           |  2 --
 winsup/configure.ac           |  6 ------
 winsup/cygserver/configure.ac |  2 --
 winsup/cygwin/Makefile.in     |  9 ---------
 winsup/cygwin/configure.ac    | 18 ------------------
 winsup/doc/ug-info.xml        | 36 -----------------------------------
 winsup/lsaauth/configure.ac   |  2 --
 winsup/utils/Makefile.in      |  4 +---
 winsup/utils/configure.ac     |  2 --
 10 files changed, 2 insertions(+), 83 deletions(-)
 delete mode 100644 winsup/doc/ug-info.xml

-- 
2.28.0

