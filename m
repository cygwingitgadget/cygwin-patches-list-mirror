Return-Path: <cygwin-patches-return-1487-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 11265 invoked by alias); 13 Nov 2001 19:29:26 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 11251 invoked from network); 13 Nov 2001 19:29:25 -0000
Date: Wed, 10 Oct 2001 07:45:00 -0000
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: [Patch] setup.exe - change to not ask root on download only.
X-Mailer: Virtual Access by Atlantic Coast PLC, http://www.atlantic-coast.com/va
Message-Id: <VA.000009d7.011e66c9@thesoftwaresource.com>
From: Brian Keener <bkeener@thesoftwaresource.com>
Reply-To: bkeener@thesoftwaresource.com
X-SW-Source: 2001-q4/txt/msg00019.txt.bz2

Robert,

Here it is plus a couple cosmetics.  

2001-11-13  Brian Keener    <bkeener@thesoftwaresource.com>
       * localdir.cc: Add headers unistd.h and port.h.
       (save_local_dir): Expand search logic to include local directory for     
       location of file last-cache.
       (dialog_cmd): Skip IDD_ROOT when downloading and use Back button.
       (do_local_dir): Expand search logic to include local directory for file  
       last-cache.
        * res.rc (IDD_CHOOSE_DIALOG): Add hotkey to View button.
        * Source.cc (dialog_cmd): Skip IDD_ROOT if select Download from         
       Internet.
        (do_source): Default to Install from Internet on first entry or        
previous selection if backing up from IDD_ROOT or IDD_LOCAL_DIR.

? Choose.cc.sav
Index: localdir.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/localdir.cc,v
retrieving revision 2.3
diff -p -2 -r2.3 localdir.cc
*** localdir.cc        2001/11/06 03:41:00     2.3
--- localdir.cc        2001/11/13 19:02:03
*************** static char *cvsid =
*** 27,30 ****
--- 27,31 ----
  #include <stdlib.h>
  #include <ctype.h>
+ #include <unistd.h>
  
  #include "dialog.h"
*************** static char *cvsid =
*** 36,39 ****
--- 37,41 ----
  #include "log.h"
  #include "mkdir.h"
+ #include "port.h"
  
  static void
