Return-Path: <cygwin-patches-return-5389-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27023 invoked by alias); 28 Mar 2005 16:21:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26880 invoked from network); 28 Mar 2005 16:21:19 -0000
Received: from unknown (HELO ciao.gmane.org) (80.91.229.2)
  by sourceware.org with SMTP; 28 Mar 2005 16:21:19 -0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DFwxp-0005W9-Ge
	for cygwin-patches@cygwin.com; Mon, 28 Mar 2005 18:19:44 +0200
Received: from eblake.csw.L-3com.com ([128.170.36.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Mon, 28 Mar 2005 18:19:41 +0200
Received: from ebb9 by eblake.csw.L-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Mon, 28 Mar 2005 18:19:41 +0200
To: cygwin-patches@cygwin.com
From:  Eric Blake <ebb9@byu.net>
Subject:  Re: exceeding =?utf-8?b?UEFUSF9NQVg=?=
Date: Mon, 28 Mar 2005 16:21:00 -0000
Message-ID:  <loom.20050328T175951-73@post.gmane.org>
References:  <4245843E.10700@byu.net> <20050326164106.GB11382@trixie.casa.cgf.cx>
Mime-Version:  1.0
Content-Type:  text/plain; charset=us-ascii
Content-Transfer-Encoding:  7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 128.170.36.44 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0; .NET CLR 1.1.4322))
X-SW-Source: 2005-q1/txt/msg00092.txt.bz2

Christopher Faylor <cgf-no-personal-reply-please <at> cygwin.com> writes:
> >2005-03-26  Eric Blake  <ebb9 <at> byu.net>
> >
> >	* errno.cc (FILENAME_EXCED_RANGE): Map to ENAMETOOLONG.
> 
> This is apparently fixing the symptom rather than the problem.  Cygwin
> is supposed to be detecting if the name is too long before it gets to
> the windows api.

Well, cygwin did not detect it, as proved by this portion of the strace from 
the test program I attached:

   66 1661823 [main] getcwd 6048 cwdstuff::get: (C:\cygwin\tmp\getcwd.test\confd
ir3\confdir3\confdir3\confdir3\confdir3\confdir3\confdir3\confdir3\confdir3\conf
dir3\confdir3\confdir3\confdir3\confdir3\confdir3\confdir3\confdir3\confdir3\con
fdir3\confdir3\confdir3\confdir3\confdir3\confdir3) = cwdstuff::get (0x22E280, 2
60, 0, 0), errno 0
  129 1661952 [main] getcwd 6048 alloc_sd: uid 22382, gid 10513, attribute 41C0
   69 1662021 [main] getcwd 6048 cygpsid::debug_print: alloc_sd: owner SID = S-1
-5-21-2062245864-1860583678-1057817870-12382
   64 1662085 [main] getcwd 6048 cygpsid::debug_print: alloc_sd: group SID = S-1
-5-21-2062245864-1860583678-1057817870-513
   67 1662152 [main] getcwd 6048 alloc_sd: ACL-Size: 160
  172 1662324 [main] getcwd 6048 alloc_sd: Created SD-Size: 236
  111 1662435 [main] getcwd 6048 seterrno_from_win_error: /netrel/src/cygwin-1.5
.13-1/winsup/cygwin/dir.cc:262 windows error 206
   75 1662510 [main] getcwd 6048 geterrno_from_win_error: windows error 206 == e
rrno 22
   61 1662571 [main] getcwd 6048 geterrno_from_win_error: windows error 206 == e
rrno 22
   61 1662632 [main] getcwd 6048 mkdir: -1 = mkdir (confdir3, 448)

It looks like the failure comes when the current working directory has length 
241, and the program requests a mkdir of an 8 character relative path.  mkdir 
defers to Windows CreateDirectory, which notices that the new directory would 
have length 250; CreateDirectory is documented with a maximum of 248 (MAX_PATH 
minus an 8.3 filename), so it returns an error.  From there, cygwin is mapping 
the windows error into EINVAL even though POSIX specifies ENAMETOOLONG.

I don't see any reason why this mapping should not be applied, even if you also 
patch mkdir to error out early rather than calling CreateDirectory.

