Return-Path: <cygwin-patches-return-1824-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 1841 invoked by alias); 29 Jan 2002 21:23:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1827 invoked from network); 29 Jan 2002 21:23:20 -0000
X-Draft-From: ("nnmh:indoos.cygwin-patches" "")
To: cygwin-patches@cygwin.com
Subject: small setup.exe fix
Organization: Jan at Appel
Mail-Followup-To: cygwin-patches@cygwin.com
From: Jan Nieuwenhuizen <janneke@gnu.org>
Date: Tue, 29 Jan 2002 13:23:00 -0000
Message-ID: <m37kq0svgg.fsf@appel.lilypond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SW-Source: 2002-q1/txt/msg00181.txt.bz2

Hi,

Pressing 'Add' in the `Choose a dowload site' dialogue without typing
an url causes a segfault over here.  Fix below.

Greetings,
Jan.

ChangeLog:
2002-01-29  Jan Nieuwenhuizen  <janneke@gnu.org>

	* site.cc (OnMessageCmd): Bugfix: don't try to add NULL url.


--- ../cinstall.orig/site.cc	Tue Jan 29 10:24:34 2002
+++ ./site.cc	Tue Jan 29 22:17:13 2002
@@ -415,6 +415,8 @@ bool SitePage::OnMessageCmd (int id, HWN
 	  {
 	    // User pushed the Add button.
 	    other_url = eget (GetHWND (), IDC_EDIT_USER_URL, other_url);
+	    if (!other_url)
+	      break;
 	    site_list_type *
 	      newsite =
 	      new



Program received signal SIGSEGV, Segmentation fault.
0x0041c1f1 in site_list_type::init (this=0xb38610, newurl=0x0) at site.cc:56
56      site.cc: No such file or directory.
        in site.cc
Current language:  auto; currently c++
(gdb)

(gdb) bt
#0  0x0041c1f1 in site_list_type::init (this=0xb38610, newurl=0x0)
    at site.cc:56
#1  0x0041c3cb in site_list_type::site_list_type (this=0xb38610, newurl=0x0)
    at site.cc:91
#2  0x0041d218 in SitePage::OnMessageCmd (this=0xa0fa88, id=1063, 
    hwndctl=0x8c0, code=0) at site.cc:419
#3  0x0041ac6a in PropertyPage::DialogProc (this=0xa0fa88, message=273, 
    wParam=1063, lParam=2240) at proppage.cc:205
#4  0x0041aa7b in PropertyPage::DialogProcReflector (hwnd=0x8fc, message=273, 
    wParam=1063, lParam=2240) at proppage.cc:97
#5  0xbff7363b in _libwsock32_a_iname ()
#6  0xbff942e7 in _libwsock32_a_iname ()
#7  0x00008388 in ?? ()
#8  0x00058f64 in ?? ()
Cannot access memory at address 0xc9b60f5d

-- 
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org
