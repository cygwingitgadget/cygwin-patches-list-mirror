Return-Path: <cygwin-patches-return-1758-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4599 invoked by alias); 23 Jan 2002 00:20:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4583 invoked from network); 23 Jan 2002 00:20:15 -0000
Message-ID: <20020123002014.53355.qmail@web14510.mail.yahoo.com>
Date: Tue, 22 Jan 2002 16:20:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: recent patch to w32api/include/commctrl.h
To: cygwin-patches <cygwin-patches@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q1/txt/msg00115.txt.bz2

Robert,
Your recent patch:
Log message:
	2001-12-17  Robret Collins  <rbtcollins@hotmail.com>
	
	* include/commctrl.h: New typedefs for HDLAYOUT and LPHDLAYOUT based
	on MSDN documentation for XP.

added a new struct _HDITEM, which has a UNICODED field (LPTSTR pszText) in
it. However, some code expects to have explicit HDITEMA and HDITEMW
structures.  Since the the new structure is essantially a replacement
(since IE 3.0) for old HD_ITEM[AW], wouldn't following make more sense
(second part of attached patch).  I'm also suggesting same approach for
NMLISTVIEW.

Danny

2002-01-22  Phillip Susi  <psusi@cfl.rr.com> 

	* include/commctrl.h: Add missing HDM_*,HDN_*,LVSICF_* defines.

2002-01-22  Danny Smith  <dannysmith@users.sourceforge.net>

	(HDITEM[AW]): Rename _HD_ITEM[AW] to _HDITEM[AW], with
	parallel chages to typedefs. Add defines for backward
	compatability with old names. Update UNICODE mappings.

	(NMLISTVIEW): Rename _NM_LISTVIEW to tagNMLISTVIEW, with
	parallel chages to typedefs. Add defines for backward
	compatability with old names.


