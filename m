Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 95CE9394505B
 for <cygwin-patches@cygwin.com>; Wed, 10 Feb 2021 10:12:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 95CE9394505B
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M9FX5-1lERa92Eat-006Kkd for <cygwin-patches@cygwin.com>; Wed, 10 Feb 2021
 11:12:42 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 742D0A80994; Wed, 10 Feb 2021 11:12:41 +0100 (CET)
Date: Wed, 10 Feb 2021 11:12:41 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Have tmpfile(3) use O_TMPFILE
Message-ID: <20210210101241.GA4251@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210209105000.26544-1-mark@maxrnd.com>
 <20210209152510.GV4251@calimero.vinschen.de>
 <69e6c815-eafe-1b9e-948c-fd64c977ae88@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69e6c815-eafe-1b9e-948c-fd64c977ae88@maxrnd.com>
X-Provags-ID: V03:K1:bRAfVb/wN/sx/XMfeIvJ6feXWuJD3IxG09lKAyw1pk2yL45pBuL
 Qefrx7gVPtzDTO1KS0QrC7uhg5W7HT2ZzFIMZVtVOHZN22ybkOjsURUn0MDD2RhjE+/SvoV
 C6T3ldIr+7ydE4HDjKAsxI94rxh7cN4Gqlfac7RoGJ3Te0P/710YDKlc/hWHclPuvbe5fjI
 IDrPP9pmhdaBCZ+MDLAoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:15yfmdWegyw=:6a7rhhsqIv5UmY6D/7PoHL
 7kAKA3VWpVbGhudiTMwCfFM+vJaTAeluplw0fWFws6XUdt7uKGb7Fg4WnxLbf0H/WgA7Tkv0p
 0Jg8rNH/Tl+GoQavE8zr7FBfypFvv9l5sagL5sCzximE9AiC7/AD9lJv9O7DaNdttsR/CQcFP
 6nftz7phWlpuuiMDao25HKpGsUKpQ2+tcE187l+K1c9Tm322RRLxFe5vsImHEKr81EkTKGZdh
 WLhFmIyRM5oMbMMGsfsRRfT4KMO0pTk7c5NAKECsU8f9d0ZmJBZ6QcDlF4A2LgRX78fbSIq8W
 +m5wxkH1c1cDi8n1zFdZ7eSQoICUiuhoMvrBMk9qWT/FSxN7YlHnAAhqvUqL1g0Xd/sfSnseE
 9jvbETyyQDaiuHE/j72P1eZNB/7al1JxK75gFuOhQLA9QMuJ6QfefD+ceMS9WNzkJJmJDIJPx
 rb1bZnwXe3/1vS+f7dRC4pIQt3K1ybcAMYuc4DNW2ZPUvbvdb764yLV/9hCj7lulmN+RTUu7z
 w==
X-Spam-Status: No, score=-107.3 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, KAM_SHORT,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 10 Feb 2021 10:12:49 -0000

On Feb 10 01:07, Mark Geisert wrote:
> Hi Corinna,
> 
> Corinna Vinschen via Cygwin-patches wrote:
> > Hi Mark,
> > 
> > On Feb  9 02:50, Mark Geisert wrote:
> > > Per discussion on cygwin-developers, a Cygwin tmpfile(3) implementation
> > > has been added to syscalls.cc.  This overrides the one supplied by
> > > newlib.  Then the open(2) flag O_TMPFILE was added to the open call that
> > > tmpfile internally makes.
> > > ---
> > >   winsup/cygwin/release/3.2.0 |  4 ++++
> > >   winsup/cygwin/syscalls.cc   | 20 ++++++++++++++++++++
> > >   2 files changed, 24 insertions(+)
> > > 
> > > diff --git a/winsup/cygwin/release/3.2.0 b/winsup/cygwin/release/3.2.0
> > > index f748a9bc8..d02d16863 100644
> > > --- a/winsup/cygwin/release/3.2.0
> > > +++ b/winsup/cygwin/release/3.2.0
> > > @@ -19,6 +19,10 @@ What changed:
> > >   - A few FAQ updates.
> > > +- Have tmpfile(3) make use of Win32 FILE_ATTRIBUTE_TEMPORARY via open(2)
> > > +  flag O_TMPFILE.
> > > +  Addresses: https://cygwin.com/pipermail/cygwin/2021-January/247304.html
> > > +
> > >   Bug Fixes
> > >   ---------
> > > diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> > > index 52a020f07..b79c1c7cd 100644
> > > --- a/winsup/cygwin/syscalls.cc
> > > +++ b/winsup/cygwin/syscalls.cc
> > > @@ -5225,3 +5225,23 @@ pipe2 (int filedes[2], int mode)
> > >     syscall_printf ("%R = pipe2([%d, %d], %y)", res, read, write, mode);
> > >     return res;
> > >   }
> > > +
> > > +extern "C" FILE *
> > > +tmpfile (void)
> > > +{
> > > +  char *dir = getenv ("TMPDIR");
> > 
> > This isn't what Linux tmpfile does.  Per the man page, it tries to
> > create the file in P_tmpdir first, and if that fails, it tries
> > "/tmp".
> 
> Oops, I was following newlib's code here.  I'll adjust this.

Oops, I didn't check with newlib, sorry.  Hmm, so we're stuck with
either Linux-compat or backward-compat but not both.  Decisions,
decisions...

Let's stick to backward-compat then, so no changes here.

> > > +  if (!dir)
> > > +    dir = P_tmpdir;
> > > +  int fd = open (dir, O_RDWR | O_CREAT | O_BINARY | O_TMPFILE,
> > 
> > You have to specify O_EXCL here.  The idea is that this file cannot be
> > made permanent, and missing the O_EXCL flag allows exactly that.  See
> > https://man7.org/linux/man-pages/man2/open.2.html, the lengthy
> > description in terms of O_TMPFILE.
> 
> I started out with O_EXCL as you suggested, but found syscalls.cc:1504
> reporting EEXIST.  Is there some clash there between fh->exists() and
> O_TMPFILE?  Hmm.

You specify O_CREAT as well.  O_TMPFILE replaces O_CREAT.  The
combination O_CREAT|O_EXCL still checks for existence of the file, in
that case, the dir.


Thanks,
Corinna
