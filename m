Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id 2EA393858C27
 for <cygwin-patches@cygwin.com>; Sun, 21 Mar 2021 08:44:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2EA393858C27
Received: from Express5800-S70 (y084061.dynamic.ppp.asahi-net.or.jp
 [118.243.84.61]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 12L8iFbu018874
 for <cygwin-patches@cygwin.com>; Sun, 21 Mar 2021 17:44:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 12L8iFbu018874
X-Nifty-SrcIP: [118.243.84.61]
Date: Sun, 21 Mar 2021 17:44:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
Message-Id: <20210321174427.cf79e39deeea896583caa48c@nifty.ne.jp>
In-Reply-To: <20210321040126.1720-1-takashi.yano@nifty.ne.jp>
References: <20210321040126.1720-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Sun, 21 Mar 2021 08:44:47 -0000

On Sun, 21 Mar 2021 13:01:24 +0900
Takashi Yano wrote:
> Takashi Yano (2):
>   Cygwin: syscalls.cc: Make _get_osfhandle() return appropriate handle.
>   Cygwin: pty: Add hook for GetStdHandle() to return appropriate handle.
> 
>  winsup/cygwin/fhandler_tty.cc | 19 +++++++++++++++++++
>  winsup/cygwin/syscalls.cc     | 13 ++++++++++++-
>  2 files changed, 31 insertions(+), 1 deletion(-)

I submitted these patches, however, I still wonder if we really
need these patches. I cannot imagine the situation where handle
itself is needed rather than file descriptor.

However, following cygwin apps/dlls call _get_osfhandle():
ccmake.exe
cmake.exe
cpack.exe
ctest.exe
ddrescue.exe

And also, following cygwin apps/dlls call GetStdHandle():
ccmake.exe
cmake.exe
cpack.exe
ctest.exe
run.exe
cygusb0.dll
tk86.dll

in my installation.

Therefore, some of these apps/dlls may need these patches...

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
