Return-Path: <cygwin-patches-return-6269-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 367 invoked by alias); 9 Mar 2008 12:02:50 -0000
Received: (qmail 353 invoked by uid 22791); 9 Mar 2008 12:02:49 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 09 Mar 2008 12:02:21 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1JYKEN-0004Mi-8v 	for cygwin-patches@cygwin.com; Sun, 09 Mar 2008 12:02:19 +0000
Message-ID: <47D3D1CC.87E7D183@dessent.net>
Date: Sun, 09 Mar 2008 12:02:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] cygcheck.cc update for cygpath()
References: <47D2E28C.3FC392D3@dessent.net> <20080308212718.GB5863@ednor.casa.cgf.cx> <47D3550B.76D34355@dessent.net> <20080309032437.GB6777@ednor.casa.cgf.cx> <47D36406.F7D7AB61@dessent.net> <20080309092806.GW18407@calimero.vinschen.de> <47D3B079.C8BA614C@dessent.net> <20080309095109.GX18407@calimero.vinschen.de> <47D3BCAC.98C49164@dessent.net> <20080309103618.GZ18407@calimero.vinschen.de>
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
X-SW-Source: 2008-q1/txt/msg00043.txt.bz2

Corinna Vinschen wrote:

> Now that you mention it... did you see the comment in path.cc, line 3112ff?
> There's a good chance that Windows shortcuts are not capable of long path
> names.  I didn't test it so far, but it would be certainly better for
> readlink to use the POSIX path in the symlink either way.

Check this out.  I modified cygcheck to have a command line option to
dump out whatever readlink() returns.

$ cd /tmp
$ echo "fileone" >fileone
$ ln -s fileone linkone
$ ln -s filetwo linktwo        # filetwo doesn't exist yet
$ echo "filetwo" >filetwo
$ cat linkone
fileone
$ cat linktwo
filetwo
$ ./cygcheck -x linkone linktwo
linkone -> fileone
linktwo -> c:\tmp\filetwo
$ ls -l linkone linktwo
lrwxrwxrwx 1 brian None 7 Mar  9 04:56 linkone -> fileone
lrwxrwxrwx 1 brian None 7 Mar  9 04:56 linktwo -> filetwo

So, the fact that the link was dangling at the time it was created
caused readlink to read it as a Win32 path -- which also causes it to
now be an absolute target instead of a relative target.  Apparently this
is due to the fact that if the target doesn't exist at creation time the
ParseDisplayName thing fails which results in a different structure for
the .lnk file, which confuses readlink()'s puny little brain which only
knows how to look at a fixed offset in the file, which results in it
reading a different slot.  Sigh.

Brian
