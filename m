From: Brian Keener <bkeener@thesoftwaresource.com>
To: cygwin-patches@sources.redhat.com
Subject: [patch] desktop.cc fix for icons and optional creation
Date: Tue, 05 Sep 2000 15:05:00 -0000
Message-id: <VA.000004dc.01b57bd2@thesoftwaresource.com>
X-SW-Source: 2000-q3/msg00066.html

This revision supersedes in its entirety the previous change for the new 
setup program I sent on 2000-09-04 with a changelog entry dated 
2000-09-03.  Sorry for the inconvenience.

ChangeLog Entry:

2000-09-05 Brian Keener    <bkeener@thesoftwaresource.com>

   * desktop.cc (desktop_icon) - correction to desktop directories
     for desktop icon creation.  Additional logic added for Win95 which
     does not appear to have Common Directories so if Common selected and 
     null uses normal directory.
   * desktop.cc (start_menu) - Additional logic added for Win95 which
     does not appear to have Common Directories so if Common selected and
     null uses normal directory.
   * desktop.cc (do_desktop_setup) - moved the saving of the icon,
     creation of the bat file, profile, passwd, Start Menu link and
     desktop shortcut to this method from do_desktop.  Made the creation 
     of the desktop icon and start menu link conditional on settings of 
     new dialog created for desktop.
   * desktop.cc - added logic to handle to the new dialog and to default
     the setting for the new checkboxes based on whether the desktop icon 
     or start menu link already exist.
   * install.cc (do_install) - changed next from IDD_S_DESKTOP to
     IDD_DESKTOP.
   * main.cc (WinMain) - changed case IDD_S_DESKTOP to IDD_DESKTOP.
   * res.rc - added new resource to create a desktop dialog with 2
     checkboxes for creating the desktop icon and start menu link.
   * resource.h - changed IDD_S_DESKTOP to IDD_DESKTOP and added two new
     controls - IDC_ROOT_MENU and IDC_ROOT_DESKTOP for new dialog.
   * state.h - added root_menu and root_desktop for use in dialog.

? ls
Index: desktop.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/desktop.cc,v
retrieving revision 2.0
diff -p -2 -r2.0 desktop.cc
*** desktop.cc 2000/08/08 00:27:54 2.0
--- desktop.cc 2000/09/05 21:52:01
*************** start_menu (char *title, char *target)
*** 139,142 ****
--- 139,151 ----
    SHGetSpecialFolderLocation (NULL, issystem ? CSIDL_COMMON_PROGRAMS : 
CSIDL_PROGRAMS, &id);
    SHGetPathFromIDList (id, path);
+ // following lines added because it appears Win95 does not use common 
programs
+ // unless it comes into play when multiple users for Win95 is enabled
+   msg("Program directory for program link: %s",path);
+   if ( strlen(path) == 0) {
+      SHGetSpecialFolderLocation (NULL, CSIDL_PROGRAMS, &id);
+      SHGetPathFromIDList (id, path);
+      msg("Program directory for program link changed to: %s",path);
+   }
+ // end of Win95 addition
    strcat (path, "/Cygnus Solutions");
    make_link (path, title, target);
*************** desktop_icon (char *title, char *target)
*** 149,154 ****
    LPITEMIDLIST id;
    int issystem = (root_scope == IDC_ROOT_SYSTEM) ? 1 : 0;
!   SHGetSpecialFolderLocation (NULL, issystem ? CSIDL_DESKTOP : 
CSIDL_COMMON_DESKTOPDIRECTORY, &id);
    SHGetPathFromIDList (id, path);
    make_link (path, title, target);
  }
--- 158,173 ----
    LPITEMIDLIST id;
    int issystem = (root_scope == IDC_ROOT_SYSTEM) ? 1 : 0;
!   //SHGetSpecialFolderLocation (NULL, issystem ? CSIDL_DESKTOP : 
CSIDL_COMMON_DESKTOPDIRECTORY, &id);
!   SHGetSpecialFolderLocation (NULL, issystem ? 
CSIDL_COMMON_DESKTOPDIRECTORY : CSIDL_DESKTOPDIRECTORY, &id);
    SHGetPathFromIDList (id, path);