*************** save_local_dir ()
*** 51,60 ****
  {
    get_root_dir_now ();
-   if (!get_root_dir ())
-     return;
  
    mkdir_p (1, local_dir);
  
!   FILE *f = fopen (cygpath ("/etc/setup/last-cache", 0), "wb");
    if (!f)
      return;
--- 53,68 ----
  {
    get_root_dir_now ();
  
    mkdir_p (1, local_dir);
  
!   FILE *f;
!   if (!get_root_dir ())
!     f = fopen ("last-cache", "wb");
!   else
!   {
!     f = fopen (cygpath ("/etc/setup/last-cache", 0), "wb");
!     if ( _access ( "last-cache" , 0 ) == 0 && get_root_dir() )
!       remove ("last-cache");
!   }
    if (!f)
      return;
*************** dialog_cmd (HWND h, int id, HWND hwndctl
*** 162,170 ****
        switch (source)
       {
-      case IDC_SOURCE_DOWNLOAD:
       case IDC_SOURCE_NETINST:
       case IDC_SOURCE_CWD:
         NEXT (IDD_ROOT);
         break;
       default:
         msg ("source is default? %d\n", source);
--- 170,180 ----
        switch (source)
       {
       case IDC_SOURCE_NETINST:
       case IDC_SOURCE_CWD:
         NEXT (IDD_ROOT);
         break;
+      case IDC_SOURCE_DOWNLOAD:
+        NEXT (IDD_SOURCE);
+        break;
       default:
         msg ("source is default? %d\n", source);
*************** do_local_dir (HINSTANCE h)
*** 201,205 ****
    if (!inited)
      {
!       FILE *f = fopen (cygpath ("/etc/setup/last-cache", 0), "rt");
        if (f)
       {
--- 211,219 ----
    if (!inited)
      {
!       FILE *f;
!       if ( _access ( "last-cache" , 0 ) != 0 && get_root_dir() )
!              f = fopen (cygpath ("/etc/setup/last-cache", 0), "rt");
!       else
!              f = fopen ("last-cache", "rt");
        if (f)
       {
Index: res.rc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/res.rc,v
retrieving revision 2.29
diff -p -2 -r2.29 res.rc
*** res.rc     2001/11/03 01:07:03     2.29
--- res.rc     2001/11/13 19:02:10
*************** BEGIN
*** 242,253 ****
      LTEXT           "= click to choose action, (p) = previous version, (x) = 
experimental",
                      IDC_STATIC,35,234,220,8
!     PUSHBUTTON      "View",IDC_CHOOSE_VIEW,353,5,20,10
      LTEXT           "",IDC_CHOOSE_VIEWCAPTION,390,5,30,10
!     CONTROL         "E&xp",IDC_CHOOSE_EXP,"Button",BS_AUTORADIOBUTTON | 
                      WS_GROUP,323,5,25,10
      CONTROL         "&Prev",IDC_CHOOSE_PREV,"Button",BS_AUTORADIOBUTTON,265,
!                     5,27,10
      CONTROL         "&Curr",IDC_CHOOSE_CURR,"Button",BS_AUTORADIOBUTTON,297,
!                     5,25,10
      DEFPUSHBUTTON   "&Next -->",IDOK,311,242,45,15
      PUSHBUTTON      "Cancel",IDCANCEL,375,242,45,15
--- 242,253 ----
      LTEXT           "= click to choose action, (p) = previous version, (x) = 
experimental",
                      IDC_STATIC,35,234,220,8
!     PUSHBUTTON      "&View",IDC_CHOOSE_VIEW,353,5,20,10
      LTEXT           "",IDC_CHOOSE_VIEWCAPTION,390,5,30,10
!     CONTROL         "E&xp",IDC_CHOOSE_EXP,"Button",BS_AUTORADIOBUTTON |
                      WS_GROUP,323,5,25,10
      CONTROL         "&Prev",IDC_CHOOSE_PREV,"Button",BS_AUTORADIOBUTTON,265,
!                     5,27,10  
      CONTROL         "&Curr",IDC_CHOOSE_CURR,"Button",BS_AUTORADIOBUTTON,297,
!                     5,25,10 
      DEFPUSHBUTTON   "&Next -->",IDOK,311,242,45,15
      PUSHBUTTON      "Cancel",IDCANCEL,375,242,45,15
Index: source.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/source.cc,v
retrieving revision 2.6
diff -p -2 -r2.6 source.cc
*** source.cc  2001/11/06 03:41:00     2.6
--- source.cc  2001/11/13 19:02:13
*************** dialog_cmd (HWND h, int id, HWND hwndctl
*** 64,68 ****
      case IDOK:
        save_dialog (h);
!       NEXT (IDD_ROOT);
        break;
  
--- 64,71 ----
      case IDOK:
        save_dialog (h);
!       if (source == IDC_SOURCE_DOWNLOAD)
!      NEXT (IDD_LOCAL_DIR);
!       else
!      NEXT (IDD_ROOT);
        break;
  
*************** do_source (HINSTANCE h)
*** 106,110 ****
    int rv = 0;
    /* source = IDC_SOURCE_CWD;*/
!   source = IDC_SOURCE_NETINST;
    rv = DialogBox (h, MAKEINTRESOURCE (IDD_SOURCE), 0, dialog_proc);
    if (rv == -1)
--- 109,114 ----
    int rv = 0;
    /* source = IDC_SOURCE_CWD;*/
!   if (!source)
!     source = IDC_SOURCE_NETINST;
    rv = DialogBox (h, MAKEINTRESOURCE (IDD_SOURCE), 0, dialog_proc);
    if (rv == -1)



