From: Brian Keener <bkeener@thesoftwaresource.com>
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: [patch] setup.exe geturl.cc enhancement for total and diskfull download progress meters
Date: Tue, 20 Feb 2001 19:23:00 -0000
Message-id: <VA.00000670.003b71c8@thesoftwaresource.com>
X-SW-Source: 2001-q1/msg00096.html

2001-02-20  Brian Keener <bkeener@thesoftwaresource.com>
   * download.cc (do_download): New variables total_download_bytes and 
   total_download_bytes_sofar added for download progress meter.  Add loop
   to accumulate the total bytes to download from the selected packages.
   * geturl.cc: Add state.h and diskfull.h to include list.  New variables
   gw_iprogress, gw_pprogress, gw_progress_text, gw_pprogress_text, and
   gw_iprogress_text added to allow for addition of Total packages download
   progress meter and disk full percent progress meter.  Add variables
   total_download_bytes and total_download_bytes_sofar for use by progress
   meters.
   (dialog_proc): New variables gw_iprogress, gw_pprogress, 
   gw_progress_text, gw_pprogress_text, and gw_iprogress_text added to 
   allow for addition of Total packages download progress meter and disk 
   full percent progress meter.  
   (init_dialog): Ditto.
   (progress): Ditto.
   (get_url_to_file): Ditto.
   * geturl.h: Add external definition for total_download_bytes and
   total_download_bytes_sofar.
   * res.rc (): Add two additional progress meters (IDC_DLS_IPROGRESS) 
        and (IDC_DLS_PPROGRESS) and three text objects (IDC_DLS_PROGRESS_TEXT)
   and (IDC_DLS_IPROGRESS_TEXT, IDC_DLS_PPROGRESS_TEXT) for use in the
   download meters.
   * resource.h: Add new fields for progress meters and text and update 
   _APS_NEXT_CONTROL_VALUE.

Index: winsup/cinstall/download.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/download.cc,v
retrieving revision 2.4
diff -p -2 -r2.4 download.cc
*** download.cc    2000/10/23 19:46:01 2.4
--- download.cc    2001/02/20 04:40:18
*************** do_download (HINSTANCE h)
*** 82,85 ****
--- 82,93 ----
    int i;
    int errors = 0;
+   total_download_bytes = 0;
+   total_download_bytes_sofar = 0;
+ 
+   for (i=0; i<npackages; i++)
+     if (package[i].action == ACTION_NEW || package[i].action == ACTION_UPGRADE)
+       {
+         total_download_bytes += pi.install_size;
+       }
  
    for (i=0; i<npackages; i++)
Index: winsup/cinstall/geturl.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/geturl.cc,v
retrieving revision 2.2
diff -p -2 -r2.2 geturl.cc
*** geturl.cc  2000/08/30 01:05:42 2.2
--- geturl.cc  2001/02/20 04:40:22
*************** static char *cvsid = "\n%%% $Id: geturl.
*** 33,36 ****
--- 33,38 ----
  #include "msg.h"
  #include "log.h"
+ #include "state.h"
+ #include "diskfull.h"
  
  static int is_showing = 0;
*************** static HWND gw_url = 0;
*** 39,45 ****
--- 41,55 ----
  static HWND gw_rate = 0;
  static HWND gw_progress = 0;
+ static HWND gw_pprogress = 0;
+ static HWND gw_iprogress = 0;
+ static HWND gw_progress_text = 0;
+ static HWND gw_pprogress_text = 0;
+ static HWND gw_iprogress_text = 0;
  static HANDLE init_event;
  static int max_bytes = 0;
  
+ int total_download_bytes = 0;
+ int total_download_bytes_sofar = 0;
+ 
  static BOOL
  dialog_cmd (HWND h, int id, HWND hwndctl, UINT code)
