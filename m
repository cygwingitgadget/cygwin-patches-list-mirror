Return-Path: <cygwin-patches-return-3152-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4685 invoked by alias); 11 Nov 2002 16:00:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4658 invoked from network); 11 Nov 2002 16:00:56 -0000
Date: Mon, 11 Nov 2002 08:00:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: dll_index NO_COPY patch
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Mail-followup-to: Cygwin-Patches <cygwin-patches@cygwin.com>
Message-id: <20021111160614.GA1476@tishler.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_DhkvtI9yKV4f0un45jAqxw)"
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q4/txt/msg00103.txt.bz2


--Boundary_(ID_DhkvtI9yKV4f0un45jAqxw)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-length: 905

The attached patch fixes the problem described in the following thread:

    http://cygwin.com/ml/cygwin-developers/2002-11/msg00019.html

Given the following facts:

    1. During fork(), fork_copy() is run after
       dll_list::load_after_fork().
    2. The static dll_index variable in include/cygwin/cygwin_dll.h is
       not marked NO_COPY.
    3. The dll structure allocated by dll_list::alloc() is not
       guaranteed to be the same in the parent and child.

I believe that the following is the correct root cause analysis of the
problem:

    When #3 above occurs, fork_copy() overwrites the child's dll_index
    with the parent's value.  This causes dll_list::detach() to access
    unallocated memory which in turn causes the child to stackdump.

Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6

--Boundary_(ID_DhkvtI9yKV4f0un45jAqxw)
Content-type: text/plain; charset=us-ascii; NAME=cygwin_dll.h.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=cygwin_dll.h.diff
Content-length: 879

Index: include/cygwin/cygwin_dll.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/cygwin_dll.h,v
retrieving revision 1.8
diff -u -p -r1.8 cygwin_dll.h
--- include/cygwin/cygwin_dll.h	11 Sep 2001 20:01:01 -0000	1.8
+++ include/cygwin/cygwin_dll.h	11 Nov 2002 15:23:39 -0000
@@ -12,6 +12,7 @@ details. */
 #define __CYGWIN_CYGWIN_DLL_H__
 
 #include <windows.h>
+#include "winsup.h"
 
 #ifdef __cplusplus
 #define CDECL_BEGIN extern "C" {
@@ -39,7 +40,7 @@ static int __dllMain (int a, char **b, c
   return Entry (storedHandle, storedReason, storedPtr);		              \
 }									      \
 									      \
-static DWORD dll_index;							      \
+static NO_COPY DWORD dll_index;						      \
 									      \
 int WINAPI _cygwin_dll_entry (HINSTANCE h, DWORD reason, void *ptr)	      \
 {									      \

--Boundary_(ID_DhkvtI9yKV4f0un45jAqxw)
Content-type: text/plain; charset=us-ascii; NAME=cygwin_dll.h.ChangeLog
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=cygwin_dll.h.ChangeLog
Content-length: 132

Mon Nov 11 10:45:37 2002  <jason@tishler.net>

	* include/cygwin/cygwin_dll.h: Add #include "winsup.h".
	(dll_index): Make NO_COPY.

--Boundary_(ID_DhkvtI9yKV4f0un45jAqxw)--
