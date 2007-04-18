Return-Path: <cygwin-patches-return-6074-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3225 invoked by alias); 18 Apr 2007 17:58:59 -0000
Received: (qmail 3212 invoked by uid 22791); 18 Apr 2007 17:58:57 -0000
X-Spam-Check-By: sourceware.org
Received: from out4.smtp.messagingengine.com (HELO out4.smtp.messagingengine.com) (66.111.4.28)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 18 Apr 2007 18:58:53 +0100
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by out1.messagingengine.com (Postfix) with ESMTP id 88621217D3E 	for <cygwin-patches@cygwin.com>; Wed, 18 Apr 2007 13:59:04 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute2.internal (MEProxy); Wed, 18 Apr 2007 13:58:52 -0400
Received: from [127.0.0.1] (user-0c6suln.cable.mindspring.com [24.110.122.183]) 	by mail.messagingengine.com (Postfix) with ESMTP id AAEDE1B087; 	Wed, 18 Apr 2007 13:58:51 -0400 (EDT)
Message-ID: <46265C39.90501@cwilson.fastmail.fm>
Date: Wed, 18 Apr 2007 17:58:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [patch] support -gdwarf-2 when creating cygwin1.dbg
References: <462612A9.20E19FEB@dessent.net> <20070418125857.GA4589@trixie.casa.cgf.cx> <20070418130732.GK5799@calimero.vinschen.de> <46261A87.CDE8726C@dessent.net> <20070418132315.GA5262@trixie.casa.cgf.cx> <20070418134252.GL5799@calimero.vinschen.de> <462630CA.30974919@dessent.net>
In-Reply-To: <462630CA.30974919@dessent.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00020.txt.bz2

Chiming in with a general comment: dwarf2 exceptions are different than 
dwarf2 debug info.  However, obviously both varieties of "dwarf2" can 
impact gdb.

I finished a build last weekend of gcc trunk with

   (1) Steve Ellcey's recently-accepted "pre switch to modern libtool" patch
   (2) Steve Ellcey's "actually use modern libtool"
   (3) a forward port of Danny Smith's "[PATCH] Dwarf 2 Unwind frames 
for mingw32/cygwin" 
http://gcc.gnu.org/ml/gcc-patches/2006-12/msg00133.html to current trunk
   (4) a minor patch to "convert" libgcc to toplevel for cygwin target 
(#3 from Dec 2006 doesn't work without this, because of the 
toplevel-libgcc changes from Jan 2007) 
http://gcc.gnu.org/wiki/Top-Level_Libgcc_Migration

This had reasonable success [*] (after the testsuite finally finished, 
60-odd hours later...)  Note that Danny's changes modify the comment 
block above the DWARF2_UNWIND_INFO macro setting from:

-/* DWARF2 Unwinding doesn't work with exception handling yet.  To make
-   it work, we need to build a libgcc_s.dll, and dcrt0.o should be
-   changed to call __register_frame_info/__deregister_frame_info.  */
-#define DWARF2_UNWIND_INFO 0
+/* DWARF2 Unwinding is default exception handling model.  Configure
+   with -enable-sjlj-exceptions to revert to old setjump/longjump
+   model.  */
+#define DWARF2_UNWIND_INFO 1

There does not seem to be any requirement, with Danny's patch, for 
libgcc to be built shared.  However, Danny's patch only allows us to use 
dwarf2 exception unwinding in place of sjlj, in gcc trunk.

gcc 4.x+ on cygming, at present, does NOT support catching exceptions 
thrown across DLL boundaries for EITHER sjlj or dwarf2, regardless of 
whether Danny's patch above is used.  THAT piece is what requires the 
3.4.x hack, which as Brian mentioned is not yet/nor will be ported to 
4.x.  Instead, according to Danny, proper "catch an exception thrown 
across DLL bounds" in gcc-4.x is the driving factor requiring a shared 
libgcc (and shared libsupc++/libstdc++) in the absence of a forward port 
of the 3.4.x hack.

But not even that will solve the "catch a dwarf2 exception thrown from a 
Win32 callback" problem (aka the 'foreign frame' problem).  THAT issue 
is a possible Summer of Code 2007 project: 
http://gcc.gnu.org/wiki/WindowsGCCImprovements

I've got some stuff in development to build libgcc shared on cygwin -- 
libgcc is built without libtool (old OR new).  We can tackle 
libsupc++/libstdc++ after the second of Steve Ellcey's patches goes in.

--
Chuck



=================================================================

[*] selected parts of the test log:
                 === gcc Summary ===

# of expected passes            45512
# of unexpected failures        33
# of unexpected successes       1
# of expected failures          115
# of untested testcases         35
# of unsupported tests          343
                 === g++ Summary ===

# of expected passes            14719
# of unexpected failures        28
# of unexpected successes       3
# of expected failures          79
# of unsupported tests          159
                 === libstdc++ Summary ===

# of expected passes            4856
# of unexpected failures        879
# of unexpected successes       2
# of expected failures          39
# of unsupported tests          466

(most of the libstdc++ failures were locale-related, and should probably 
be in the unsupported category...)
