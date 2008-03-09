Return-Path: <cygwin-patches-return-6267-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5427 invoked by alias); 9 Mar 2008 10:32:39 -0000
Received: (qmail 5415 invoked by uid 22791); 9 Mar 2008 10:32:39 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 09 Mar 2008 10:32:13 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JYIp9-00049S-CO 	for cygwin-patches@cygwin.com; Sun, 09 Mar 2008 10:32:11 +0000
Message-ID: <47D3BCAC.98C49164@dessent.net>
Date: Sun, 09 Mar 2008 10:32:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de> <47D3B079.C8BA614C@dessent.net> <20080309095109.GX18407@calimero.vinschen.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00041.txt.bz2

Corinna Vinschen wrote:

> > > I'm wondering if you would like to tweak the readlink functions, too.
> > > Cygwin shortcuts can now have the path name appended to the actual
> > > shortcut data.  This hack was necessary to support pathnames longer than
> > > 2000 chars.  See the comment and code in cygwin/path.cc, line 3139ff.
> >
> > Oh, I didn't know that.  I'll add that to the list.
> 
> Thanks again.  I'm finally seeing light at the end of the long path
> name tunnel :)

Actually I'm a little confused now.  It seems like the code in
utils/path.cc:readlink() reads the Win32 path out of shortcut symlinks
but the POSIX path out of old-style symlinks -- not that it has any
choice since they don't contain the win32 path.  If that is the case
(and assuming I'm reading the new long filename symlink code correctly)
then it doesn't need any chaging since the [path too long] workaround
only applies to the POSIX link target stored in the 'description' field,
right?

But the semantics of "sometimes you get an absolute Win32 path,
sometimes you get a relative POSIX path" that readlink() seems to
provide baffles my mind.  More and more it seems that a lot of how these
non-Cygwin tools successfully process paths happens seemingly out of
luck.  I'll have to go and research the callers of readlink() but it
seems like it should be always returning the POSIX target, since that's
the only sane behavior in the face of old and new styles.

Brian
