Return-Path: <cygwin-patches-return-2011-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28461 invoked by alias); 27 Mar 2002 14:03:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28378 invoked from network); 27 Mar 2002 14:02:59 -0000
Message-ID: <3CA1D10E.E672E081@cistron.nl>
Date: Wed, 27 Mar 2002 06:11:00 -0000
From: Ton van Overbeek <tvoverbe@cistron.nl>
X-Accept-Language: en, en-US, en-GB, nl, sv
MIME-Version: 1.0
To: cygwin-apps@cygwin.com, cygwin-patches@cygwin.com
CC: jonas_eriksson@home.se
Subject: Patch for Setup.exe problem and for mklink2.cc
Content-Type: multipart/mixed;
 boundary="------------4E10E38C83FCB4712E588E7C"
X-SW-Source: 2002-q1/txt/msg00368.txt.bz2

This is a multi-part message in MIME format.
--------------4E10E38C83FCB4712E588E7C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 835

Found the problem causing the segment violation and probably causing
Jonas Eriksson's problem. It is a typical case of 'off by 1'.
In PickView::set_headers the loop filling the window header does one
iteration too much, resulting in a call to DoInsertItem with a NULL
string pointer and hence a crash following.
While debugging this I could not compile the new mklink2.cc ( the
c++ version of the original mklink2.c). It seems three & (address of operator)
have disappeared in the transition. Putting them back made the compiler
happy. Is this OK Robert ?

Changelog
2002-03-27  Ton van Overbeek (tvoverbe@cistron.nl)
* Pickview.cc (PickView::set_headers) Correct loop count for DoInsertItem.

* mklink2.cc (make_link_2) Reinsert three & operators which got lost in the
  c -> c++ transition.

Patch in attached file.

Ton van Overbeek
--------------4E10E38C83FCB4712E588E7C
Content-Type: text/plain; charset=us-ascii;
 name="patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.txt"
Content-length: 993

--- mklink2.cc-orig	Wed Mar 27 12:18:34 2002
+++ mklink2.cc	Wed Mar 27 12:41:16 2002
@@ -20,9 +20,9 @@ make_link_2 (char const *exepath, char c
   IPersistFile *pf;
   WCHAR widepath[_MAX_PATH];
 
-  CoCreateInstance (CLSID_ShellLink, NULL,
-		    CLSCTX_INPROC_SERVER, IID_IShellLink, (LPVOID *) & sl);
-  sl->lpVtbl->QueryInterface (sl, IID_IPersistFile, (void **) &pf);
+  CoCreateInstance (&CLSID_ShellLink, NULL,
+		    CLSCTX_INPROC_SERVER, &IID_IShellLink, (LPVOID *) & sl);
+  sl->lpVtbl->QueryInterface (sl, &IID_IPersistFile, (void **) &pf);
 
   sl->lpVtbl->SetPath (sl, exepath);
   sl->lpVtbl->SetArguments (sl, args);
--- PickView.cc-orig	Wed Mar 27 12:18:26 2002
+++ PickView.cc	Wed Mar 27 12:20:16 2002
@@ -110,7 +110,7 @@ PickView::set_headers ()
       SendMessage (listheader, HDM_DELETEITEM, n - 1, 0);
     }
   int i;
-  for (i = 0; i <= last_col; i++)
+  for (i = 0; i < last_col; i++)
     DoInsertItem (listheader, i, headers[i].width, (char *) headers[i].text);
 }
 

--------------4E10E38C83FCB4712E588E7C--
