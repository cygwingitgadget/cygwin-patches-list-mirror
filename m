Return-Path: <cygwin-patches-return-6120-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10528 invoked by alias); 21 Jun 2007 01:02:48 -0000
Received: (qmail 10510 invoked by uid 22791); 21 Jun 2007 01:02:47 -0000
X-Spam-Check-By: sourceware.org
Received: from sccrmhc12.comcast.net (HELO sccrmhc12.comcast.net) (204.127.200.82)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 21 Jun 2007 01:02:43 +0000
Received: from [192.168.0.103] (c-24-10-242-83.hsd1.ut.comcast.net[24.10.242.83])           by comcast.net (sccrmhc12) with ESMTP           id <2007062101024101200g81mge>; Thu, 21 Jun 2007 01:02:41 +0000
Message-ID: <4679CE8F.3090001@byu.net>
Date: Thu, 21 Jun 2007 01:02:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070509 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
To:  cygwin-developers@cygwin.com,  cygwin-patches@cygwin.com
Subject: Re: API compatibility documentation change
References: <20070605101558.GB6003@calimero.vinschen.de> <46792CC4.8090009@byu.net> <20070620145359.GH21181@calimero.vinschen.de>
In-Reply-To: <20070620145359.GH21181@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------070004010200090901010802"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00066.txt.bz2

This is a multi-part message in MIME format.
--------------070004010200090901010802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1366

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Corinna Vinschen on 6/20/2007 8:53 AM:
>> fmemopen - missing, but I'm working on it in newlib
>> open_memstream - missing, but I'm working on it in newlib
> 
> How are you going to implement that?  mmap?  shm_open?

Actually, more like I did for fopencookie.  fmemopen doesn't need to worry
about growth, and provided that realloc is intelligent, open_memstream
shouldn't be too slow, either.

> 
>> stpcpy - missing, but gnulib has an emulation
>> stpncpy - missing, but gnulib has an emulation
> 
> Shouldn't be too difficult.

Also, psignal and psiginfo seem pretty easy to implement.

Here's a first patch to the list of functions, by the way, along with
recent newlib additions:

2007-06-20  Eric Blake  <ebb9@byu.net>

	* cygwin.din: Export exp10, exp10f, pow10, pow10f, strcasestr,
	funopen, fopencookie.
	* include/cygwin/version.h: Bump API minor number.
	* posix.sgml: Minor improvements.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGec6O84KuGfSFAYARAk0JAJsFzlSdaZYrrNqdDwodD0mASZl/BACfcuRz
AnTEU2CR0LpH9Pb1rEvHUiE=
=C5fB
-----END PGP SIGNATURE-----

--------------070004010200090901010802
Content-Type: text/plain;
 name="cygwin.patch9"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch9"
Content-length: 5695

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.174
diff -u -p -r1.174 cygwin.din
--- cygwin.din	12 Jun 2007 15:24:46 -0000	1.174
+++ cygwin.din	21 Jun 2007 00:55:41 -0000
@@ -350,6 +350,8 @@ _exit SIGFE
 _Exit SIGFE
 exp NOSIGFE
 _exp = exp NOSIGFE
+exp10 NOSIGFE
+exp10f NOSIGFE
 exp2 NOSIGFE
 exp2f NOSIGFE
 expf NOSIGFE
@@ -469,6 +471,7 @@ _fnmatch = fnmatch NOSIGFE
 fopen SIGFE
 _fopen = fopen SIGFE
 _fopen64 = fopen64 SIGFE
+fopencookie SIGFE
 fork SIGFE
 _fork = fork SIGFE
 forkpty SIGFE
@@ -536,6 +539,7 @@ fts_set NOSIGFE
 fts_set_clientptr NOSIGFE
 ftw SIGFE
 funlockfile SIGFE
+funopen SIGFE
 futimes SIGFE
 fwrite SIGFE
 _fwrite = fwrite SIGFE
@@ -1012,6 +1016,8 @@ posix_regexec SIGFE
 posix_regfree SIGFE
 pow NOSIGFE
 _pow = pow NOSIGFE
+pow10 NOSIGFE
+pow10f NOSIGFE
 powf NOSIGFE
 _powf = powf NOSIGFE
 pread SIGFE
@@ -1417,6 +1423,7 @@ _statfs = statfs SIGFE
 statvfs SIGFE
 strcasecmp NOSIGFE
 _strcasecmp = strcasecmp NOSIGFE
+strcasestr NOSIGFE
 strcat NOSIGFE
 _strcat = strcat NOSIGFE
 strchr NOSIGFE
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.6
diff -u -p -r1.6 posix.sgml
--- posix.sgml	12 Jun 2007 15:24:46 -0000	1.6
+++ posix.sgml	21 Jun 2007 00:55:42 -0000
@@ -171,6 +171,7 @@ also ISO/IEC 9945:2003 and IEEE Std 1003
     fopen
     fork
     fpathconf
