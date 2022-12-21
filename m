Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	by sourceware.org (Postfix) with ESMTPS id 6ECAB3858D1E
	for <cygwin-patches@cygwin.com>; Wed, 21 Dec 2022 12:56:28 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MiZof-1odc2H1b8R-00fgKx for <cygwin-patches@cygwin.com>; Wed, 21 Dec 2022
 13:56:26 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6D3C1A8078A; Wed, 21 Dec 2022 13:56:25 +0100 (CET)
Date: Wed, 21 Dec 2022 13:56:25 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Make the console accessible from other
 terminals.
Message-ID: <Y6MCeRdiRCJAQMbV@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20221220124521.499-1-takashi.yano@nifty.ne.jp>
 <Y6ItllXJ8J20cEbp@calimero.vinschen.de>
 <20221221192343.32699d22e6d113ce9195de8f@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221221192343.32699d22e6d113ce9195de8f@nifty.ne.jp>
X-Provags-ID: V03:K1:k8eAhyMo48/LsUqHleI+p0CVd9meEnucSm9XXux2Lc1B3+Cq6x8
 ZFWaVr+L2E1WT3kNwdReOW6NhX1XDD7BVQJmWHSSXTN3dEZVN7qSR+c20xLo6pKYDSDK9Lr
 UlUYPgHi6z+LL5myRNHeL1E3nfzoyW3lQVk9g/L2vntLxhjtgnKm9KlHpMmUVDPlYT8FtjY
 jYXTJXqpSlkPU6Ypx6f9w==
UI-OutboundReport: notjunk:1;M01:P0:sl96Uswb8CI=;jLTSR9XQL15ganct4MNZvRWt5t7
 rIUVrUqI+MWsuv0055z2mKNnIsl/MafMknMo/A0WBX2PvKfnLqsUBD3g2MZJemAq10tXrlQCx
 D6fZRSoV4OWspi1Z7OGLYpmXM3JvLmuMKXlG1kKQtmAvH2CJw1/roSGzPik1it/Lt+OJOJGwf
 qr/T0Sa6f1+tBYWtYjyUXyXhwcVcO7KNjxoqQ1YtQawHyrX7NkRsmb2y9DzLcKYQ+9IjrldTZ
 cR/TMqF0s1vSJAFfjMJwl7PnM/ndGkIJKpFSUAPAaH6+zLeN/OvjwB7plXGwwvUNIqgMrXSUz
 ylm4E8rsUROnjLdSOhIP0juDA7wmh3vgbotQ/1n9R3pP8UzSlyDM8sfxvpcLTINeCe+lL0LlM
 o8NGmIwbM632iy+S9P4kfL/84OWdCCvqtdM14MKh1efLZfHa7NsvT/xzZrPY8I+C/Pc48HbkJ
 NKqTf4UvAPhxvROx10GgU8WQ2sDYB/QEcuJZdu/KI7uWl/2M3ryx4iN4WGU4vH9gO3vX2NZeK
 kAGGG4glraPHUe5Lw/6Bxg1fQ3UquoBVr3VZDO6z7j7p1GS/eUI3ZR37r4UE/WgXhK1hgTpyu
 Ft7W3rFY9FLyRAaJd9jTTQ45C5cd7kqVYWLcCSV/1raTlPZZlOT+J0h5Xvz9qin6IFjD4Ox6m
 cYwgzIkFTq/FmTWSkG1wyKmdQ1Z4FrDbwzwHeCYpsg==
X-Spam-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Dec 21 19:23, Takashi Yano wrote:
> On Tue, 20 Dec 2022 22:48:06 +0100
> Corinna Vinschen wrote:
> > On Dec 20 21:45, Takashi Yano wrote:
> > > Previously, the console device could not be accessed from other terminals.
> > > Due to this limitation, GNU screen and tmux cannot be opened in console.
> > > With this patch, console device can be accessed from other TTYs, such as
> > > other consoles or ptys. Thanks to this patch, screen and tmux get working
> > > in console.
> > > 
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > ---
> > >  winsup/cygwin/devices.cc                |  24 +-
> > >  winsup/cygwin/devices.in                |  24 +-
> > >  winsup/cygwin/fhandler/console.cc       | 438 +++++++++++++++++-------
> > >  winsup/cygwin/fhandler/pty.cc           |   4 +-
> > >  winsup/cygwin/local_includes/fhandler.h |  26 +-
> > >  winsup/cygwin/local_includes/winsup.h   |   1 -
> > >  winsup/cygwin/select.cc                 |   2 +
> > >  7 files changed, 382 insertions(+), 137 deletions(-)
> > 
> > I just toyed around with screen and this looks really great.
> > 
> > Just one question: What about security?  If we now can share
> > consoles, don't we need fchmod/fchown calls, too?
> 
> Thanks for reviewing.
> 
> As for security, AttachConsole() for another user's process
> will failed with ERROR_ACCESS_DENIED, so the console of
> another user is inaccessible.

That's what I'm wondering about...

Since Windows 7, Console handles are real OS handles, not just pseudo
handles like in olden times.

Given they are real handles, they should have an ACL attached and,
theoretically, it should be possible to change this ACL.

> However, fstat() does not return appropriate information,
> so, I implemented fhandler_console::fstat(). I also set proper
> errno for that case. Please see v2 patch.

That would also affect fstat, kind of like in fhandler_pty_slave.

However, there's something broken with these patches in terms of
debugging:

With current origin/master:

  $ ls -l  /dev/cons0
  crw-rw-rw- 4 corinna vinschen 3, 0 Dec 21 13:46 /dev/cons0
  $ strace -o xxx /bin/ls /dev/cons0
  /dev/cons0

After applying "pinfo: Align CTTY behavior to the statement of POSIX."

  $ ls -l /dev/cons0
  crw-rw-rw- 4 corinna vinschen 3, 0 Dec 21 13:51 /dev/cons0
  $ strace -o xxx /bin/ls /dev/cons0
  /usr/bin/ls: cannot access '/dev/cons0': No such device or address

"devices: Make generic console devices invisible from pty." doesn't
change this, but after applying "console: Make the console accessible
from other terminals.":

  $ ls -l /dev/cons0
  crw------- 4 corinna vinschen 3, 0 Dec 21 13:55 /dev/cons0
  $ strace -o xxx /bin/ls /dev/cons0
   670400 [main] ls 1630 C:\cygwin64\bin\ls.exe: *** fatal error - MapViewOfFileEx '(null)'(0x54), Win32 error 487.  Terminating.
   674526 [main] ls 1630 cygwin_exception::open_stackdumpfile: Dumping stack trace to ls.exe.stackdump

FWIW:

  $ strace -o xxx /bin/ls
   673796 [main] ls 1633 C:\cygwin64\bin\ls.exe: *** fatal error - MapViewOfFileEx '(null)'(0x54), Win32 error 487.  Terminating.
   676814 [main] ls 1633 cygwin_exception::open_stackdumpfile: Dumping stack trace to ls.exe.stackdump


Corinna
