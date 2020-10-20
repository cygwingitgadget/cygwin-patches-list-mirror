Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-042.btinternet.com (mailomta31-sa.btinternet.com
 [213.120.69.37])
 by sourceware.org (Postfix) with ESMTPS id C5F743857C62
 for <cygwin-patches@cygwin.com>; Tue, 20 Oct 2020 13:43:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C5F743857C62
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
 by sa-prd-fep-042.btinternet.com with ESMTP id
 <20201020134325.SGU4736.sa-prd-fep-042.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
 Tue, 20 Oct 2020 14:43:25 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [86.139.158.27]
X-OWM-Source-IP: 86.139.158.27 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrjeefgdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepueeijeeguddvuedtffeiieelfeffudefkeehgfejffefhedtkeejgeekfedtffefnecukfhppeekiedrudefledrudehkedrvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudehkedrvdejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.27) by
 sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AFBE16F22A81; Tue, 20 Oct 2020 14:43:25 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/6] More Makefile/configure cleanups
Date: Tue, 20 Oct 2020 14:42:58 +0100
Message-Id: <20201020134304.11281-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3571.8 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Tue, 20 Oct 2020 13:43:29 -0000

For ease of reviewing, this patch series doesn't contain changes to
generated files which would be made by an autoreconf.

Jon Turney (6):
  Remove lsaauth
  Drop cygwin version.o from cygserver
  gendef generates sigfe.s and cygwin.def
  Remove nostdlib Makefile variable
  Drop do-nothing install_host target
  Drop do-nothing install_target target

 winsup/Makefile.common        |    2 -
 winsup/Makefile.in            |    2 -
 winsup/cygserver/Makefile.in  |    4 +-
 winsup/cygserver/configure.ac |    3 -
 winsup/cygwin/Makefile.in     |   19 +-
 winsup/cygwin/configure.ac    |    3 -
 winsup/lsaauth/Makefile.in    |   94 -
 winsup/lsaauth/configure      | 4130 ---------------------------------
 winsup/lsaauth/configure.ac   |   38 -
 winsup/lsaauth/cyglsa-config  |  121 -
 winsup/lsaauth/cyglsa.c       |  598 -----
 winsup/lsaauth/cyglsa.din     |    9 -
 winsup/lsaauth/cyglsa64.def   |    9 -
 winsup/testsuite/Makefile.in  |    4 +-
 14 files changed, 7 insertions(+), 5029 deletions(-)
 delete mode 100644 winsup/lsaauth/Makefile.in
 delete mode 100755 winsup/lsaauth/configure
 delete mode 100644 winsup/lsaauth/configure.ac
 delete mode 100755 winsup/lsaauth/cyglsa-config
 delete mode 100644 winsup/lsaauth/cyglsa.c
 delete mode 100644 winsup/lsaauth/cyglsa.din
 delete mode 100644 winsup/lsaauth/cyglsa64.def

-- 
2.28.0

