Return-Path: <cygwin-patches-return-5353-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2572 invoked by alias); 15 Feb 2005 00:02:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2187 invoked from network); 15 Feb 2005 00:01:59 -0000
Received: from unknown (HELO ciao.gmane.org) (80.91.229.2)
  by sourceware.org with SMTP; 15 Feb 2005 00:01:59 -0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1D0q7h-0007fU-5r
	for cygwin-patches@cygwin.com; Tue, 15 Feb 2005 00:59:25 +0100
Received: from eblake.csw.L-3com.com ([128.170.36.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Tue, 15 Feb 2005 00:59:25 +0100
Received: from ebb9 by eblake.csw.L-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Tue, 15 Feb 2005 00:59:25 +0100
To: cygwin-patches@cygwin.com
From: Eric Blake <ebb9@byu.net>
Subject: Re: patch to allow touch to work on HPFS (and others, maybe??)
Date: Tue, 15 Feb 2005 00:02:00 -0000
Message-ID: <loom.20050215T004351-284@post.gmane.org>
References: <20050208091029.GM19096@cygbert.vinschen.de> <0IBM0096T43FSM@pmismtp01.mcilink.com> <20050209085228.GF2597@cygbert.vinschen.de> <loom.20050210T160326-68@post.gmane.org> <20050210155633.GB2597@cygbert.vinschen.de> <loom.20050211T000509-58@post.gmane.org> <20050211142028.GD2597@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 128.170.36.44 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.1.4322))
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: gocp-cygwin-patches@m.gmane.org
X-MailScanner-To: cygwin-patches@cygwin.com
X-SW-Source: 2005-q1/txt/msg00056.txt.bz2

Corinna Vinschen <vinschen <at> redhat.com> writes:
> 
> I guess trying my approach isn't the worst one, though.  We should
> use that as a start point for further experimenting, IMHO.  I'll check
> that in.
> 

Checking win32.has_acls() and using GENERIC_WRITE caused a regression in utimes
().  The new upstream automake-1.9.5 tarball contains a read-only file (mode 
0444).  Before the 20050211 snapshot, when utimes() is still using 
FILE_WRITE_ATTRIBUTES, tar does just fine at adjusting the timestamp of that 
file when unpacking to an NFS-mounted directory.  However, with the current 
code, when I tried to unpack, tar is no longer able to touch the timestamps of 
the read-only file because GENERIC_WRITE requires write access for at least one 
of user, group, and other, even though touching the timestamp does not.

$ tar xjvf automake-1.9.5.tar.bz2
...
automake-1.9.5/m4/amversion.m4
tar: automake-1.9.5/m4/amversion.m4: Cannot utime: Permission denied
...
tar: Error exit delayed from previous errors
$ echo $?
2

