Return-Path: <cygwin-patches-return-1695-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 6516 invoked by alias); 14 Jan 2002 23:00:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6462 invoked from network); 14 Jan 2002 23:00:34 -0000
Message-ID: <20020114230034.36669.qmail@web14504.mail.yahoo.com>
Date: Mon, 14 Jan 2002 15:00:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: Re: src/winsup/w32api ChangeLog include/winnt.h
To: cygwin-patches <cygwin-patches@cygwin.com>, corinna@cygwin.com
In-Reply-To: <20020114201534.26518.qmail@sources.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q1/txt/msg00052.txt.bz2

 --- corinna@cygwin.com wrote: > CVSROOT:	/cvs/src
> Module name:	src
> Changes by:	corinna@sources.redhat.com	2002-01-14 12:15:34
> 
> Modified files:
> 	winsup/w32api  : ChangeLog 
> 	winsup/w32api/include: winnt.h 
> 
> Log message:
> 	* include/winnt.h: Add INVALID_FILE_ATTRIBUTES.
> 

Although, I agree that DWORD(-1) is what GetFileAttributes returns on
error, I can't find any documentation for this define.   Can you help?
If it is "non-MSDN" w32api define, it should be commented as such.


In looking for doc's however, I find error in FILE_ATTRIBUTE_* which I will
apply to mingw's SF CVS.

--- w32api/ChangeLog	2002/01/11 23:33:22	1.80
+++ w32api/ChangeLog	2002/01/14 22:52:19
@@ -1,3 +1,9 @@
+2002-01-14  Danny Smith  <dannysmith@users.sourceforge.net>
+
+	* include/winnt.h (FILE_ATTRIBUTE_ENCRYPTED): Correct constant.
+	(FILE_ATTRIBUTE_DEVICE): Add define.
+
+
 2002-01-11  Danny Smith  <dannysmith@users.sourceforge.net>
 
 	* ChangeLog: correct date in last entry. 
Index: w32api/include/winnt.h
===================================================================
RCS file: /cvsroot/mingw/w32api/include/winnt.h,v
retrieving revision 1.18
diff -u -p -r1.18 winnt.h
--- w32api/include/winnt.h	2002/01/04 03:08:49	1.18
+++ w32api/include/winnt.h	2002/01/14 22:52:25
@@ -211,7 +211,7 @@ typedef BYTE BOOLEAN,*PBOOLEAN;
 #define FILE_ATTRIBUTE_SYSTEM	4
 #define FILE_ATTRIBUTE_DIRECTORY	16
 #define FILE_ATTRIBUTE_ARCHIVE	32
-#define FILE_ATTRIBUTE_ENCRYPTED	64
+#define FILE_ATTRIBUTE_DEVICE	64
 #define FILE_ATTRIBUTE_NORMAL	128
 #define FILE_ATTRIBUTE_TEMPORARY	256
 #define FILE_ATTRIBUTE_SPARSE_FILE	512
@@ -219,6 +219,7 @@ typedef BYTE BOOLEAN,*PBOOLEAN;
 #define FILE_ATTRIBUTE_COMPRESSED	2048
 #define FILE_ATTRIBUTE_OFFLINE	0x1000
 #define FILE_ATTRIBUTE_NOT_CONTENT_INDEXED	0x2000
+#define FILE_ATTRIBUTE_ENCRYPTED	0x4000
 #define FILE_NOTIFY_CHANGE_FILE_NAME	1
 #define FILE_NOTIFY_CHANGE_DIR_NAME	2
 #define FILE_NOTIFY_CHANGE_ATTRIBUTES	4

http://my.yahoo.com.au - My Yahoo!
- It's My Yahoo! Get your own!
