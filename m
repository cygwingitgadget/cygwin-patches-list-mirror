Return-Path: <cygwin-patches-return-2805-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 12416 invoked by alias); 8 Aug 2002 15:29:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 12402 invoked from network); 8 Aug 2002 15:29:11 -0000
Date: Thu, 08 Aug 2002 08:29:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [lars@segv.dk: [PATCH] w32api commcrtl.h]
Message-ID: <20020808152911.GB8388@redhat.com>
Mail-Followup-To: cygwin-patches@cygwin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00253.txt.bz2

----- Forwarded message from Lars Munch <lars@segv.dk> -----

From: lars@segv.dk (Lars Munch)
To: cygwin@cygwin.com
Subject: [PATCH] w32api commcrtl.h
Date: Thu, 8 Aug 2002 17:16:29 +0200
Mail-Followup-To: cygwin@cygwin.com

Hi

This patch adds the ListView_SetExtendedListViewStyleEx macro and the
TVHITTESTINFO structure with backwards compability with the old naming
convention to the commctrl.h header file from the w32api package

Regards
Lars Munch


--- commctrl.h.old	2002-06-14 14:22:39.000000000 +0200
+++ commctrl.h	2002-08-08 16:58:59.000000000 +0200
@@ -1751,11 +1751,14 @@
 #define _TV_INSERTSTRUCTW tagTVINSERTSTRUCTW
 #define TV_INSERTSTRUCTW TVINSERTSTRUCTW
 #define LPTV_INSERTSTRUCTW LPTVINSERTSTRUCTW
-typedef struct _TV_HITTESTINFO {
-	POINT pt;
-	UINT flags;
-	HTREEITEM hItem;
-} TV_HITTESTINFO,*LPTV_HITTESTINFO;
+typedef struct tagTVHITTESTINFO {
+    POINT  pt;
+    UINT  flags;
+    HTREEITEM  hItem;
+} TVHITTESTINFO, *LPTVHITTESTINFO;
+#define _TV_HITTESTINFO tagTVHITTESTINFO
+#define TV_HITTESTINFO TVHITTESTINFO
+#define LPTV_HITTESTINFO LPTVHITTESTINFO
 typedef int(CALLBACK *PFNTVCOMPARE)(LPARAM,LPARAM,LPARAM);
 typedef struct _TV_SORTCB {
 	HTREEITEM hParent;
@@ -2257,6 +2260,7 @@
 #define TreeView_SetToolTips(w,wt) (HWND)SNDMSG((w),TVM_SETTOOLTIPS,(WPARAM)(wt),0)
 #endif
 #if (_WIN32_IE >= 0x0400)
+#define ListView_SetExtendedListViewStyleEx(w,m,s) (DWORD)SNDMSG((w),LVM_SETEXTENDEDLISTVIEWSTYLE,(m),(s))
 #define TabCtrl_HighlightItem(hwnd, i, fHighlight) SNDMSG((hwnd), TCM_HIGHLIGHTITEM, (WPARAM)i, (LPARAM)MAKELONG (fHighlight, 0))
 #define TabCtrl_SetExtendedStyle(hwnd, dw) SNDMSG((hwnd), TCM_SETEXTENDEDSTYLE, 0, dw)
 #define TabCtrl_GetExtendedStyle(hwnd) SNDMSG((hwnd), TCM_GETEXTENDEDSTYLE, 0, 0)


--
Unsubscribe info:      http://cygwin.com/ml/#unsubscribe-simple
Bug reporting:         http://cygwin.com/bugs.html
Documentation:         http://cygwin.com/docs.html
FAQ:                   http://cygwin.com/faq/

----- End forwarded message -----
