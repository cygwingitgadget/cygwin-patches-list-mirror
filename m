Return-Path: <cygwin-patches-return-5540-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23058 invoked by alias); 10 Jun 2005 17:11:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22913 invoked by uid 22791); 10 Jun 2005 17:11:33 -0000
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 10 Jun 2005 17:11:33 +0000
Received: from mace ([192.168.1.25]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 10 Jun 2005 18:11:30 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [Patch] Testing loads of cygwin1.dll from MinGW and MSVC, take3
Date: Fri, 10 Jun 2005 17:11:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <1118256244.5031.2661.camel@fulgurite>
Message-ID: <SERRANOuabjKoMFYsDS000003d2@SERRANO.CAM.ARTIMI.COM>
X-SW-Source: 2005-q2/txt/msg00136.txt.bz2

----Original Message----
>From: Max Kaehn
>Sent: 08 June 2005 19:44

> On Mon, 2005-06-06 at 16:51, Christopher Faylor wrote:
>> Actually neither is right.  The tests are supposed to run to
>> completion, not stop on a failure.
> 
> My first cut was this, but it could have led to a tedious
> accumulation of if/then/else/if/then/else:

> So I wrote a more general script, discovered that cygwin uses ash  
> instead of bash for /bin/sh, and rewrote the more general script so
> ash could handle it.  Since ash doesn't seem to support arrays,
> I wound up using "eval", and was thoroughly perplexed at the way
> that the first "eval" seems to get thrown away.

  Look, if it's getting complicated and tricky, that argues for a bit of a
rethink / redesign, doesn't it?

  So maybe this would be further support for the idea of not making cygload
a separate tool?  runtest will already automatically recurse into every
subdir in winsup.api, and surely all you'd need to do would be patch
src/winsup/testsuite/winsup.api/winsup.exp to recognize the pattern
'cygload' in the path of a source file and compile and run it using slightly
different spawn commands.  Something vaguely along these lines:

Index: winsup.exp
===================================================================
RCS file: /cvs/src/src/winsup/testsuite/winsup.api/winsup.exp,v
retrieving revision 1.14
diff -p -u -r1.14 winsup.exp
--- winsup.exp  12 Mar 2003 06:28:27 -0000      1.14
+++ winsup.exp  10 Jun 2005 17:07:50 -0000
@@ -48,7 +48,13 @@ foreach src [glob -nocomplain $srcdir/$s
        clear_xfail
     }

-    ws_spawn "$CC -nodefaultlibs -nostdinc -mwin32 $CFLAGS $src
$add_includes $add_libs $runtime_root/binmode.o -lgcc
$runtime_root/libcygwin0.a -lkernel32 -luser32 -o $base.exe"
+    regsub "^.*cygload.*$" $src "YES" is_cygload
+    if { $is_cygload == "YES" } {
+        ws_spawn "gcc -mno-cygwin $src -o $base.exe -lstdc++
-Wl,-e,_cygloadCRTStartup@0"
+    } else {
+      ws_spawn "$CC -nodefaultlibs -nostdinc -mwin32 $CFLAGS $src
$add_includes $add_libs $runtime_root/binmode.o -lgcc
$runtime_root/libcygwin0.a -lkernel32 -luser32 -o $base.exe"
+    }
+
     if { $rv != "" } {
        verbose -log "$rv"
        fail "$testcase (compile)"
@@ -58,7 +64,12 @@ foreach src [glob -nocomplain $srcdir/$s
         } else {
            set redirect_output /dev/null
         }
-        ws_spawn "$rootme/cygrun ./$base.exe > $redirect_output"
+        if { $is_cygload == "YES" } {
+           set windows_runtime_root [exec cygpath -m $runtime_root]
+           ws_spawn "./$base.exe -cygwin $windows_runtime_root/cygwin0.dll
> $redirect_output"
+        } else {
+          ws_spawn "$rootme/cygrun ./$base.exe > $redirect_output"
+        }
         if { $rv != "" } {
            verbose -log "$testcase: $rv"
            fail "$testcase (execute)"

although this isn't quite correct or consistent, it serves to illustrate the
design I'd recommend.

  Or is there something I haven't grasped that means cygload has to be
treated as a separate tool?


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
