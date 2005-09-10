Return-Path: <cygwin-patches-return-5646-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9015 invoked by alias); 10 Sep 2005 15:00:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8711 invoked by uid 22791); 10 Sep 2005 14:59:46 -0000
Received: from main.gmane.org (HELO ciao.gmane.org) (80.91.229.2)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sat, 10 Sep 2005 14:59:46 +0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EE6m6-0005xi-V6
	for cygwin-patches@cygwin.com; Sat, 10 Sep 2005 16:56:15 +0200
Received: from c-67-172-242-110.hsd1.ut.comcast.net ([67.172.242.110])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Sat, 10 Sep 2005 16:56:14 +0200
Received: from ebb9 by c-67-172-242-110.hsd1.ut.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Sat, 10 Sep 2005 16:56:14 +0200
To: cygwin-patches@cygwin.com
From:  Eric Blake <ebb9@byu.net>
Subject:  PING: fix =?utf-8?b?QVJHX01BWA==?=
Date: Sat, 10 Sep 2005 15:00:00 -0000
Message-ID:  <loom.20050910T164247-175@post.gmane.org>
References:  <loom.20050906T172937-420@post.gmane.org>
Mime-Version:  1.0
Content-Type:  text/plain; charset=us-ascii
Content-Transfer-Encoding:  7bit
User-Agent: Loom/3.14 (http://gmane.org/)
X-SW-Source: 2005-q3/txt/msg00101.txt.bz2

Eric Blake <ebb9 <at> byu.net> writes:

Just making sure this patch didn't fall through the cracks...

> 
> 2005-09-06  Eric Blake  <ebb9 <at> byu.net>
> 
> 	* include/limits.h (ARG_MAX): New limit.
> 	* sysconf.cc (sysconf): _SC_ARG_MAX: Use it.

Even with your recent patches to make cygwin programs receive longer command
lines, whether or not they are not mounted cygexec, ARG_MAX should still reflect
the worst case limit so that programs (like xargs) that use ARG_MAX will work
reliably even when invoking non-cygwin programs that are really bound by the 32k
limit.

Maybe it is worth adding _PC_ARG_MAX as an extension to the standards for
pathconf(), so that programs that are aware of cygwin's dependence on the path
being executed determining the length of the max command line can use pathconf()
instead of sysconf() to obtain a more accurate limit.  Something like this:
sysconf(_SC_ARG_MAX) --> 32k
pathconf("notepad", _PC_ARG_MAX) --> 32k (performs PATH search if /, \ not in
filename)
pathconf("/bin/echo", _PC_ARG_MAX) --> 8M (or whatever limit can be determined)
pathconf("nonesuch", _PC_ARG_MAX) --> -1, errno = ENOENT

Then xargs could use this non-standard extension to allow larger command lines
when the target utility is a known cygwin executable, rather than penalizing all
cygwin programs to the safe 32k limit of ARG_MAX.
