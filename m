Return-Path: <cygwin-patches-return-2713-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9021 invoked by alias); 25 Jul 2002 15:29:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9007 invoked from network); 25 Jul 2002 15:29:35 -0000
Message-ID: <3D401950.1070803@netscape.net>
Date: Thu, 25 Jul 2002 08:29:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 'Cygwin-Patches' <cygwin-patches@sources.redhat.com>
Subject: qt patch for winnt.h
Content-Type: multipart/mixed;
 boundary="------------090009070302040003070903"
X-SW-Source: 2002-q3/txt/msg00161.txt.bz2


--------------090009070302040003070903
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 856

Hi,

As you may or may not know, I'm going to be providing the QT-2.3.1 
package for the main cygwin distribution.  However, an annoying 
"feature" of QT is that one of its typdefs conflicts with a typedef in 
winnt.h [typedef void *HANDLE].  However, QT  requires [typedef unsigned 
int HANDLE] and refuses to compile with the wrong typedef.  Ralf has 
tried everything over at the kde-cygwin project to get around this 
without tampering with the system headers.  In the end, however, we 
discovered that it would require a massive overhaul of qt-2 to do this. 
 Therefore we think it would be much more simple to just add a gaurded 
#ifndef to winnt.h.  That way it will continue to work as it always has 
-- unless you define QT_CYGWIN -- in which case the typedef for qt would 
be used instead.  Attached is the patch and ChangeLog.

Cheers,
Nicholas

--------------090009070302040003070903
Content-Type: text/plain;
 name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ChangeLog.txt"
Content-length: 105

2002-07-25  Nicholas Wourms  <nwourms@netscape.net>

    * winnt.h (HANDLE): Add guard for compiling qt.

--------------090009070302040003070903
Content-Type: text/plain;
 name="qt-cygwin.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="qt-cygwin.diff"
Content-length: 665

Index: winnt.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/winnt.h,v
retrieving revision 1.52
diff -u -3 -p -u -p -r1.52 winnt.h
--- winnt.h 17 Jul 2002 03:37:45 -0000  1.52
+++ winnt.h 25 Jul 2002 15:09:11 -0000
@@ -108,7 +108,11 @@ typedef const TCHAR *LPCTSTR;
 #define TEXT(q) __TEXT(q)    
 typedef SHORT *PSHORT;
 typedef LONG *PLONG;
+#ifndef QT_CYGWIN  /* To allow qt to compile under Cygwin */
 typedef void *HANDLE;
+#else
+typedef unsigned int HANDLE;
+#endif /* QT_CYGWIN */
 typedef HANDLE *PHANDLE,*LPHANDLE;
 #ifdef STRICT
 #define DECLARE_HANDLE(n) typedef struct n##__{int i;}*n

--------------090009070302040003070903--
