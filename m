Return-Path: <cygwin-patches-return-6299-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4884 invoked by alias); 16 Mar 2008 10:14:59 -0000
Received: (qmail 4872 invoked by uid 22791); 16 Mar 2008 10:14:58 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 16 Mar 2008 10:14:42 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1Japt2-0000Pt-Mb 	for cygwin-patches@cygwin.com; Sun, 16 Mar 2008 10:14:40 +0000
Message-ID: <47DCF310.2E2CA04A@dessent.net>
Date: Sun, 16 Mar 2008 10:14:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] QueryDosDevice in handle_to_fn
Content-Type: multipart/mixed;  boundary="------------65C671DD25604A2E6DD59002"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q1/txt/msg00073.txt.bz2

This is a multi-part message in MIME format.
--------------65C671DD25604A2E6DD59002
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1962


It looks like handle_to_fn is again acting up for named pipes.  A
representative strace snippet looks something like this:

  428  108008 [main] readlink 3048 handle_to_fn: nt name
'\Device\NamedPipe\Win32Pipes.0000082c.00000003'
 1548  109556 [main] readlink 3048 normalize_posix_path: src
\Device\NamedPipe\Win32Pipes.0000082c.00000003
   97  109653 [main] readlink 3048 normalize_win32_path:
c:\Device\NamedPipe\Win32Pipes.0000082c.00000003 = normalize_win32_path
(\Device\NamedPipe\Win32Pipes.0000082c.00000003)
   35  109688 [main] readlink 3048 mount_info::conv_to_win32_path:
conv_to_win32_path (c:/Device/NamedPipe/Win32Pipes.0000082c.00000003)
   42  109730 [main] readlink 3048 mount_info::conv_to_win32_path:
src_path c:/Device/NamedPipe/Win32Pipes.0000082c.00000003, dst
c:\Device\NamedPipe\Win32Pipes.0000082c.00000003, flags 0x0, rc 0

Clearly, something is wrong, there is no such C:\devices, and it wasn't
even trying to match it as a pipe.  I debugged this and found the
strangest thing, when you call QueryDosDevice (NULL, fnbuf, len) to get
the list of all DOS devices and len >= 65536, Win32 always returns 0
with GetLastError set to ERROR_MORE_DATA.  Since len was being set as
"sizeof (OBJECT_NAME_INFORMATION) + NT_MAX_PATH * sizeof (WCHAR)" this
always happened, causing handle_to_fn() to simply give up and copy the
Win32 name into the POSIX name and return.  The attached patch fixes the
problem by just clamping the size of the buffer to under 64k.

Another observation that I had while debugging this is that calling
strncasematch() in this function is probably wrong -- it expands to
cygwin_strncasecmp(), which is a wrapper that first converts both
arguments to temporary UNICODE strings and then calls
RtlCompareUnicodeString() -- we're doing this on strings that we had
just converted *out* of UNICODE.  I think ascii_strncasematch() is
probably what we want here instead, either that or try to stay in
unicode throughout.

Brian
--------------65C671DD25604A2E6DD59002
Content-Type: text/plain; charset=us-ascii;
 name="handle_to_fn_QueryDosDevice.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="handle_to_fn_QueryDosDevice.patch"
Content-length: 1147

2008-03-16  Brian Dessent  <brian@dessent.net>

	* dtable.cc (handle_to_fn): Don't pass a buffer greater than
	64k to QueryDosDevice.

 dtable.cc |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: dtable.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dtable.cc,v
retrieving revision 1.185
diff -u -p -r1.185 dtable.cc
--- dtable.cc	12 Mar 2008 12:41:49 -0000	1.185
+++ dtable.cc	16 Mar 2008 09:55:31 -0000
@@ -879,8 +879,13 @@ handle_to_fn (HANDLE h, char *posix_fn)
   sys_wcstombs (win32_fn, NT_MAX_PATH, ntfn->Name.Buffer,
   		ntfn->Name.Length / sizeof (WCHAR));
   debug_printf ("nt name '%s'", win32_fn);
+
+  /* For some reason QueryDosDevice will fail with Win32 errno 234
+     (ERROR_MORE_DATA) if you try to pass a buffer larger than 64k  */
+  size_t qddlen = len < 65536 ? len : 65535;
+
   if (!strncasematch (win32_fn, DEVICE_PREFIX, DEVICE_PREFIX_LEN)
-      || !QueryDosDevice (NULL, fnbuf, len))
+      || !QueryDosDevice (NULL, fnbuf, qddlen))
     return strcpy (posix_fn, win32_fn);
 
   char *p = strechr (win32_fn + DEVICE_PREFIX_LEN, '\\');

--------------65C671DD25604A2E6DD59002--