RCS file: /cvs/src/src/winsup/w32api/include/commctrl.h,v
retrieving revision 1.9
diff -u -p -r1.9 commctrl.h
--- commctrl.h	2001/12/16 21:55:40	1.9
+++ commctrl.h	2002/01/22 23:09:55
@@ -179,6 +179,7 @@ extern "C" {
 #define HDM_LAYOUT	(HDM_FIRST+5)
 #if (_WIN32_IE >= 0x0300)
 #define HDM_GETITEMRECT (HDM_FIRST+7)
+#define HDM_GETORDERARRAY	(HDM_FIRST+17)
 #define HDM_SETORDERARRAY	(HDM_FIRST+18)
 #endif
 #define HHT_NOWHERE	1
@@ -206,6 +207,10 @@ extern "C" {
 #define HDN_ENDTRACKW	(HDN_FIRST-27)
 #define HDN_TRACKA	(HDN_FIRST-8)
 #define HDN_TRACKW	(HDN_FIRST-28)
+#if _WIN32_IE >= 0x0300
+#define HDN_ENDDRAG	(HDN_FIRST-11)
+#define HDN_BEGINDRAG	(HDN_FIRST-10)
+#endif
 #define CMB_MASKED 2
 #define TBSTATE_CHECKED	1
 #define TBSTATE_PRESSED	2
@@ -550,6 +555,8 @@ extern "C" {
 #define LVS_EX_SUBITEMIMAGES 2
 #define LVS_EX_TRACKSELECT 8
 #define LVS_EX_TWOCLICKACTIVATE 128
+#define LVSICF_NOINVALIDATEALL	0x00000001
+#define LVSICF_NOSCROLL		0x00000002
 #endif
 #define LVSIL_NORMAL	0
 #define LVSIL_SMALL	1
@@ -1206,7 +1213,7 @@ typedef struct _IMAGEINFO {
 	RECT rcImage;
 } IMAGEINFO;
 DECLARE_HANDLE(HIMAGELIST);
-typedef struct _HD_ITEMA {
+typedef struct _HDITEMA {
 	UINT mask;
 	int cxy;
 	LPSTR pszText;
@@ -1222,8 +1229,8 @@ typedef struct _HD_ITEMA {
 	UINT type;
 	LPVOID pvFilter;
 #endif
-} HD_ITEMA;
-typedef struct _HD_ITEMW {
+} HDITEMA, * LPHDITEMA;
+typedef struct _HDITEMW {
 	UINT mask;
 	int cxy;
 	LPWSTR pszText;
@@ -1238,25 +1245,11 @@ typedef struct _HD_ITEMW {
 #if (_WIN32_IE >= 0x0500)
 	UINT type;
 	LPVOID pvFilter;
-#endif
-} HD_ITEMW;
-typedef struct _HDITEM {
-	UINT    mask; 
-        int     cxy; 
-	LPTSTR  pszText; 
-	HBITMAP hbm; 
-	int     cchTextMax; 
-	int     fmt; 
-	LPARAM  lParam; 
-#if (_WIN32_IE >= 0x0300)
-	int     iImage;
-	int     iOrder;
 #endif
-#if (_WIN32_IE >= 0x0500)
-	UINT    type;
-	LPVOID  pvFilter;
-#endif
-} HDITEM, FAR * LPHDITEM;
+} HDITEMW, * LPHDITEMW;
+#define HD_ITEMA HDITEMA /* backward compatability */
+#define HD_ITEMW HDITEMW
+#define HD_ITEM HDITEM
 typedef struct _HD_LAYOUT {
 	RECT *prc;
 	WINDOWPOS *pwpos;
@@ -1503,7 +1496,7 @@ typedef struct _LVCOLUMNW {
 #define _LV_COLUMNW _LVCOLUMNW
 #define LV_COLUMNW LVCOLUMNW
 typedef int(CALLBACK *PFNLVCOMPARE)(LPARAM,LPARAM,LPARAM);
-typedef struct _NM_LISTVIEW {
+typedef struct tagNMLISTVIEW {
 	NMHDR hdr;
 	int iItem;
 	int iSubItem;
@@ -1512,7 +1505,10 @@ typedef struct _NM_LISTVIEW {
 	UINT uChanged;
 	POINT ptAction;
 	LPARAM lParam;
-} NM_LISTVIEW,*LPNM_LISTVIEW;
+} NMLISTVIEW, *LPNMLISTVIEW;
+#define _NM_LISTVIEW  tagNMLISTVIEW
+#define NM_LISTVIEW NMLISTVIEW
+#define LPNM_LISTVIEW LPNMLISTVIEW
 typedef struct tagNMLVDISPINFOA {
 	NMHDR hdr;
 	LV_ITEMA item;
@@ -1796,7 +1792,8 @@ typedef struct tagIMAGELISTDRAWPARAMS {
 	UINT fStyle;
 	DWORD dwRop;
 } IMAGELISTDRAWPARAMS,*LPIMAGELISTDRAWPARAMS;
-#elif (_WIN32_IE >= 0x0400)
+#endif /* (_WIN32_IE >= 0x0300) */
+#if (_WIN32_IE >= 0x0400)
 typedef struct tagNMREBARCHILDSIZE {
 	NMHDR hdr;
 	UINT uBand;
@@ -2117,7 +2114,7 @@ WINBOOL WINAPI ImageList_DrawIndirect(IM
 #define WC_LISTVIEW WC_LISTVIEWW
 #define WC_TABCONTROL WC_TABCONTROLW
 #define WC_TREEVIEW WC_TREEVIEWW
-typedef HD_ITEMW HD_ITEM;
+typedef HDITEMW HDITEM;
 typedef TOOLINFOW TOOLINFO,*PTOOLINFO,*LPTOOLINFO;
 typedef TTHITTESTINFOW TTHITTESTINFO,*LPHITTESTINFO;
 typedef TOOLTIPTEXTW TOOLTIPTEXT,*LPTOOLTIPTEXT;
@@ -2255,7 +2252,7 @@ typedef REBARBANDINFOW REBARBANDINFO,*LP
 #define WC_LISTVIEW WC_LISTVIEWA
 #define WC_TABCONTROL WC_TABCONTROLA
 #define WC_TREEVIEW WC_TREEVIEWA
-typedef HD_ITEMA HD_ITEM;
+typedef HDITEMA HDITEM;
 typedef TOOLINFOA TOOLINFO,*PTOOLINFO,*LPTOOLINFO;
 typedef TTHITTESTINFOA TTHITTESTINFO,*LPHITTESTINFO;
 typedef TOOLTIPTEXTA TOOLTIPTEXT,*LPTOOLTIPTEXT;
 


http://my.yahoo.com.au - My Yahoo!
- It's My Yahoo! Get your own!