+ // following lines added because it appears Win95 does not use common 
programs
+ // unless it comes into play when multiple users for Win95 is enabled
+   msg("Desktop directory for desktop link: %s",path);
+   if ( strlen(path) == 0) {
+      SHGetSpecialFolderLocation (NULL, CSIDL_DESKTOPDIRECTORY, &id);
+      SHGetPathFromIDList (id, path);
+      msg("Desktop directory for deskop link changed to: %s",path);
+   }
+ // end of Win95 addition
    make_link (path, title, target);
  }
*************** save_icon ()
*** 284,287 ****
--- 303,450 ----
  }
  
+ static void
+ do_desktop_setup()
+ {
+   save_icon ();
+ 
+   make_cygwin_bat ();
+   make_etc_profile ();
+   make_passwd_group ();
+ 
+   if (root_menu) {
+  start_menu ("Cygwin 1.1 Bash Shell", batname);
+   }
+ 
+   if (root_desktop) {
+      desktop_icon ("Cygwin", batname);
+   }
+ }
+ 
+ static int da[] = { IDC_ROOT_DESKTOP, 0 };
+ static int ma[] = { IDC_ROOT_MENU, 0 };
+ 
+ static void
+ check_if_enable_next (HWND h)
+ {
+   EnableWindow (GetDlgItem (h, IDOK), 1);
+ }
+ 
+ static void
+ load_dialog (HWND h)
+ {
+   rbset (h, da, root_desktop);
+   rbset (h, ma, root_menu);
+   check_if_enable_next (h);
+ }
+ 
+ static int check_desktop (char *title, char *target)
+ {
+   char path[_MAX_PATH];
+   LPITEMIDLIST id;
+   int issystem = (root_scope == IDC_ROOT_SYSTEM) ? 1 : 0;
+   SHGetSpecialFolderLocation (NULL, issystem ? 
CSIDL_COMMON_DESKTOPDIRECTORY : CSIDL_DESKTOPDIRECTORY, &id);
+   SHGetPathFromIDList (id, path);
+ // following lines added because it appears Win95 does not use common 
programs
+ // unless it comes into play when multiple users for Win95 is enabled
+   msg("Desktop directory for desktop link: %s",path);
+   if ( strlen(path) == 0) {
+      SHGetSpecialFolderLocation (NULL, CSIDL_DESKTOPDIRECTORY, &id);
+      SHGetPathFromIDList (id, path);
+      msg("Desktop directory for deskop link changed to: %s",path);
+   }
+ // end of Win95 addition
+   char *fname = concat (path, "/", title, ".lnk", 0);
+ 
+   if (_access (fname, 0) == 0)
+     return 0; /* already exists */
+   
+   fname = concat (path, "/", title, ".pif", 0);/* check for a pif as 
well */
+   
+   if (_access (fname, 0) == 0)
+     return 0; /* already exists */
+ 
+   return IDC_ROOT_DESKTOP;
+ }
+ 
+ static int check_startmenu (char *title, char *target)
+ {
+   char path[_MAX_PATH];
+   LPITEMIDLIST id;
+   int issystem = (root_scope == IDC_ROOT_SYSTEM) ? 1 : 0;
+   SHGetSpecialFolderLocation (NULL, issystem ? CSIDL_COMMON_PROGRAMS : 
CSIDL_PROGRAMS, &id);
+   SHGetPathFromIDList (id, path);
+ // following lines added because it appears Win95 does not use common 
programs
+ // unless it comes into play when multiple users for Win95 is enabled
+   msg("Program directory for program link: %s",path);
+   if ( strlen(path) == 0) {
+      SHGetSpecialFolderLocation (NULL, CSIDL_PROGRAMS, &id);
+      SHGetPathFromIDList (id, path);
+      msg("Program directory for program link changed to: %s",path);
+   }
+ // end of Win95 addition
+   strcat (path, "/Cygnus Solutions");
+   char *fname = concat (path, "/", title, ".lnk", 0);
+ 
+   if (_access (fname, 0) == 0)
+     return 0; /* already exists */
+   
+   fname = concat (path, "/", title, ".pif", 0);/* check for a pif as 
well */
+   
+   if (_access (fname, 0) == 0)
+     return 0; /* already exists */
+   
+   return IDC_ROOT_MENU;
+ }
+ 
+ static void
+ save_dialog (HWND h)
+ {
+   root_desktop= rbget (h, da);
+   root_menu = rbget (h, ma);
+ }
+ 
+ static BOOL
+ dialog_cmd (HWND h, int id, HWND hwndctl, UINT code)
+ {
+   switch (id)
+     {
+ 
+     case IDC_ROOT_DESKTOP:
+     case IDC_ROOT_MENU:
+       save_dialog (h);
+       check_if_enable_next (h);
+       break;
+ 
+     case IDOK:
+       save_dialog (h);
+       do_desktop_setup();
+       NEXT (IDD_S_POSTINSTALL);
+       break;
+ 
+     case IDC_BACK:
+       save_dialog (h);
+       NEXT (IDD_CHOOSE);
+       break;
+ 
+     case IDCANCEL:
+       NEXT (0);
+       break;
+     }
+ }
+ 
+ static BOOL CALLBACK
+ dialog_proc (HWND h, UINT message, WPARAM wParam, LPARAM lParam)
+ {
+   switch (message)
+     {
+     case WM_INITDIALOG:
+       load_dialog (h);
+       return FALSE;
+     case WM_COMMAND:
+       return HANDLE_WM_COMMAND (h, wParam, lParam, dialog_cmd);
+     }
+   return FALSE;
+ }
+ 
  void
  do_desktop (HINSTANCE h)
