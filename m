Return-Path: <cygwin-patches-return-3401-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28920 invoked by alias); 15 Jan 2003 19:12:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28911 invoked from network); 15 Jan 2003 19:12:04 -0000
Date: Wed, 15 Jan 2003 19:12:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: NT 4.0 fixup_mmaps_after_fork() patch
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Mail-followup-to: Cygwin-Patches <cygwin-patches@cygwin.com>
Message-id: <20030115191918.GA1016@tishler.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_OqdHvN/NkrVnCiMCasBxnQ)"
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00050.txt.bz2


--Boundary_(ID_OqdHvN/NkrVnCiMCasBxnQ)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-length: 358

It appears that ReadProcessMemory() can fail with ERROR_NOACCESS under
NT 4.0.  See attached patch.

BTW, my mmap-test test case works under NT 4.0 without this patch.
However, vsFTPd does not.  Go figure!

Thanks,
Jason

-- 
PGP/GPG Key: http://www.tishler.net/jason/pubkey.asc or key servers
Fingerprint: 7A73 1405 7F2B E669 C19D  8784 1AFD E4CC ECF4 8EF6

--Boundary_(ID_OqdHvN/NkrVnCiMCasBxnQ)
Content-type: text/plain; charset=us-ascii; NAME=mmap.cc.diff
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=mmap.cc.diff
Content-length: 788

Index: mmap.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/mmap.cc,v
retrieving revision 1.68
diff -u -p -r1.68 mmap.cc
--- mmap.cc	15 Jan 2003 10:21:23 -0000	1.68
+++ mmap.cc	15 Jan 2003 18:51:30 -0000
@@ -986,9 +986,11 @@ fixup_mmaps_after_fork (HANDLE parent)
 					       getpagesize (), NULL))
 		      {
 			DWORD old_prot;
+			DWORD last_error = GetLastError ();
 
-			if (GetLastError () != ERROR_PARTIAL_COPY ||
-			    !wincap.virtual_protect_works_on_shared_pages ())
+			if (last_error != ERROR_PARTIAL_COPY
+			    && last_error != ERROR_NOACCESS
+			    || !wincap.virtual_protect_works_on_shared_pages ())
 			  {
 			    system_printf ("ReadProcessMemory failed for "
 			    		   "MAP_PRIVATE address %p, %E",

--Boundary_(ID_OqdHvN/NkrVnCiMCasBxnQ)
Content-type: text/plain; charset=us-ascii; NAME=mmap.cc.ChangeLog
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=mmap.cc.ChangeLog
Content-length: 248

2003-01-15  Jason Tishler  <jason@tishler.net>

	* mmap.cc (fixup_mmaps_after_fork): Add ERROR_NOACCESS to the list of
	ReadProcessMemory() error codes that trigger a retry with temporary
	PAGE_READONLY access.  Note that this can occur on NT 4.0.

--Boundary_(ID_OqdHvN/NkrVnCiMCasBxnQ)--
