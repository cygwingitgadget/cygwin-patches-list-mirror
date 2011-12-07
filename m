Return-Path: <cygwin-patches-return-7556-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15648 invoked by alias); 7 Dec 2011 22:36:28 -0000
Received: (qmail 15507 invoked by uid 22791); 7 Dec 2011 22:36:25 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,TW_CX,TW_JL,TW_YM
X-Spam-Check-By: sourceware.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 07 Dec 2011 22:36:11 +0000
Received: from pool-173-76-42-41.bstnma.fios.verizon.net ([173.76.42.41] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1RYQ5z-000ALe-0Y	for cygwin-patches@cygwin.com; Wed, 07 Dec 2011 22:36:11 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 4F94513C0D3	for <cygwin-patches@cygwin.com>; Wed,  7 Dec 2011 17:36:10 -0500 (EST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/2jJrSjcSAVG7pPMs3V2EH
Date: Wed, 07 Dec 2011 22:36:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Problem with: Re: [PATCH] Allow usage of union wait for wait() functions and macros
Message-ID: <20111207223609.GA24624@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E8C3828.4010009@t-online.de> <20111005132620.GA8422@ednor.casa.cgf.cx> <4E8CC986.3080001@t-online.de> <20111006023729.GM1955@ednor.casa.cgf.cx> <4E8D8B0D.1060805@t-online.de> <20111006130357.GA20063@ednor.casa.cgf.cx> <4E8DD373.2070008@t-online.de> <20111006171749.GC22971@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111006171749.GC22971@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q4/txt/msg00046.txt.bz2

On Thu, Oct 06, 2011 at 01:17:49PM -0400, Christopher Faylor wrote:
>On Thu, Oct 06, 2011 at 06:12:35PM +0200, Christian Franke wrote:
>>Christopher Faylor wrote:
>>> On Thu, Oct 06, 2011 at 01:03:41PM +0200, Christian Franke wrote:
>>>> ...
>>>> OK, __INSIDE_CYGWIN__ is not needed here in practice (but possibly in
>>>> theory :-)
>>> I would rather see as little __INSIDE_CYGWIN__ as possible
>>> in external headers.
>>
>>OK, removed and Cygwin compilation tested.
>>
>>>> Would the patch with __INSIDE_CYGWIN__ removed be GTG?
>>> Yes.
>>
>>Thanks - patch committed.
>
>Thanks a lot for the patch.

I guess this is why there was a __INSIDE_CYGWIN__ test.

Christian, could you submit a new patch to rectify this problem?

cgf

----- Forwarded message from Christian Joensson <christian.joensson> -----

From: Christian Joensson
To: cygwin, GCC Development
Subject: Failure to bootstrap current gcc trunk on cygwin (20111207 snapshot): conflicting declarations in cygwin's /usr/include/sys/wait.h
Date: Wed, 7 Dec 2011 20:14:36 +0100

I am trying to build gcc trunk on cygwin (with the snapshot of
20111207) and get this:

/usr/local/src/trunk/objdir.withada/./prev-gcc/g++
-B/usr/local/src/trunk/objdir.withada/./prev-gcc/
-B/usr/i686-pc-cygwin/bin/ -nostdinc++
-B/usr/local/src/trunk/objdir.withada/prev-i686-pc-cygwin/libstdc++-v3/src/.libs
 -B/usr/local/src/trunk/objdir.withada/prev-i686-pc-cygwin/libstdc++-v3/libsupc++/.libs
 -I/usr/local/src/trunk/objdir.withada/prev-i686-pc-cygwin/libstdc++-v3/include/i686-pc-cygwin
 -I/usr/local/src/trunk/objdir.withada/prev-i686-pc-cygwin/libstdc++-v3/include
 -I/usr/local/src/trunk/gcc/libstdc++-v3/libsupc++
-L/usr/local/src/trunk/objdir.withada/prev-i686-pc-cygwin/libstdc++-v3/src/.libs
 -L/usr/local/src/trunk/objdir.withada/prev-i686-pc-cygwin/libstdc++-v3/libsupc++/.libs
-c   -g -O2 -gtoggle -DIN_GCC    -fno-exceptions -fno-rtti -W -Wall
-Wno-narrowing -Wwrite-strings -Wcast-qual  -Wmissing-format-attribute
-Wno-long-long -Wno-variadic-macros -Wno-overlength-strings -Werror
-fno-common -Wno-error -DHAVE_CONFIG_H -I. -Iada
-I/usr/local/src/trunk/gcc/gcc -I/usr/local/src/trunk/gcc/gcc/ada
-I/usr/local/src/trunk/gcc/gcc/../include
-I/usr/local/src/trunk/gcc/gcc/../libcpp/include -I/usr/include
-I/usr/include  -I/usr/local/src/trunk/gcc/gcc/../libdecnumber
-I/usr/local/src/trunk/gcc/gcc/../libdecnumber/bid -I../libdecnumber
  /usr/local/src/trunk/gcc/gcc/ada/adaint.c -o ada/adaint.o
In file included from /usr/local/src/trunk/gcc/gcc/system.h:346:0,
                 from /usr/local/src/trunk/gcc/gcc/ada/adaint.c:107:
/usr/include/sys/wait.h: In function 'int __wait_status_to_int(const wait&)':
/usr/include/sys/wait.h:77:61: error: declaration of C function 'int
__wait_status_to_int(const wait&)' conflicts with
/usr/include/sys/wait.h:75:12: error: previous declaration 'int
__wait_status_to_int(int)' here
/usr/include/sys/wait.h: In function 'pid_t wait(wait*)':
/usr/include/sys/wait.h:81:40: error: declaration of C function 'pid_t
wait(wait*)' conflicts with
/usr/include/sys/wait.h:37:7: error: previous declaration 'pid_t
wait(__wait_status_ptr_t)' here
/usr/include/sys/wait.h: In function 'pid_t waitpid(pid_t, wait*, int)':
/usr/include/sys/wait.h:83:71: error: declaration of C function 'pid_t
waitpid(pid_t, wait*, int)' conflicts with
/usr/include/sys/wait.h:38:7: error: previous declaration 'pid_t
waitpid(pid_t, __wait_status_ptr_t, int)' here
/usr/include/sys/wait.h: In function 'pid_t wait3(wait*, int, rusage*)':
/usr/include/sys/wait.h:85:81: error: declaration of C function 'pid_t
wait3(wait*, int, rusage*)' conflicts with
/usr/include/sys/wait.h:39:7: error: previous declaration 'pid_t
wait3(__wait_status_ptr_t, int, rusage*)' here
/usr/include/sys/wait.h: In function 'pid_t wait4(pid_t, wait*, int, rusage*)':
/usr/include/sys/wait.h:87:94: error: declaration of C function 'pid_t
wait4(pid_t, wait*, int, rusage*)' conflicts with
/usr/include/sys/wait.h:40:7: error: previous declaration 'pid_t
wait4(pid_t, __wait_status_ptr_t, int, rusage*)' here
Makefile:1054: recipe for target `ada/adaint.o' failed
make[3]: *** [ada/adaint.o] Error 1
make[3]: Leaving directory `/usr/local/src/trunk/objdir.withada/gcc'
Makefile:4140: recipe for target `all-stage2-gcc' failed
make[2]: *** [all-stage2-gcc] Error 2
make[2]: Leaving directory `/usr/local/src/trunk/objdir.withada'
Makefile:18046: recipe for target `stage2-bubble' failed
make[1]: *** [stage2-bubble] Error 2
make[1]: Leaving directory `/usr/local/src/trunk/objdir.withada'
Makefile:898: recipe for target `all' failed
make: *** [all] Error 2

$ /usr/local/src/trunk/objdir.withada/prev-gcc/xgcc.exe -v
Using built-in specs.
COLLECT_GCC=/usr/local/src/trunk/objdir.withada/prev-gcc/xgcc
Target: i686-pc-cygwin
Configured with: /usr/local/src/trunk/gcc/configure --prefix=/usr
--exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin
--localstatedir=/var --sysconfdir=/etc --datarootdir=/usr/share
--docdir=/usr/share/doc/gcc4 -C --datadir=/usr/share
--infodir=/usr/share/info --mandir=/usr/share/man -v --with-gmp=/usr
--with-mpfr=/usr --enable-bootstrap
--enable-version-specific-runtime-libs --libexecdir=/usr/lib
--enable-static --enable-shared --enable-shared-libgcc
--disable-__cxa_atexit --with-gnu-ld --with-gnu-as --with-dwarf2
--disable-sjlj-exceptions --enable-graphite --enable-lto
--disable-symvers --program-suffix=-4 --enable-libgomp --enable-libssp
--enable-threads=posix --with-arch=i686 --with-tune=generic
--enable-libada CC=gcc-4 CXX=g++-4 CC_FOR_TARGET=gcc-4
CXX_FOR_TARGET=g++-4 GNATMAKE_FOR_TARGET=gnatmake
GNATBIND_FOR_TARGET=gnatbind
--enablelanguages=c,ada,c++,fortran,lto,objc,objc++
Thread model: posix
gcc version 4.7.0 20111207 (experimental) [trunk revision 182082] (GCC)

$ uname -a
CYGWIN_NT-6.1-WOW64 LI004043 1.7.10s(0.255/5/3) 20111207 03:08:14 i686 Cygwin

Does this symptom ring a bell for anyone?

-- 
Cheers,

/ChJ

--
Problem reports:       http://cygwin.com/problems.html
FAQ:                   http://cygwin.com/faq/
Documentation:         http://cygwin.com/docs.html
Unsubscribe info:      http://cygwin.com/ml/#unsubscribe-simple



----- End forwarded message -----
