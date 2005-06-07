Return-Path: <cygwin-patches-return-5531-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 547 invoked by alias); 7 Jun 2005 00:56:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 530 invoked by uid 22791); 7 Jun 2005 00:56:51 -0000
Received: from nat.electric-cloud.com (HELO main.electric-cloud.com) (63.82.0.114)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 07 Jun 2005 00:56:51 +0000
Received: from fulgurite.electric-cloud.com (fulgurite.electric-cloud.com [192.168.1.58])
	(authenticated bits=0)
	by main.electric-cloud.com (8.12.9/8.12.9) with ESMTP id j570umM2031589
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <cygwin-patches@cygwin.com>; Mon, 6 Jun 2005 17:56:48 -0700
Subject: Re: [Patch] Testing loads of cygwin1.dll from MinGW and MSVC, take
	3
From: Max Kaehn <slothman@electric-cloud.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20050606213339.GC16960@trixie.casa.cgf.cx>
References: <1118084587.5031.128.camel@fulgurite>
	 <20050606200639.GC13442@trixie.casa.cgf.cx>
	 <1118091704.5031.144.camel@fulgurite>
	 <20050606213339.GC16960@trixie.casa.cgf.cx>
Content-Type: multipart/mixed; boundary="=-BCbkoglJ4pqdsPKmjNje"
Message-Id: <1118105808.5031.172.camel@fulgurite>
Mime-Version: 1.0
Date: Tue, 07 Jun 2005 00:56:00 -0000
X-Spam-Not-Checked:  Messages over 100K or from internal Electric Cloud machines are not checked
X-SW-Source: 2005-q2/txt/msg00127.txt.bz2


--=-BCbkoglJ4pqdsPKmjNje
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-length: 1141

On Mon, 2005-06-06 at 14:33, Christopher Faylor wrote:
> So, I checked in the above and, after changing cygload.exp so that it
> compiles cygload.cc rather than cygload.cpp, I found a more serious
> error.  I've attached the cygload.log file.  It doesn't look pretty,
> unfortunately.  You might notice the same thing if you configure your
> Cygwin DLL with --enable-debugging, like I do.

I'm having trouble replicating the problem.  Here's what I did:

    cd src/build
    rm -rf etc i686-pc-cygwin libiberty
    ../configure --enable-debugging=yes
    make
    cd i686-pc-cygwin/winsup
    make check
    cd testsuite
    runtest --tool cygload

The first time I ran "runtest --tool cygload", I got an error about
mismatched heap addresses, so I copied new-cygwin1.dll to
/bin/cygwin1.dll and reran the test.  That time, it passed.

What am I doing wrong?  I've attached the output of "runtest --tool
cygload -v".  (The mingw-cygwin.log referenced in there is empty.)
I notice that I'm getting warnings about "couldn't find the global
config file" and "couldn't find tool init file", so there may be
something wrong with my test setup.


--=-BCbkoglJ4pqdsPKmjNje
Content-Disposition: attachment; filename=cygload.log
Content-Type: text/plain; name=cygload.log; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-length: 2570

Expect binary is /bin/expect
Using /usr/share/dejagnu/runtest.exp as main test driver
Verbose level is 1
Login name is slothman
Found ~/.dejagnurc
.dejagnurc
Found /u/cygwin/src/build/i686-pc-cygwin/winsup/testsuite/site.exp
Using test sources in /u/cygwin/src/winsup/testsuite
Using test binaries in /u/cygwin/src/build/i686-pc-cygwin/winsup/testsuite
Tool root directory is /u/cygwin/src/build/i686-pc-cygwin
Using /usr/share/dejagnu to find libraries
Found /usr/share/dejagnu/libexec/config.guess
Assuming build host is i686-pc-cygwin
WARNING: Couldn't find the global config file.
Loading /usr/share/dejagnu/utils.exp
Loading /usr/share/dejagnu/framework.exp
Loading /usr/share/dejagnu/debugger.exp
Loading /usr/share/dejagnu/remote.exp
Loading /usr/share/dejagnu/mondfe.exp
Loading /usr/share/dejagnu/xsh.exp
Loading /usr/share/dejagnu/telnet.exp
Loading /usr/share/dejagnu/rlogin.exp
Loading /usr/share/dejagnu/kermit.exp
Loading /usr/share/dejagnu/tip.exp
Loading /usr/share/dejagnu/rsh.exp
Loading /usr/share/dejagnu/ftp.exp
Loading /usr/share/dejagnu/target.exp
Loading /usr/share/dejagnu/targetdb.exp
Loading /usr/share/dejagnu/libgloss.exp
WARNING: Couldn't find tool init file
Testing cygload
Opening log files in .
Test Run By slothman on Mon Jun  6 17:52:09 2005
Native configuration is i686-pc-cygwin

		=== cygload tests ===

setting trap for SIGTERM to terminated
setting trap for SIGINT to interrupted by user
setting trap for SIGQUIT to interrupted by user
setting trap for SIGSEGV to segmentation violation
dirlist is /usr/share/dejagnu/baseboards
pushing config for build, name is levinbolt-xp
dirlist is /usr/share/dejagnu/baseboards
pushing config for host, name is levinbolt-xp
Schedule of variations:
    unix

target is unix
Running target unix
dirlist is /usr/share/dejagnu/baseboards/levinbolt-xp /usr/share/dejagnu/baseboards
Using /usr/share/dejagnu/baseboards/unix.exp as board description file for target.
Using /usr/share/dejagnu/config/unix.exp as generic interface file for target.
Using /u/cygwin/src/winsup/testsuite/config/default.exp as tool-and-target-specific interface file.
pushing config for target, name is unix
Running /u/cygwin/src/winsup/testsuite/cygload/cygload.exp ...
running gcc -mno-cygwin /u/cygwin/src/winsup/testsuite/cygload/cygload.cc -o mingw-cygload.exe -lstdc++ -Wl,-e,_cygloadCRTStartup@0

running ./mingw-cygload.exe -cygwin u:/cygwin/src/build/i686-pc-cygwin/winsup/cygwin/cygwin0.dll > ./mingw-cygwin.log


		=== cygload Summary ===

# of expected passes		1
runtest completed at Mon Jun  6 17:52:14 2005

--=-BCbkoglJ4pqdsPKmjNje--