*************** do_desktop (HINSTANCE h)
*** 293,305 ****
    verinfo.dwOSVersionInfoSize = sizeof (verinfo);
    GetVersionEx (&verinfo);
- 
-   save_icon ();
- 
-   make_cygwin_bat ();
-   make_etc_profile ();
-   make_passwd_group ();
  
!   start_menu ("Cygwin 1.1 Bash Shell", batname);
  
-   desktop_icon ("Cygwin", batname);
  }
--- 456,468 ----
    verinfo.dwOSVersionInfoSize = sizeof (verinfo);
    GetVersionEx (&verinfo);
  
!   root_desktop = check_desktop("Cygwin",backslash (concat (root_dir, 
"/cygwin.bat", 0)));
!   root_menu = check_startmenu("Cygwin 1.1 Bash Shell",backslash (concat 
(root_dir, "/cygwin.bat", 0)));
!   
!   int rv = 0;
! 
!   rv = DialogBox (h, MAKEINTRESOURCE (IDD_DESKTOP), 0, dialog_proc);
!   if (rv == -1)
!     fatal (IDS_DIALOG_FAILED);
  
  }
Index: install.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/install.cc,v
retrieving revision 2.2
diff -p -2 -r2.2 install.cc
*** install.cc 2000/08/30 01:05:42 2.2
--- install.cc 2000/09/05 21:52:04
*************** do_install (HINSTANCE h)
*** 238,242 ****
  {
    int i, num_installs = 0, num_uninstalls = 0;
!   next_dialog = IDD_S_DESKTOP;
  
    mkdir_p (1, root_dir);
--- 238,242 ----
  {
    int i, num_installs = 0, num_uninstalls = 0;
!   next_dialog = IDD_DESKTOP;
  
    mkdir_p (1, root_dir);
Index: main.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/main.cc,v
retrieving revision 2.2
diff -p -2 -r2.2 main.cc
*** main.cc    2000/08/25 01:32:08 2.2
--- main.cc    2000/09/05 21:52:04
*************** WinMain (HINSTANCE h,
*** 79,83 ****
   case IDD_S_DOWNLOAD:    do_download (h); break;
   case IDD_S_INSTALL: do_install (h); break;
!  case IDD_S_DESKTOP: do_desktop (h); break;
   case IDD_S_POSTINSTALL: do_postinstall (h); break;
  
--- 79,83 ----
   case IDD_S_DOWNLOAD:    do_download (h); break;
   case IDD_S_INSTALL: do_install (h); break;
!  case IDD_DESKTOP:   do_desktop (h); break;
   case IDD_S_POSTINSTALL: do_postinstall (h); break;
  
Index: res.rc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/res.rc,v
retrieving revision 2.3
diff -p -2 -r2.3 res.rc
*** res.rc 2000/08/30 01:05:42 2.3
--- res.rc 2000/09/05 21:52:08
*************** END
*** 229,232 ****
--- 229,247 ----
  
  
+ IDD_DESKTOP DIALOG DISCARDABLE  0, 0, 215, 95
+ STYLE DS_MODALFRAME | DS_CENTER | WS_POPUP | WS_CAPTION | WS_SYSMENU
+ CAPTION "Cygwin Setup"
+ FONT 8, "MS Sans Serif"
+ BEGIN
+     DEFPUSHBUTTON   "Next -->",IDOK,100,75,45,15
+     PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15
+     PUSHBUTTON      "<-- Back",IDC_BACK,55,75,45,15
+     ICON            IDI_CYGWIN,IDC_STATIC,5,5,20,20
+     CONTROL         "Create Desktop Icon",IDC_ROOT_DESKTOP,"Button",
+          BS_AUTOCHECKBOX,55,25,100,8
+     CONTROL         "Add to Start Menu",IDC_ROOT_MENU,"Button",
+          BS_AUTOCHECKBOX,55,40,100,8
+ END
+ 
  #ifdef APSTUDIO_INVOKED
  
/////////////////////////////////////////////////////////////////////////
////
Index: resource.h
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/resource.h,v
retrieving revision 2.3
diff -p -2 -r2.3 resource.h
*** resource.h 2000/08/30 01:05:42 2.3
--- resource.h 2000/09/05 21:52:08
***************
*** 35,39 ****
  #define IDD_S_INSTALL                   111
  #define IDD_INSTATUS                    112
! #define IDD_S_DESKTOP                   113
  #define IDD_PROXY_AUTH                  113
  #define IDD_S_POSTINSTALL               114
--- 35,39 ----
  #define IDD_S_INSTALL                   111
  #define IDD_INSTATUS                    112
! #define IDD_DESKTOP                  113
  #define IDD_PROXY_AUTH                  113
  #define IDD_S_POSTINSTALL               114
***************
*** 81,84 ****
--- 81,86 ----
  #define IDC_CHOOSE_LIST                 1039
  #define IDC_INS_ACTION                  1040
+ #define IDC_ROOT_DESKTOP     1041
+ #define IDC_ROOT_MENU            1042
  #define IDC_STATIC                      -1
  
***************
*** 91,95 ****
  #define _APS_NEXT_RESOURCE_VALUE        119
  #define _APS_NEXT_COMMAND_VALUE         40003
! #define _APS_NEXT_CONTROL_VALUE         1041
  #define _APS_NEXT_SYMED_VALUE           101
  #endif
--- 93,97 ----
  #define _APS_NEXT_RESOURCE_VALUE        119
  #define _APS_NEXT_COMMAND_VALUE         40003
! #define _APS_NEXT_CONTROL_VALUE         1043
  #define _APS_NEXT_SYMED_VALUE           101
  #endif
Index: state.h
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/state.h,v
retrieving revision 2.0
diff -p -2 -r2.0 state.h
*** state.h    2000/08/08 01:00:30 2.0
--- state.h    2000/09/05 21:52:09
*************** extern char *  root_dir;
*** 24,27 ****
--- 24,29 ----
  extern int   root_text;
  extern int   root_scope;
+ extern int   root_menu;
+ extern int   root_desktop;
  
  extern int   net_method;

Brian Keener
bkeener@thesoftwaresource.com
75462.747@compuserve.com

Virtual  Access 5.50 build 311 Win95

