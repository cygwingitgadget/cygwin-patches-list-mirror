Return-Path: <cygwin-patches-return-2873-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27371 invoked by alias); 27 Aug 2002 17:51:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27354 invoked from network); 27 Aug 2002 17:51:48 -0000
Message-ID: <3D6BBC26.2060408@netscape.net>
Date: Tue, 27 Aug 2002 10:51:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@sources.redhat.com
Subject: [PATCH]: export getc_unlocked, getchar_unlocked, putc_unlocked, putchar_unlocked
Content-Type: multipart/mixed;
 boundary="------------080605070207020709000100"
X-SW-Source: 2002-q3/txt/msg00321.txt.bz2


--------------080605070207020709000100
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 648

[stdio with explicit client locking]

These are useful for programs which desire the non-threadsafe 
implementation of the respective functions minus the unlocked suffix.  
These functions are defined under the SUSv2:

http://www.opennc.org/onlinepubs/7908799/xsh/getc_unlocked.html

Since May, newlib has offered these functions for use.  They always get 
picked up by the more recent alphas of diffutils (which I am recompiling 
for the nth time).  Well since they are part of the official spec I 
figured why not export them so they can be of some use?  Attached is a 
diff which exports these newlib symbols & updates the docs to reflect this.

--------------080605070207020709000100
Content-Type: text/plain;
 name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ChangeLog.txt"
Content-length: 206

2002-08-27  Nicholas Wourms  <nwourms@netscape.net>

    * cygwin.din: Export getc_unlocked, getchar_unlocked,
    putc_unlocked, putchar_unlocked functions.
    * include/cygwin/version.h: Bump api minor.

--------------080605070207020709000100
Content-Type: text/plain;
 name="get-put-exports.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="get-put-exports.diff"
Content-length: 1699

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.37.2.14
diff -u -3 -p -r1.37.2.14 cygwin.din
--- cygwin.din  18 Aug 2002 12:09:27 -0000  1.37.2.14
+++ cygwin.din  27 Aug 2002 17:29:46 -0000
@@ -346,8 +382,12 @@ gcvtf
 _gcvtf = gcvtf
 getc
 _getc = getc
+getc_unlocked
+_getc_unlocked = getc_unlocked
 getchar
 _getchar = getchar
+getchar_unlocked
+_getchar_unlocked = getchar_unlocked
 getcwd
 _getcwd = getcwd
 getdtablesize
@@ -609,8 +649,12 @@ printf
 _printf = printf
 putc
 _putc = putc
+putc_unlocked
+_putc_unlocked = putc_unlocked
 putchar
 _putchar = putchar
+putchar_unlocked
+_putchar_unlocked = putchar_unlocked
 puts
 _puts = puts
 putw
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.48.2.12
diff -u -3 -p -r1.48.2.12 version.h
--- include/cygwin/version.h    18 Aug 2002 12:09:28 -0000  1.48.2.12
+++ include/cygwin/version.h    27 Aug 2002 17:29:46 -0000
@@ -158,12 +158,13 @@ details. */
        58: Export memalign, valloc, malloc_trim, malloc_usable_size, mallopt,
            malloc_stats
        59: getsid
+       60: Export getc_unlocked, getchar_unlocked, putc_unlocked, putchar_unlocked
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 59
+#define CYGWIN_VERSION_API_MINOR 60
 
      /* There is also a compatibity version number associated with the
    shared memory regions.  It is incremented when incompatible

--------------080605070207020709000100
Content-Type: text/plain;
 name="get-put-calls.texi.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="get-put-calls.texi.diff"
Content-length: 1227

Index: calls.texinfo
===================================================================
RCS file: /cvs/src/src/winsup/doc/calls.texinfo,v
retrieving revision 1.5
diff -u -3 -p -r1.5 calls.texinfo
--- calls.texinfo   24 Jul 2002 07:38:18 -0000  1.5
+++ calls.texinfo   27 Aug 2002 17:33:51 -0000
@@ -365,18 +365,18 @@ net release.)}
 @item funlockfile: P96 8.2.6.1 -- unimplemented
 @item fwrite: C 4.9.8.2, P 8.2.3.6
 @item getc: C 4.9.7.5, P 8.2.3.5
-@item getc_unlocked: P96 8.2.7.1 -- unimplemented
+@item getc_unlocked: P96 8.2.7.1
 @item getchar: C 4.9.7.6, P 8.2.3.5
-@item getchar_unlocked: P96 8.2.7.1 -- unimplemented
+@item getchar_unlocked: P96 8.2.7.1
 @item gets: C 4.9.7.7, P 8.2.3.5
 @item gmtime_r: P96 8.3.6.1 -- unimplemented
 @item localtime_r: P96 8.3.7.1 -- unimplemented
 @item perror: C 4.9.10.4, P 8.2.3.8
 @item printf: C 4.9.6.3, P 8.2.3.6
 @item putc: C 4.9.7.8, P 8.2.3.6
-@item putc_unlocked: P96 8.2.7.1 -- unimplemented
+@item putc_unlocked: P96 8.2.7.1
 @item putchar: C 4.9.7.9, P 8.2.3.6
-@item putchar_unlocked: P96 8.2.7.1 -- unimplemented
+@item putchar_unlocked: P96 8.2.7.1
 @item puts: C 4.9.7.10, P 8.2.3.6
 @item rand_r: P96 8.3.8.1 -- unimplemented
 @item remove: C 4.9.4.1, P 8.2.4

--------------080605070207020709000100--
