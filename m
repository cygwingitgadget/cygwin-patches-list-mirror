Return-Path: <cygwin-patches-return-5352-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22219 invoked by alias); 14 Feb 2005 16:46:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22166 invoked from network); 14 Feb 2005 16:46:45 -0000
Received: from unknown (HELO ciao.gmane.org) (80.91.229.2)
  by sourceware.org with SMTP; 14 Feb 2005 16:46:45 -0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1D0jKL-00024p-4R
	for cygwin-patches@cygwin.com; Mon, 14 Feb 2005 17:44:08 +0100
Received: from eblake.csw.L-3com.com ([128.170.36.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Mon, 14 Feb 2005 17:44:01 +0100
Received: from ebb9 by eblake.csw.L-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Mon, 14 Feb 2005 17:44:01 +0100
To: cygwin-patches@cygwin.com
From: Eric Blake <ebb9@byu.net>
Subject: Re: patch to allow touch to work on HPFS (and others, maybe??)
Date: Mon, 14 Feb 2005 16:46:00 -0000
Message-ID: <loom.20050214T171701-959@post.gmane.org>
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
X-SW-Source: 2005-q1/txt/msg00055.txt.bz2

Corinna Vinschen <vinschen <at> redhat.com> writes:
> 
> That could be a result of the Cygwin internals.  I assume that the
> CreateFile call requesting any write access fails on both filesystems.
> If you have a look into utimes, you see that Cygwin ignores this case:
> 
>   h = CreateFile()
>   if ((h == INVALID_HANDLE_VALUE)
>     if (win32.isdir ())
>       {
>         /* What we can do with directories more? */
> 	res = 0;
>       }
>     [...]
> 
> Can you add a __seterrno () before the `res = 0;' line and see what
> Win32 error is produced by CreateFile (*iff* my assumption is correct)?

No error is produced, so it is not the cygwin internals that are failing to 
touch directory times.  Opening a directory on either the ClearCase or the NFS 
mount point using CreateFile() generates a valid handle, and SetFileTimes 
returns 0 with GetLastError() returning 0; completely bypassing the win32.isdir
() check.  As far as I can tell, there is no way to detect that the 
SetFileTimes is a no-op on directories located in non-NTFS filesystems, short 
of reading the file times before and after the SetFileTimes call (which is not 
worth the effort).  Besides, detecting that SetFileTimes was a no-op is useless 
if there is no alternative way to force Windows to set the times on such a 
directory.

