Return-Path: <cygwin-patches-return-3473-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2188 invoked by alias); 1 Feb 2003 21:06:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2179 invoked from network); 1 Feb 2003 21:06:35 -0000
Date: Sat, 01 Feb 2003 21:06:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Create new files as sparse on NT. (fwd)
Message-ID: <20030201220607.M9442-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=-1.3 required=5.0
	tests=CARRIAGE_RETURNS,PATCH_CONTEXT_DIFF,SPAM_PHRASE_00_01
	version=2.43
X-Spam-Level: 
X-SW-Source: 2003-q1/txt/msg00122.txt.bz2


Hi,
this little patch makes Cygwin create new files as sparse on NT systems.
There is no error checking for DeviceIoCotrol() result because there should be
no harm if it should fail only that the file will not be sparse.

This patch has only been tested on my WinXP box by running P2P sharing
program BitTorrent.

Vaclav Haisman


2003-02-01  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
        * fhandler.cc (fhandler_base::open): Try to create new files as
        sparse on NT systems.

Index: cygwin/fhandler.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
retrieving revision 1.143
diff -c -r1.143 fhandler.cc
*** cygwin/fhandler.cc	20 Dec 2002 01:48:22 -0000	1.143
--- cygwin/fhandler.cc	1 Feb 2003 20:30:09 -0000
***************
*** 27,32 ****
--- 27,37 ----
  #include "pinfo.h"
  #include <assert.h>
  #include <limits.h>
+ #include <winioctl.h>
+
+ #define METHOD_BUFFERED 0
+ #define FSCTL_SET_SPARSE CTL_CODE(FILE_DEVICE_FILE_SYSTEM, 49, \
+   METHOD_BUFFERED, FILE_SPECIAL_ACCESS)

  static NO_COPY const int CHUNK_SIZE = 1024; /* Used for crlf conversions */

***************
*** 371,376 ****
--- 376,383 ----
    int shared;
    int creation_distribution;
    SECURITY_ATTRIBUTES sa = sec_none;
+   DWORD dw;
+   BOOL r;

    syscall_printf ("(%s, %p) query_open %d", get_win32_name (), flags, get_query_open ());

***************
*** 486,491 ****
--- 493,507 ----
        && !allow_ntsec && allow_ntea)
      set_file_attribute (has_acls (), get_win32_name (), mode);

+   /* Try to set newly created files as sparse on NT system. */
+   if (wincap.is_winnt () && (access & GENERIC_WRITE) == GENERIC_WRITE
+       && (flags & (O_CREAT | O_TRUNC)) && get_device () == FH_DISK)
+     {
+       r = DeviceIoControl(x, FSCTL_SET_SPARSE, NULL, 0, NULL, 0, &dw, NULL);
+       syscall_printf ("%d = DeviceIoControl(0x%x, FSCTL_SET_SPARSE, NULL, 0, "
+ 		      "NULL, 0, &dw, NULL)", r, x);
+     }
+
    set_io_handle (x);
    set_flags (flags, pc ? pc->binmode () : 0);
