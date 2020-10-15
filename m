Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-045.btinternet.com (mailomta6-re.btinternet.com
 [213.120.69.99])
 by sourceware.org (Postfix) with ESMTPS id 5B26A385782B
 for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2020 14:37:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5B26A385782B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-045.btinternet.com with ESMTP id
 <20201015143710.PETV4080.re-prd-fep-045.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Thu, 15 Oct 2020 15:37:10 +0100
Authentication-Results: btinternet.com;
 auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-Originating-IP: [86.143.43.37]
X-OWM-Source-IP: 86.143.43.37 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrieefgdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepueeijeeguddvuedtffeiieelfeffudefkeehgfejffefhedtkeejgeekfedtffefnecukfhppeekiedrudegfedrgeefrdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeefrdegfedrfeejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.143.43.37) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC15FB5A09; Thu, 15 Oct 2020 15:37:10 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/3] Remove ccwrap
Date: Thu, 15 Oct 2020 15:36:49 +0100
Message-Id: <20201015143652.56501-1-jon.turney@dronecode.org.uk>
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
X-List-Received-Date: Thu, 15 Oct 2020 14:37:15 -0000

What does ccwrap actually do?

ccwrap massages the compiler's standard include directories to remove
'/usr/include/w32api', with the intent of allowing it to be overriden by
'--with-windows-headers' (See 4c36016b)

I'm not 100% convinced that this is always working as desired, since in some
places w32api includes are done using <w32api/something.h>, which will find
them via the path /usr/include.

Removing ccwrap simplifies Automake-ification, and also permits 'CXX=ccache
c++', which doesn't work currently in some place.

If this does turn out to be needed, this could also be implemented by
constructing the appropriate compiler flags once, rather than on every compiler
invocation.

For ease of reviewing, this patch series doesn't contain changes to
generated files which would be made by an autoreconf.

Jon Turney (3):
  Stop using c++wrap for MinGW-compiled utilities
  Remove ccwrap
  Remove --with-windows-{libs,headers}

 winsup/Makefile.common        |  4 +--
 winsup/acinclude.m4           | 53 ++++-----------------------------
 winsup/c++wrap                |  6 ----
 winsup/ccwrap                 | 56 -----------------------------------
 winsup/configure.ac           |  5 ----
 winsup/configure.cygwin       | 10 -------
 winsup/cygserver/Makefile.in  |  9 +-----
 winsup/cygserver/configure.ac |  6 ----
 winsup/cygwin/Makefile.in     | 17 +++--------
 winsup/cygwin/configure.ac    |  5 ----
 winsup/cygwin/gentls_offsets  |  2 +-
 winsup/utils/Makefile.in      | 21 ++-----------
 winsup/utils/configure.ac     |  3 --
 13 files changed, 17 insertions(+), 180 deletions(-)
 delete mode 100755 winsup/c++wrap
 delete mode 100755 winsup/ccwrap

-- 
2.28.0