*************** dialog_proc (HWND h, UINT message, WPARA
*** 64,67 ****
--- 74,82 ----
        gw_rate = GetDlgItem (h, IDC_DLS_RATE);
        gw_progress = GetDlgItem (h, IDC_DLS_PROGRESS);
+       gw_pprogress = GetDlgItem (h, IDC_DLS_PPROGRESS);
+       gw_iprogress = GetDlgItem (h, IDC_DLS_IPROGRESS);
+       gw_progress_text = GetDlgItem (h, IDC_DLS_PROGRESS_TEXT);
+       gw_pprogress_text = GetDlgItem (h, IDC_DLS_PPROGRESS_TEXT);
+       gw_iprogress_text = GetDlgItem (h, IDC_DLS_IPROGRESS_TEXT);
        SetEvent (init_event);
        return FALSE;
*************** init_dialog (char *url, int length)
*** 101,104 ****
--- 116,121 ----
        CloseHandle (init_event);
        SendMessage (gw_progress, PBM_SETRANGE, 0, MAKELPARAM (0, 100));
+       SendMessage (gw_pprogress, PBM_SETRANGE, 0, MAKELPARAM (0, 100));
+       SendMessage (gw_iprogress, PBM_SETRANGE, 0, MAKELPARAM (0, 100));
        is_showing = 0;
      }
*************** init_dialog (char *url, int length)
*** 112,115 ****
--- 129,148 ----
    SendMessage (gw_progress, PBM_SETPOS, (WPARAM) 0, 0);
    ShowWindow (gw_progress, (length > 0) ? SW_SHOW : SW_HIDE);
+   if (length > 0 )
+     SetWindowText (gw_progress_text, "Package");
+   else
+     SetWindowText (gw_progress_text, "       ");
+   ShowWindow (gw_pprogress, (total_download_bytes > 0) ? SW_SHOW : SW_HIDE);
+   if (total_download_bytes > 0)
+     {
+       SetWindowText (gw_pprogress_text, "Total");
+       SetWindowText (gw_iprogress_text, "Disk");
+     }
+   else 
+     {
+       SetWindowText (gw_pprogress_text, "     ");
+       SetWindowText (gw_iprogress_text, "    ");
+     }
+   ShowWindow (gw_iprogress, (total_download_bytes > 0) ? SW_SHOW : SW_HIDE);
    ShowWindow (gw_dialog, SW_SHOWNORMAL);
    if (!is_showing)
*************** progress (int bytes)
*** 137,140 ****
--- 170,175 ----
    kbps = bytes / (tics - start_tics);
    ShowWindow (gw_progress, (max_bytes > 0) ? SW_SHOW : SW_HIDE);
+   ShowWindow (gw_pprogress, (total_download_bytes > 0) ? SW_SHOW : SW_HIDE);
+   ShowWindow (gw_iprogress, (total_download_bytes > 0) ? SW_SHOW : SW_HIDE);
    if (max_bytes > 100)
      {
*************** progress (int bytes)
*** 143,146 ****
--- 178,187 ----
        sprintf (buf, "%3d %%  (%dk/%dk)  %d kb/s\n",
          perc, bytes/1000, max_bytes/1000, kbps);
+       if (total_download_bytes > 0)
+         {
+           int totalperc = (total_download_bytes_sofar + bytes) / (
+                     total_download_bytes / 100);
+           SendMessage (gw_pprogress, PBM_SETPOS, (WPARAM) totalperc, 0);
+         }
      }
    else
