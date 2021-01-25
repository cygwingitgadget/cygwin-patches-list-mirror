Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 by sourceware.org (Postfix) with ESMTPS id 47F083858C27
 for <cygwin-patches@cygwin.com>; Mon, 25 Jan 2021 09:38:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 47F083858C27
Received: from Express5800-S70 (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 10P9bh51018665
 for <cygwin-patches@cygwin.com>; Mon, 25 Jan 2021 18:37:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 10P9bh51018665
X-Nifty-SrcIP: [122.249.67.108]
Date: Mon, 25 Jan 2021 18:37:43 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/4] Improve pseudo console support.
Message-Id: <20210125183743.6b12ed0a506c303fc4bd6bab@nifty.ne.jp>
In-Reply-To: <20210122122057.GE810271@calimero.vinschen.de>
References: <20210121205852.536-1-takashi.yano@nifty.ne.jp>
 <20210122122057.GE810271@calimero.vinschen.de>
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
X-List-Received-Date: Mon, 25 Jan 2021 09:38:26 -0000

Hi Corinna,

Thanks for testing.

On Fri, 22 Jan 2021 13:20:57 +0100
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Jan 22 05:58, Takashi Yano via Cygwin-patches wrote:
> > The new implementation of pseudo console support by commit bb428520
> > provides the important advantages, while there also has been several
> > disadvantages compared to the previous implementation.
> > 
> > These patches overturn some of them.
> > 
> > The disadvantage:
> >  1) The cygwin program which calls console API directly does not work.
> > is supposed to be able to be overcome as well, however, I am not sure
> > it is worth enough. This will need a lot of hooks for console APIs.
> > 
> > Takashi Yano (4):
> >   Cygwin: pty: Inherit typeahead data between two input pipes.
> >   Cygwin: pty: Keep code page between non-cygwin apps.
> >   Cygwin: pty: Make apps using console APIs be able to debug with gdb.
> >   Cygwin: pty: Allow multiple apps to enable pseudo console
> >     simultaneously.
> > 
> >  winsup/cygwin/fhandler.h      |  15 +-
> >  winsup/cygwin/fhandler_tty.cc | 805 ++++++++++++++++++++++++++--------
> >  winsup/cygwin/spawn.cc        | 102 +++--
> >  winsup/cygwin/tty.cc          |  11 +-
> >  winsup/cygwin/tty.h           |  18 +-
> >  5 files changed, 730 insertions(+), 221 deletions(-)
> > 
> > -- 
> > 2.30.0
> 
> I found a problem with this patchset.
> 
> Try this:
> 
>   Start mintty
> 
>   $ touch foo
>   $ attrib +r foo
>   $ gdb /bin/rm
>   $ start foo
> 
>   At this point, starting rm will take a few seconds.  While GDB is
>   still working on this, *before* GDB returns to the prompt, type some
>   keys on keyboard, e. g., "1234".
> 
> Without this patchset, you'll see the keys being echoed in mintty, and
> as soon as GDB returns to the prompt, the keys are copied to GDBs input
> buffer and the keys you typed show up after the prompt.  This is the
> expected behaviour.
> 
>   (gdb) 1234
> 
> With this patchset, the keys are *not* echoed in mintty, and as soon
> as the GDB prompt returns, the keys are still not visible.

I have fixed this issue. Please try v3 patch set. In v3 patch set,
pseudo console is not activated for GDB if the app to be debugged
is cygwin program. Also, for non-cygwin apps, I added the code to
transfer input when switching occurs between GDB and the debugging
process.

> Now continue the execution of rm:
> 
>   (gdb) c
>   /usr/bin/rm: remove write-protected regular file 'foo'? 
> 
> Without this patchset, I get
> 
>   /usr/bin/rm: error closing file
>   [...]
>   [Inferior 1 (process 1224) exited with code 01]
>   (gdb)

This seems to be a bug of cygwin GDB. The cause is that the pgid
setting for /usr/bin/rm is lost after break. The following patch
for GDB source resolves the issue. In the following section,
winpid is passed to getpgid() rather than cygwin pid. Also, winpid
is passed to other POSIX system calls such as kill() elsewhere. 

I hope the GDB maintainer will check it out.

--- inflow.c.orig	2020-05-24 06:10:29.000000000 +0900
+++ inflow.c	2021-01-23 17:48:27.963609500 +0900
@@ -364,11 +364,11 @@
 #ifdef HAVE_TERMIOS_H
 	  /* If we can't tell the inferior's actual process group,
 	     then restore whatever was the foreground pgrp the last
 	     time the inferior was running.  See also comments
 	     describing terminal_state::process_group.  */
-#ifdef HAVE_GETPGID
+#if defined (HAVE_GETPGID) && !defined (__CYGWIN__)
 	  result = tcsetpgrp (0, getpgid (inf->pid));
 #else
 	  result = tcsetpgrp (0, tinfo->process_group);
 #endif
 	  if (result == -1)


> That's not optimal, apparently.  With this patchset:
> 
>   (gdb) c
>   /usr/bin/rm: remove write-protected regular file 'foo'? 1234
> 
> so the keys typed while gdb was starting rm have been saved up and then
> used as input for rm.  That's not quite right either, is it?

Another undesired behavior of cygwin GDB is that the debugging program
in pty cannot continue to execute after interrupted by Ctrl-C. If pseudo
console is activated for the debugging program, it seems to be able to
do this for some unknown reason.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
