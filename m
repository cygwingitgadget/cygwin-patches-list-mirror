Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by sourceware.org (Postfix) with ESMTPS id DEA93386F02B
 for <cygwin-patches@cygwin.com>; Mon, 18 May 2020 05:25:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DEA93386F02B
Received: from Express5800-S70 (v040007.dynamic.ppp.asahi-net.or.jp
 [124.155.40.7]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 04I5PESb029057
 for <cygwin-patches@cygwin.com>; Mon, 18 May 2020 14:25:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 04I5PESb029057
X-Nifty-SrcIP: [124.155.40.7]
Date: Mon, 18 May 2020 14:25:19 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 00/21] FIFO: Support multiple readers
Message-Id: <20200518142519.cb6d805fa92afe4dcb017b02@nifty.ne.jp>
In-Reply-To: <20200507202124.1463-1-kbrown@cornell.edu>
References: <20200507202124.1463-1-kbrown@cornell.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 18 May 2020 05:25:48 -0000

On Thu,  7 May 2020 16:21:03 -0400
Ken Brown via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> This project began as a an attempt to allow a FIFO to be opened
> multiple times for reading.  The initial motivation was that Midnight
> Commander running under tcsh does this (unsuccessfully on Cygwin).
> See
> 
>    https://sourceware.org/pipermail/cygwin/2019-December/243317.html
> 
> It quickly became apparent, however, that the current code doesn't
> even properly handle the case where the FIFO is *explicitly* opened
> only once for reading, but additional readers are created via
> dup/fork/exec.
> 
> This explained some of the bugs reported by Kristian Ivarsson.  See,
> for example, the thread starting here:
> 
>   https://sourceware.org/pipermail/cygwin/2020-March/000206.html
> 
> as well as later similar threads.
> 
> [The discussion continued in private email, with many bug reports and
> test programs by Kristian.  I'm very grateful to him for his reports
> and testing.]
> 
> The first 10 patches in this series make some improvements and bug
> fixes that came up along the way and don't specifically relate to
> multiple readers.  The next 10 patches, with the exception of "allow
> fc_handler list to grow dynamically", add the support for multiple
> readers.  The last one updates the commentary at the beginning of
> fhandler_fifo.cc that tries to explain how it all works.
> 
> The key ideas in these patches are:
> 
> 1. Use shared memory, so that all readers have the necessary
> information about the writers that are open.
> 
> 2. Designate one reader as the "owner".  This reader runs a thread
> that listens for connections and keeps track of the writers.
> 
> 3. Use a second shared memory block to be used for transfer of
> ownership.  Ownership must be transferred when the owner closes or
> execs.  And a reader that wants to read or run select must take
> ownership in order to be able to poll the writers for input.
> 
> The patches in this series have been applied to the topic/fifo branch
> in case it's easier to review/test them there.
> 
> Ken Brown (21):
>   Cygwin: FIFO: minor change - use NtClose
>   Cygwin: FIFO: simplify the fifo_client_handler structure
>   Cygwin: FIFO: change the fifo_client_connect_state enum
>   Cygwin: FIFO: simplify the listen_client_thread code
>   Cygwin: FIFO: remove the arm method
>   Cygwin: FIFO: honor the flags argument in dup
>   Cygwin: FIFO: dup/fork/exec: make sure child starts unlocked
>   Cygwin: FIFO: fix hit_eof
>   Cygwin: FIFO: make opening a writer more robust
>   Cygwin: FIFO: use a cygthread instead of a homemade thread
>   Cygwin: FIFO: add shared memory
>   Cygwin: FIFO: keep track of the number of readers
>   Cygwin: FIFO: introduce a new type, fifo_reader_id_t
>   Cygwin: FIFO: designate one reader as owner
>   Cygwin: FIFO: allow fc_handler list to grow dynamically
>   Cygwin: FIFO: add a shared fifo_client_handler list
>   Cygwin: FIFO: take ownership on exec
>   Cygwin: FIFO: find a new owner when closing
>   Cygwin: FIFO: allow any reader to take ownership
>   Cygwin: FIFO: support opening multiple readers
>   Cygwin: FIFO: update commentary
> 
>  winsup/cygwin/fhandler.h       |  208 ++++-
>  winsup/cygwin/fhandler_fifo.cc | 1564 ++++++++++++++++++++++----------
>  winsup/cygwin/select.cc        |   48 +-
>  3 files changed, 1311 insertions(+), 509 deletions(-)

Great work! Now, mc (midnight commander) starts without errro
message under tcsh!

However, mc hangs by several operations.

To reproduce this:
1. Start mc with 'env SHELL=tcsh mc -a'
2. Select a file using up/down cursor keys.
3. Press F3 (View) key.

This causes hang-up.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
