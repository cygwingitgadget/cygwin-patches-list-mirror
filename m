Return-Path: <cygwin-patches-return-4292-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19299 invoked by alias); 14 Oct 2003 11:29:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19290 invoked from network); 14 Oct 2003 11:29:38 -0000
Message-ID: <3F8BDE21.2090206@student.tue.nl>
Date: Tue, 14 Oct 2003 11:29:00 -0000
From: Micha Nelissen <M.Nelissen@student.tue.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20030924 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [Patch]: Ncurses frame drawing
References: <20031013170602.GN14344@cygbert.vinschen.de>
In-Reply-To: <20031013170602.GN14344@cygbert.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------080808010609050300020507"
X-SW-Source: 2003-q4/txt/msg00011.txt.bz2

This is a multi-part message in MIME format.
--------------080808010609050300020507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 688

Corinna Vinschen wrote:

> On Mon, Oct 13, 2003 at 06:38:42PM +0200, Micha Nelissen wrote:
> 
>>Hi,
>>
>>Attached is a patch to enable correct ncurses frame drawing. It does so 
>>by implementing the escape sequence for 'start/end alternate charset'. 
>>This is code \E[11m and \E[10m respectively in the linux termcap.
> 
> 
> This patch is a nice idea but it's not quite correct.  You can't
> rely on "current_codepage" being ansi_cp.  Since the user can set
> it to oem_cp in the CYGWIN environment variable, you have to memorize
> the old value on \E[11m and to restore to the old value on \E[10m.

Ok, that's true.  Attached is a patch with the suggested changes.

Regards,

Micha.


--------------080808010609050300020507
Content-Type: text/plain;
 name="charset.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="charset.log"
Content-length: 305

2003-10-13  Micha Nelissen  <M.Nelissen@student.tue.nl>

* fhandler_console.cc (char_command): added escape sequence for codepage
ansi <-> oem switching for ncurses frame drawing capabilities.

* dcrt0.cc: add local variable original_codepage.

* winsup.h: add global external variable original_codepage.

--------------080808010609050300020507
Content-Type: text/plain;
 name="charset.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="charset.patch"
Content-length: 1690

Index: dcrt0.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.187
diff -u -w -r1.187 dcrt0.cc
--- dcrt0.cc	8 Oct 2003 21:40:33 -0000	1.187
+++ dcrt0.cc	14 Oct 2003 11:28:44 -0000
@@ -57,6 +57,7 @@
 bool strip_title_path;
 bool allow_glob = TRUE;
 codepage_type current_codepage = ansi_cp;
+codepage_type original_codepage;
 
 int cygwin_finished_initializing;
 
Index: fhandler_console.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
retrieving revision 1.115
diff -u -w -r1.115 fhandler_console.cc
--- fhandler_console.cc	27 Sep 2003 02:36:50 -0000	1.115
+++ fhandler_console.cc	14 Oct 2003 11:28:44 -0000
@@ -1111,6 +1111,13 @@
 	     case 9:    /* dim */
 	       dev_state->intensity = INTENSITY_DIM;
 	       break;
+             case 10:   /* end alternate charset */
+               current_codepage = original_codepage;
+	       break;
+             case 11:   /* start alternate charset */
+               original_codepage = current_codepage;
+               current_codepage = oem_cp;
+	       break;
 	     case 24:
 	       dev_state->underline = FALSE;
 	       break;
Index: winsup.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/winsup.h,v
retrieving revision 1.119
diff -u -w -r1.119 winsup.h
--- winsup.h	25 Sep 2003 00:37:17 -0000	1.119
+++ winsup.h	14 Oct 2003 11:28:44 -0000
@@ -90,6 +90,7 @@
 
 enum codepage_type {ansi_cp, oem_cp};
 extern codepage_type current_codepage;
+extern codepage_type original_codepage;
 
 UINT get_cp ();
 

--------------080808010609050300020507--

