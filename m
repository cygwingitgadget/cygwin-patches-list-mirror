Return-Path: <cygwin-patches-return-5526-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7925 invoked by alias); 6 Jun 2005 21:33:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7900 invoked by uid 22791); 6 Jun 2005 21:33:41 -0000
Received: from c-66-30-17-189.hsd1.ma.comcast.net (HELO cgf.cx) (66.30.17.189)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 06 Jun 2005 21:33:41 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id AEC1F13C28E; Mon,  6 Jun 2005 17:33:39 -0400 (EDT)
Date: Mon, 06 Jun 2005 21:33:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Testing loads of cygwin1.dll from MinGW and MSVC, take 3
Message-ID: <20050606213339.GC16960@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1118084587.5031.128.camel@fulgurite> <20050606200639.GC13442@trixie.casa.cgf.cx> <1118091704.5031.144.camel@fulgurite>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <1118091704.5031.144.camel@fulgurite>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q2/txt/msg00122.txt.bz2


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 1683

On Mon, Jun 06, 2005 at 02:01:44PM -0700, Max Kaehn wrote:
>This patch contains a revised version of the "cygload" test utility,
>this time with even better adherence to cygwin naming and indentation.
>Igor, thanks for pointing me at "indent"-- it also pointed out
>that I was forgetting to put spaces in front of the parameter
>lists for my function calls.
>
>I'm using diff -upN against an empty directory "winsup/testsuite/cyglode";
>I hope that's OK.
>---
>ChangeLog for winsup/testsuite:
>
>2005-05-27  Max Kaehn <slothman@electric-cloud.com>
>
>	* Makefile.in:  now tests cygload.
>	* cygload:  New directory.
>	* cygload/README:  New file.
>	* cygload/Makefile:  Ditto.
>	* cygload/cygload.h:  Ditto.
>	* cygload/cygload.cc:  Ditto.
>	* cygload/cygload.exp:  Ditto.

There were still some braces at the end of the line in cygload.h so I
changed those.  I also changed the ChangeLog entry "now tests cygload"
to "Test cygload".  See http://cygwin.com/contrib.html for some common
mistakes in ChangeLog entries.

So, I checked in the above and, after changing cygload.exp so that it
compiles cygload.cc rather than cygload.cpp, I found a more serious
error.  I've attached the cygload.log file.  It doesn't look pretty,
unfortunately.  You might notice the same thing if you configure your
Cygwin DLL with --enable-debugging, like I do.

Another problem is that since you have separated out the Makefile into
two separate invocations of $(RUNTEST) the error return from the Makefile
will not be set correctly.  To preserve previous operation, the makefile
should do all of the tests and then return with a status of zero if things
completed correctly or nonzero otherwise.

cgf

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: attachment; filename="cygload.log"
Content-Transfer-Encoding: quoted-printable
Content-length: 2957

Opening log files in .=0D
Test Run By cgf on Mon Jun  6 17:27:17 2005=0D
Native configuration is i686-pc-cygwin=0D
=0D
		=3D=3D=3D cygload tests =3D=3D=3D=0D
=0D
setting trap for SIGTERM to terminated=0D
setting trap for SIGINT to interrupted by user=0D
setting trap for SIGQUIT to interrupted by user=0D
setting trap for SIGSEGV to segmentation violation=0D
dirlist is /cygnus/src/uberbaum/winsup/testsuite/../../dejagnu/baseboards=0D
pushing config for build, name is norton=0D
dirlist is /cygnus/src/uberbaum/winsup/testsuite/../../dejagnu/baseboards=0D
pushing config for host, name is norton=0D
Schedule of variations:=0D
    unix=0D
=0D
target is unix=0D
Running target unix=0D
dirlist is /cygnus/src/uberbaum/winsup/testsuite/../../dejagnu/baseboards/n=
orton /cygnus/src/uberbaum/winsup/testsuite/../../dejagnu/baseboards=0D
Using /cygnus/src/uberbaum/winsup/testsuite/../../dejagnu/baseboards/unix.e=
xp as board description file for target.=0D
Using /cygnus/src/uberbaum/winsup/testsuite/../../dejagnu/config/unix.exp a=
s generic interface file for target.=0D
Using /cygnus/src/uberbaum/winsup/testsuite/config/default.exp as tool-and-=
target-specific interface file.=0D
pushing config for target, name is unix=0D
Running /cygnus/src/uberbaum/winsup/testsuite/cygload/cygload.exp ...=0D
running gcc -mno-cygwin /cygnus/src/uberbaum/winsup/testsuite/cygload/cyglo=
ad.cc -o mingw-cygload.exe -lstdc++ -Wl,-e,_cygloadCRTStartup@0=0D
=0D
running ./mingw-cygload.exe -cygwin j:/build/i686-pc-cygwin/winsup/cygwin/c=
ygwin0.dll > ./mingw-cygwin.log=0D
=0D
cygload: 1 {      3 [main] ? 1992 add_handle: void memory_init():257 - mult=
iple attempts to add handle cygheap->shared_h<0x774>=0D
  79191 [main] ? 1992 add_handle:  previously allocated by gned int shared_=
info::heap_chunk_size():257(_chunk_size()<0x774>) winpid 2600=0D
  86782 [main] ? 1992 add_handle: void user_shared_initialize(bool):185 - m=
ultiple attempts to add handle cygwin_user_h<0x768>=0D
  95160 [main] ? 1992 add_handle:  previously allocated by :185(=C2=B8=C2=
=A8q=11a=C2=BA=06<0x768>) winpid 2600=0D
 112620 [main] ? 1992 add_handle: void mtinfo_init():1176 - multiple attemp=
ts to add handle cygheap->mt_h<0x76C>=0D
 128555 [main] ? 1992 add_handle:  previously allocated by =11a=C2=83=C3=AC=
=1C=C2=BA=C2=98=04:1176(=C2=89D$=04=C2=B8=C3=95=C2=88=05a=C3=87=04$=C3=AF=
=C2=88=05a=C3=A8=C2=BC=C3=B9=C3=BA=C3=BF=C2=A1=C2=A0=C3=BF=11a=C2=83=C3=AC=
=08=C2=89=04$=C3=A8=C3=8C=C3=BD=C3=BF=C3=BF=C2=83=C3=84,=C3=83=C2=90=C2=90=
=C2=90=C2=90=C2=90=C2=90=C2=90=C2=90=C2=90=C2=90=C2=90=C2=90=C2=90=C2=90=C2=
=90=C2=90=C2=90=C2=90=C2=90=C2=90=C2=90=C2=90=C2=90=C2=90fhandler_dev_tape:=
:fhandler_dev_tape()<0x76C>) winpid 2600}=0D
FAIL: cygload (execute)=0D
testcase /cygnus/src/uberbaum/winsup/testsuite/cygload/cygload.exp complete=
d in 6 seconds=0D
=0D
		=3D=3D=3D cygload Summary =3D=3D=3D=0D
=0D
# of unexpected failures	1=0D
runtest completed at Mon Jun  6 17:27:23 2005=0D

--ikeVEW9yuYc//A+q--
