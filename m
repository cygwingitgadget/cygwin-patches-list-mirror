Return-Path: <cygwin-patches-return-3879-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27423 invoked by alias); 24 May 2003 13:36:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27406 invoked from network); 24 May 2003 13:36:33 -0000
X-Originating-IP: [62.21.237.84]
X-Originating-Email: [mdvpost@hotmail.com]
From: "Micha Nelissen" <mdvpost@hotmail.com>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
Subject: Escape sequence for codepage switch
Date: Sat, 24 May 2003 13:36:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_012F_01C3220A.3DA3D3F0"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Message-ID: <BAY1-DAV40Yb9vPXtzf0002802a@hotmail.com>
X-OriginalArrivalTime: 24 May 2003 13:36:29.0446 (UTC) FILETIME=[7B39BA60:01C321F9]
X-SW-Source: 2003-q2/txt/msg00106.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_012F_01C3220A.3DA3D3F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 244

Hi,

Added escape sequence to let programs switch the current codepage to enable
linedrawing characters. These work only if the termcap entry is changed,
adding 'ae=\E[z' and 'as=\E[y' capabilities. For use of cygwin in Command
Prompt.

Micha.

------=_NextPart_000_012F_01C3220A.3DA3D3F0
Content-Type: application/octet-stream;
	name="cygwin_codepage.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cygwin_codepage.patch"
Content-length: 663

Index: fhandler_console.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
retrieving revision 1.110
diff -u -p -r1.110 fhandler_console.cc
--- fhandler_console.cc	8 Apr 2003 21:19:33 -0000	1.110
+++ fhandler_console.cc	21 May 2003 14:14:41 -0000
@@ -1361,7 +1382,13 @@ fhandler_console::char_command (char c)
       cursor_set (TRUE, 0, 0);
       break;
     case 'g':				/* TAB set/clear */
       break;
+    case 'y':
+        current_codepage = oem_cp;
+        break;
+    case 'z':
+        current_codepage = ansi_cp;
+        break;
     default:
 bad_escape:
       break;

------=_NextPart_000_012F_01C3220A.3DA3D3F0
Content-Type: application/octet-stream;
	name="cygwin_codepage.changelog"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cygwin_codepage.changelog"
Content-length: 149

2003-05-21  Micha Nelissen  <mdvpost@hotmail.com>

* fhandler_console.cc (char_command): added escape sequence for codepage
ansi <-> oem switching.


------=_NextPart_000_012F_01C3220A.3DA3D3F0--
