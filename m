Return-Path: <cygwin-patches-return-2522-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 803 invoked by alias); 26 Jun 2002 17:10:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 778 invoked from network); 26 Jun 2002 17:10:28 -0000
Message-ID: <3D19F55E.3070800@netscape.net>
Date: Wed, 26 Jun 2002 10:22:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: A minor patch to Makefile.in
Content-Type: multipart/mixed;
 boundary="------------080602050304070000050402"
X-SW-Source: 2002-q2/txt/msg00505.txt.bz2


--------------080602050304070000050402
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 426

Hi all,

Due to the dependancy of gettext(libintl) and gettext, this pach is 
required to get a clean build with the new gettext/libiconv.  Otherwise, 
it will fail when trying to build dumper.exe because make doesn't link 
against libiconv.

Cheers,
Nicholas

ChangeLog:

2002-06-26  Nicholas S. Wourms <nwourms@netscape.net>

    * utils/Makefile.in: Fix so that dumper.exe will link against
    the new gettext properly.



--------------080602050304070000050402
Content-Type: text/plain;
 name="utils-Makefile.in.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="utils-Makefile.in.diff"
Content-length: 786

Index: utils/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
retrieving revision 1.37
diff -u -3 -p -u -p -r1.37 Makefile.in
--- utils/Makefile.in   13 May 2002 05:13:58 -0000  1.37
+++ utils/Makefile.in   26 Jun 2002 17:00:47 -0000
@@ -60,7 +60,7 @@ ALL_LDLIBS:=${patsubst $(w32api_lib)/lib
        ${filter-out $(libcygwin), $(ALL_DEP_LDLIBS)}}}}
 
 MINGW_LIB:=$(mingw_build)/libmingw32.a
-DUMPER_LIB:=${libbfd} ${libintl} -L$(bupdir1)/libiberty -liberty
+DUMPER_LIB:=${libbfd} ${libintl} -L$(bupdir1)/libiberty -liberty -liconv
 MINGW_LDLIBS:=$(ALL_LDLIBS) $(MINGW_LIB)
 MINGW_DEP_LDLIBS:=${ALL_DEP_LDLIBS} ${MINGW_LIB}
 ALL_LDFLAGS:=-B$(newlib_build)/libc/ -B$(newlib_build)/libm/ -B$(w32api_lib)/ \

--------------080602050304070000050402--
