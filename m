Return-Path: <cygwin-patches-return-4290-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7521 invoked by alias); 13 Oct 2003 16:38:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7499 invoked from network); 13 Oct 2003 16:38:43 -0000
Message-ID: <3F8AD512.20004@student.tue.nl>
Date: Mon, 13 Oct 2003 16:38:00 -0000
From: Micha Nelissen <M.Nelissen@student.tue.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20030924 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: [Patch]: Ncurses frame drawing
Content-Type: multipart/mixed;
 boundary="------------040405020400020906070507"
X-SW-Source: 2003-q4/txt/msg00009.txt.bz2

This is a multi-part message in MIME format.
--------------040405020400020906070507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 234

Hi,

Attached is a patch to enable correct ncurses frame drawing. It does so 
by implementing the escape sequence for 'start/end alternate charset'. 
This is code \E[11m and \E[10m respectively in the linux termcap.

Regards,

Micha.

--------------040405020400020906070507
Content-Type: text/plain;
 name="charset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="charset.patch"
Content-length: 739

Index: fhandler_console.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
retrieving revision 1.115
diff -u -w -r1.115 fhandler_console.cc
--- fhandler_console.cc	27 Sep 2003 02:36:50 -0000	1.115
+++ fhandler_console.cc	13 Oct 2003 16:31:13 -0000
@@ -1111,6 +1111,12 @@
 	     case 9:    /* dim */
 	       dev_state->intensity = INTENSITY_DIM;
 	       break;
+             case 10:   /* end alternate charset */
+               current_codepage = ansi_cp;
+	       break;
+             case 11:   /* start alternate charset */
+               current_codepage = oem_cp;
+	       break;
 	     case 24:
 	       dev_state->underline = FALSE;
 	       break;

--------------040405020400020906070507
Content-Type: text/plain;
 name="charset.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="charset.log"
Content-length: 194

2003-10-13  Micha Nelissen  <M.Nelissen@student.tue.nl>

* fhandler_console.cc (char_command): added escape sequence for codepage
ansi <-> oem switching for ncurses frame drawing capabilities.


--------------040405020400020906070507--
