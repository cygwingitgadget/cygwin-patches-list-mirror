Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com
 [210.131.2.83])
 by sourceware.org (Postfix) with ESMTPS id 8489E3840C1D
 for <cygwin-patches@cygwin.com>; Tue, 19 May 2020 14:07:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8489E3840C1D
Received: from Express5800-S70 (v040007.dynamic.ppp.asahi-net.or.jp
 [124.155.40.7]) (authenticated)
 by conssluserg-04.nifty.com with ESMTP id 04JE7FL8008405;
 Tue, 19 May 2020 23:07:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 04JE7FL8008405
X-Nifty-SrcIP: [124.155.40.7]
Date: Tue, 19 May 2020 23:07:17 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 00/21] FIFO: Support multiple readers
Message-Id: <20200519230717.d84c2bfbb10cf5f89c698e3e@nifty.ne.jp>
In-Reply-To: <48b29425-61fa-34c2-4b4a-afaf3c4a1c03@cornell.edu>
References: <20200507202124.1463-1-kbrown@cornell.edu>
 <20200518142519.cb6d805fa92afe4dcb017b02@nifty.ne.jp>
 <20200518143657.4e9f732f5456174348688f69@nifty.ne.jp>
 <912d46fc-3138-f3ec-f4d1-612433d9f128@cornell.edu>
 <cd2e382e-1c32-864a-31a4-8a6b7cfffc08@cornell.edu>
 <20200519102609.a3c2faa4f19ac655126c0680@nifty.ne.jp>
 <20200519151535.b4a97a0173f4d2ad4590d4c1@nifty.ne.jp>
 <21fa9885-0405-10b7-982e-9fa19058070d@cornell.edu>
 <48b29425-61fa-34c2-4b4a-afaf3c4a1c03@cornell.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 19 May 2020 14:07:45 -0000

On Tue, 19 May 2020 09:37:17 -0400
Ken Brown via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> On 5/19/2020 8:51 AM, Ken Brown via Cygwin-patches wrote:
> > On 5/19/2020 2:15 AM, Takashi Yano via Cygwin-patches wrote:
> >> On Tue, 19 May 2020 10:26:09 +0900
> >> Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> >>> Hi Ken,
> >>>
> >>> On Mon, 18 May 2020 13:42:19 -0400
> >>> Ken Brown via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> >>>> Hi Takashi,
> >>>>
> >>>> On 5/18/2020 12:03 PM, Ken Brown via Cygwin-patches wrote:
> >>>>> On 5/18/2020 1:36 AM, Takashi Yano via Cygwin-patches wrote:
> >>>>>> On Mon, 18 May 2020 14:25:19 +0900
> >>>>>> Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> >>>>>>> However, mc hangs by several operations.
> >>>>>>>
> >>>>>>> To reproduce this:
> >>>>>>> 1. Start mc with 'env SHELL=tcsh mc -a'
> >>>>>>
> >>>>>> I mean 'env SHELL=/bin/tcsh mc -a'
> >>>>>>
> >>>>>>> 2. Select a file using up/down cursor keys.
> >>>>>>> 3. Press F3 (View) key.
> >>>>>
> >>>>> Thanks for the report.  I can reproduce the problem and will look into it.
> >>>>
> >>>> I'm not convinced that this is a FIFO bug.  I tried two things.
> >>>>
> >>>> 1. I attached gdb to mc while it was hanging and got the following backtrace
> >>>> (abbreviated):
> >>>>
> >>>> #1  0x00007ff901638037 in WaitForMultipleObjectsEx ()
> >>>> #2  0x00007ff901637f1e in WaitForMultipleObjects ()
> >>>> #3  0x0000000180048df5 in cygwait () at ...winsup/cygwin/cygwait.cc:75
> >>>> #4  0x000000018019b1c0 in wait4 () at ...winsup/cygwin/wait.cc:80
> >>>> #5  0x000000018019afea in waitpid () at ...winsup/cygwin/wait.cc:28
> >>>> #6  0x000000018017d2d8 in pclose () at ...winsup/cygwin/syscalls.cc:4627
> >>>> #7  0x000000018015943b in _sigfe () at sigfe.s:35
> >>>> #8  0x000000010040d002 in get_popen_information () at filemanager/ext.c:561
> >>>> [...]
> >>>>
> >>>> So pclose is blocking after calling waitpid.  As far as I can tell from looking
> >>>> at backtraces of all threads, there are no FIFOs open.
> >>>>
> >>>> 2. I ran mc under strace (after exporting SHELL=/bin/tcsh), and I didn't see
> >>>> anything suspicious involving FIFOs.  But I saw many EBADF errors from fstat 
> >>>> and
> >>>> close that don't appear to be related to FIFOs.
> >>>>
> >>>> So my best guess at this point is that the FIFO changes just exposed some
> >>>> unrelated bug(s).
> >>>>
> >>>> Prior to the FIFO changes, mc would get an error when it tried to open 
> >>>> tcsh_fifo
> >>>> the second time, and it would then set
> >>>>
> >>>>     mc_global.tty.use_subshell = FALSE;
> >>>>
> >>>> see the mc source file subshell/common.c:1087.
> >>>
> >>> I looked into this problem and found pclose() stucks if FIFO
> >>> is opened.
> >>>
> >>> Attached is a simple test case. It works under cygwin 3.1.4,
> >>> but stucks at pclose() under cygwin git head.
> >>>
> >>> Isn't this a FIFO related issue?
> >>
> >> In the test case, fhandler_fifo::close() called from /bin/true
> >> seems to get into infinite loop at:
> >>
> >> do
> >> ...
> >> while (inc_nreaders () > 0 && !found);
> > 
> > Thank you!  I see the problem.  After the popen call, the original 
> > fhandler_fifo's fifo_reader_thread was no longer running, so it was unable to 
> > take ownership.
> > 
> > It might take a little while for me to figure out how to fix this.
> 
> Actually, I think it's easy.  Please try the two attached patches.  The second 
> one is the crucial one for the mc problem, but the first is something I noticed 
> while working on this.
> 
> I just did a quick and dirty patch for testing purposes.  I still have to do a 
> lot of cleanup and make sure the fix doesn't break something else.

For a shor time, I tested these patches, and confirmed
that this fixes the problem.

Thanks for the quick response.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