+    fpclassify			(see chapter "Implementation Notes")
     fprintf
     fputc
     fputs
@@ -296,21 +297,21 @@ also ISO/IEC 9945:2003 and IEEE Std 1003
     isblank
     iscntrl
     isdigit
-    isfinite
+    isfinite			(see chapter "Implementation Notes")
     isgraph
-    isgreater
-    isgreaterequal
-    isinf
+    isgreater			(see chapter "Implementation Notes")
+    isgreaterequal		(see chapter "Implementation Notes")
+    isinf			(see chapter "Implementation Notes")
     isless
-    islessequal
-    islessgreater
+    islessequal			(see chapter "Implementation Notes")
+    islessgreater		(see chapter "Implementation Notes")
     islower
-    isnan
-    isnormal
+    isnan			(see chapter "Implementation Notes")
+    isnormal			(see chapter "Implementation Notes")
     isprint
     ispunct
     isspace
-    isunordered
+    isunordered			(see chapter "Implementation Notes")
     isupper
     iswalnum
     iswalpha
@@ -597,6 +598,7 @@ also ISO/IEC 9945:2003 and IEEE Std 1003
     send
     sendmsg
     sendto
+    setbuf
     setegid
     setenv
     seteuid
@@ -641,7 +643,7 @@ also ISO/IEC 9945:2003 and IEEE Std 1003
     sigismember
     siglongjmp
     signal
-    signbit
+    signbit			(see chapter "Implementation Notes")
     signgam
     sigpause
     sigpending
@@ -764,6 +766,7 @@ also ISO/IEC 9945:2003 and IEEE Std 1003
     utime
     utimes
     va_arg
+    va_copy
     va_end
     va_start
     vfork			(see chapter "Implementation Notes")
@@ -842,6 +845,7 @@ also ISO/IEC 9945:2003 and IEEE Std 1003
     fts_read
     fts_set
     fts_set_clientptr
+    funopen
     gamma
     gamma_r
     gammaf
@@ -895,6 +899,7 @@ also ISO/IEC 9945:2003 and IEEE Std 1003
     settimeofday
     setusershell
     statfs
+    strcasestr
     strlcat
     strlcpy
     strsep
@@ -943,13 +948,18 @@ also ISO/IEC 9945:2003 and IEEE Std 1003
     envz_merge
     envz_remove
     envz_strip
+    exp10
+    exp10f
     fcloseall
     fcloseall_r
+    fopencookie
     getline
     getopt_long
     getopt_long_only
     memmem
     mempcpy
+    pow10
+    pow10f
     strndup
     strnlen
     tdestroy
@@ -1004,7 +1014,6 @@ also ISO/IEC 9945:2003 and IEEE Std 1003
     pthread_suspend		(XPG2)
     pututline			(XPG2)
     putw			(SVID)
-    setbuf			(C89, C99)
     setutent			(XPG2)
     sys_errlist			(BSD)
     sys_nerr			(BSD)
@@ -1223,7 +1232,6 @@ also ISO/IEC 9945:2003 and IEEE Std 1003
     timer_getoverrun
     truncl
     ulimit
-    va_copy
     vfwprintf
     vfwscanf
     vswprintf
@@ -1262,6 +1270,14 @@ Windows however.</para>
 and <function>clock_setres</function> only support CLOCK_REALTIME for
 now.</para>
 
+<para><function>fpclassify</function>, <function>isfinite</function>,
+<function>isgreater</function>, <function>isgreaterequal</function>,
+<function>isinf</function>, <function>isless</function>,
+<function>islessequal</function>, <function>islessgreater</function>,
+<function>isnan</function>, <function>isnormal</function>,
+<function>isunordered</function>, and <function>signbit</function>
+only support float and double arguments, not long double arguments.</para>
+
 <para><function>getitimer</function> and <function>setitimer</function>
 only support ITIMER_REAL for now.</para>
 
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.244
diff -u -p -r1.244 version.h
--- include/cygwin/version.h	12 Jun 2007 15:24:46 -0000	1.244
+++ include/cygwin/version.h	21 Jun 2007 00:55:42 -0000
@@ -310,12 +310,14 @@ details. */
       168: Export asnprintf, dprintf, _Exit, vasnprintf, vdprintf.
       169: Export confstr.
       170: Export insque, remque.
+      171: Export exp10, exp10f, pow10, pow10f, strcasestr, funopen,
+           fopencookie.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 170
+#define CYGWIN_VERSION_API_MINOR 171
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--------------070004010200090901010802--