*************** get_url_to_file (char *_url, char *_file
*** 208,211 ****
--- 249,257 ----
  {
    log (LOG_BABBLE, "get_url_to_file %s %s", _url, _filename);
+   if (total_download_bytes > 0)
+     {
+       int df = diskfull (root_dir);
+       SendMessage (gw_iprogress, PBM_SETPOS, (WPARAM) df, 0);
+     }
    init_dialog (_url, expected_length);
  
*************** get_url_to_file (char *_url, char *_file
*** 246,250 ****
--- 292,304 ----
      }
  
+   total_download_bytes_sofar += total_bytes;
+ 
    fclose (f);
+ 
+   if (total_download_bytes > 0)
+     {
+       int df = diskfull (root_dir);
+       SendMessage (gw_iprogress, PBM_SETPOS, (WPARAM) df, 0);
+     }
  
    return 0;
Index: winsup/cinstall/geturl.h
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/geturl.h,v
retrieving revision 2.0
diff -p -2 -r2.0 geturl.h
*** geturl.h   2000/08/08 00:27:54 2.0
--- geturl.h   2001/02/20 04:40:22
***************
*** 17,20 ****
--- 17,23 ----
     don't forget to dismiss it when you're done downloading for a while */
  
+ extern int total_download_bytes;
+ extern int total_download_bytes_sofar;
+ 
  char  *get_url_to_string (char *_url);
  int    get_url_to_file (char *_url, char *_filename, int expected_size);
Index: winsup/cinstall/res.rc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/res.rc,v
retrieving revision 2.11
diff -p -2 -r2.11 res.rc
*** res.rc 2000/12/26 23:15:56 2.11
--- res.rc 2001/02/20 04:40:29
*************** BEGIN
*** 141,149 ****
      ICON            IDI_CYGWIN,IDC_STATIC,5,5,20,20
      PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15
!     LTEXT           "Downloading...",IDC_STATIC,55,15,135,8
!     LTEXT           "(URL)",IDC_DLS_URL,55,30,150,8
!     LTEXT           "(RATE)",IDC_DLS_RATE,55,45,155,8
      CONTROL         "Progress1",IDC_DLS_PROGRESS,"msctls_progress32",
                      PBS_SMOOTH | WS_BORDER,55,60,155,10
  END
  
--- 141,156 ----
      ICON            IDI_CYGWIN,IDC_STATIC,5,5,20,20
      PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15
!     LTEXT           "Downloading...",IDC_STATIC,55,5,135,8
!     LTEXT           "(URL)",IDC_DLS_URL,55,15,150,8
!     LTEXT           "(RATE)",IDC_DLS_RATE,55,25,155,8
      CONTROL         "Progress1",IDC_DLS_PROGRESS,"msctls_progress32",
+                     PBS_SMOOTH | WS_BORDER,55,40,155,10
+     CONTROL         "Progress1",IDC_DLS_PPROGRESS,"msctls_progress32",
+                     PBS_SMOOTH | WS_BORDER,55,50,155,10
+     CONTROL         "Progress1",IDC_DLS_IPROGRESS,"msctls_progress32",
                      PBS_SMOOTH | WS_BORDER,55,60,155,10
+     RTEXT           "Package",IDC_DLS_PROGRESS_TEXT,5,40,45,8
+     RTEXT           "Total",IDC_DLS_PPROGRESS_TEXT,10,50,40,8
+     RTEXT           "Disk",IDC_DLS_IPROGRESS_TEXT,5,60,45,8
  END
  
Index: winsup/cinstall/resource.h
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/resource.h,v
retrieving revision 2.8
diff -p -2 -r2.8 resource.h
*** resource.h 2000/10/23 19:46:01 2.8
--- resource.h 2001/02/20 04:40:30
***************
*** 94,97 ****
--- 94,102 ----
  #define IDC_LOCAL_DIR_BROWSE            1043
  #define IDC_LOCAL_DIR                   1044
+ #define IDC_DLS_PPROGRESS               1045
+ #define IDC_DLS_IPROGRESS               1046
+ #define IDC_DLS_PROGRESS_TEXT           1047
+ #define IDC_DLS_PPROGRESS_TEXT          1048
+ #define IDC_DLS_IPROGRESS_TEXT          1049
  #define IDC_STATIC                      -1
  
***************
*** 104,108 ****
  #define _APS_NEXT_RESOURCE_VALUE        126
  #define _APS_NEXT_COMMAND_VALUE         40003
! #define _APS_NEXT_CONTROL_VALUE         1045
  #define _APS_NEXT_SYMED_VALUE           101
  #endif
--- 109,113 ----
  #define _APS_NEXT_RESOURCE_VALUE        126
  #define _APS_NEXT_COMMAND_VALUE         40003
! #define _APS_NEXT_CONTROL_VALUE         1050
  #define _APS_NEXT_SYMED_VALUE           101
  #endif


