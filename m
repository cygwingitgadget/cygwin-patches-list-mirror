Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-043.btinternet.com (mailomta22-re.btinternet.com
 [213.120.69.115])
 by sourceware.org (Postfix) with ESMTPS id 0EE1F3861038
 for <cygwin-patches@cygwin.com>; Sat, 31 Oct 2020 15:08:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0EE1F3861038
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
 by re-prd-fep-043.btinternet.com with ESMTP id
 <20201031150835.KWSQ30383.re-prd-fep-043.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
 Sat, 31 Oct 2020 15:08:35 +0000
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 5ED9BDD0183B9210
X-Originating-IP: [86.140.194.67]
X-OWM-Source-IP: 86.140.194.67 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrleejgdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepueeijeeguddvuedtffeiieelfeffudefkeehgfejffefhedtkeejgeekfedtffefnecukfhppeekiedrudegtddrudelgedrieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegtddrudelgedrieejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.140.194.67) by
 re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9BDD0183B9210; Sat, 31 Oct 2020 15:08:35 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/7] Yet more Makefile/configure cleanups
Date: Sat, 31 Oct 2020 15:08:14 +0000
Message-Id: <20201031150821.18041-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3571.6 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KHOP_HELO_FCRDNS,
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
X-List-Received-Date: Sat, 31 Oct 2020 15:08:39 -0000

For ease of reviewing, this patch series doesn't contain changes to
generated files which would be made by an autoreconf.

Jon Turney (7):
  Remove intro2man.stamp on clean
  Drop AC_SUBST(build_exeext)
  Remove autoconf variable DLL_NAME
  Drop autoconf variable all_host
  Remove Makefile contents conditional on PREPROCESS, which is never
    defined
  Remove rules for building libcygwin_s.a
  Drop passing '-c' compiler flag into gentls_offsets

 winsup/cygserver/configure.ac | 11 ------
 winsup/cygwin/Makefile.in     | 36 +++-----------------
 winsup/cygwin/configure.ac    | 14 --------
 winsup/cygwin/mkstatic        | 63 -----------------------------------
 winsup/doc/Makefile.in        |  5 +--
 winsup/doc/configure.ac       |  2 --
 6 files changed, 8 insertions(+), 123 deletions(-)
 delete mode 100755 winsup/cygwin/mkstatic

-- 
2.29.0

