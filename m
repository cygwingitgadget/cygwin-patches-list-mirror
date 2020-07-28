Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by sourceware.org (Postfix) with ESMTPS id D2B383857C49
 for <cygwin-patches@cygwin.com>; Tue, 28 Jul 2020 02:20:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D2B383857C49
Received: from Express5800-S70 (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 06S2KgJn003597
 for <cygwin-patches@cygwin.com>; Tue, 28 Jul 2020 11:20:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 06S2KgJn003597
X-Nifty-SrcIP: [124.155.38.192]
Date: Tue, 28 Jul 2020 11:20:56 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 5/5] Cygwin: Use MEMORY_WORKING_SET_EX_INFORMATION in
 dumper
Message-Id: <20200728112056.86427f1c9e2a3e044dfa169e@nifty.ne.jp>
In-Reply-To: <20200718150028.1709-6-jon.turney@dronecode.org.uk>
References: <20200718150028.1709-1-jon.turney@dronecode.org.uk>
 <20200718150028.1709-6-jon.turney@dronecode.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 28 Jul 2020 02:21:02 -0000

Hi Jon,

On Sat, 18 Jul 2020 16:00:28 +0100
Jon Turney wrote:
> Use the (undocumented) MEMORY_WORKING_SET_EX_INFORMATION in dumper to
> determine if a MEM_IMAGE region is unsharable, and hence has been
> modified.
> ---
>  winsup/doc/utils.xml     |  8 ++---
>  winsup/utils/Makefile.in |  2 +-
>  winsup/utils/dumper.cc   | 63 ++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 65 insertions(+), 8 deletions(-)

After this commit, 32bit build failes with:

/usr/lib/gcc/i686-pc-cygwin/9.3.0/../../../../i686-pc-cygwin/bin/ld: dumper.o:/home/yano/newlib-cygwin/i686-pc-cygwin/winsup/utils/../../.././winsup/utils/dumper.cc:295: undefined reference to `NtQueryVirtualMemory'

This seems to be solved with the patch:

diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
index 3af138b9e..36dbf9dbb 100644
--- a/winsup/utils/dumper.cc
+++ b/winsup/utils/dumper.cc
@@ -272,7 +272,7 @@ typedef enum _MEMORY_INFORMATION_CLASS
 } MEMORY_INFORMATION_CLASS;

 extern "C"
-NTSTATUS
+NTSTATUS NTAPI
 NtQueryVirtualMemory(HANDLE ProcessHandle,
                     LPVOID BaseAddress,
                     MEMORY_INFORMATION_CLASS MemoryInformationClass,

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
