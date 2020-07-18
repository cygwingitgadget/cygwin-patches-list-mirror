Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-042.btinternet.com (mailomta9-sa.btinternet.com
 [213.120.69.15])
 by sourceware.org (Postfix) with ESMTPS id 5E3A43860C2D
 for <cygwin-patches@cygwin.com>; Sat, 18 Jul 2020 15:00:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5E3A43860C2D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
 by sa-prd-fep-042.btinternet.com with ESMTP id
 <20200718150046.LZAF2233.sa-prd-fep-042.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
 Sat, 18 Jul 2020 16:00:46 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [31.51.206.146]
X-OWM-Source-IP: 31.51.206.146 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduiedrfeelgdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepueeijeeguddvuedtffeiieelfeffudefkeehgfejffefhedtkeejgeekfedtffefnecukfhppeefuddrhedurddvtdeirddugeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeefuddrhedurddvtdeirddugeeipdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (31.51.206.146) by
 sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AFBE076FE316; Sat, 18 Jul 2020 16:00:46 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/5] Improve dumper megion region selection
Date: Sat, 18 Jul 2020 16:00:23 +0100
Message-Id: <20200718150028.1709-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 18 Jul 2020 15:00:49 -0000

Improve how dumper determines if a memory region should be dumped:

Currently we open and read the PE file for each module, and exclude regions
corresponding to sections marked 'DEBUGGING' or 'CODE'.

This doesn't work correctly if the DLL has been loaded to an address other
than the ImageBase recorded in the PE header.  It fails to produce a useful
dump if there's a collision in excluded region addresses (which will always
occur on x86_64, as kernel32.dll has an ImageBase which collides with the
cygwin1.dll)

This probably also doesn't produce correct dumps if the protection on memory
regions corresponding to 'CODE' sections is manipulated using VirtualProtect().

Instead, dump memory region based on their type, protection and sharability:

- state is MEM_COMMIT (i.e. is not MEM_RESERVE or MEM_FREE), and
-- type is MEM_PRIVATE and protection allows reads (i.e. not a guardpage), or
-- type is MEM_IMAGE and attribute is non-sharable (i.e. it was WC, got 
   written to, and is now a RW copy)

Jon Turney (5):
  Cygwin: Show details of all memory regions details in dumper debug
    output
  Cygwin: Remove reading of PE for section flags from dumper
  Cygwin: Drop excluded regions list from dumper
  Cygwin: Don't dump non-writable image regions
  Cygwin: Use MEMORY_WORKING_SET_EX_INFORMATION in dumper

 winsup/doc/utils.xml     |   8 +-
 winsup/utils/Makefile.in |   8 +-
 winsup/utils/dumper.cc   | 214 +++++++++++++++++++++++++++------------
 winsup/utils/dumper.h    |  19 ----
 winsup/utils/parse_pe.cc | 107 --------------------
 5 files changed, 155 insertions(+), 201 deletions(-)
 delete mode 100644 winsup/utils/parse_pe.cc

-- 
2.27.0

