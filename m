Return-Path: <cygwin-patches-return-1789-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32766 invoked by alias); 25 Jan 2002 15:44:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32699 invoked from network); 25 Jan 2002 15:44:15 -0000
Date: Fri, 25 Jan 2002 07:44:00 -0000
Message-ID: <20020125154401.6759.qmail@lizard.curl.com>
From: Jonathan Kamens <jik@curl.com>
To: cygwin-patches@cygwin.com
Subject: winuser.h: add defines for EnumDisplaySettings
X-SW-Source: 2002-q1/txt/msg00146.txt.bz2

2002-01-25  Jonathan Kamens  <jik@curl.com>

	* include/winuser.h: Define ENUM_CURRENT_SETTINGS and
	ENUM_REGISTRY_SETTINGS for use in calls to EnumDisplaySettings.

Index: winuser.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/winuser.h,v
retrieving revision 1.14
diff -u -r1.14 winuser.h
--- winuser.h	2002/01/25 02:54:19	1.14
+++ winuser.h	2002/01/25 15:43:21
@@ -2740,6 +2740,8 @@
 BOOL WINAPI EnumDisplayMonitors(HDC,LPCRECT,MONITORENUMPROC,LPARAM);
 BOOL WINAPI EnumDisplaySettingsA(LPCSTR,DWORD,PDEVMODEA);
 BOOL WINAPI EnumDisplaySettingsW(LPCWSTR,DWORD,PDEVMODEW);
+#define ENUM_CURRENT_SETTINGS       ((DWORD)-1)
+#define ENUM_REGISTRY_SETTINGS      ((DWORD)-2)
 int WINAPI EnumPropsA(HWND,PROPENUMPROCA);
 int WINAPI EnumPropsW(HWND,PROPENUMPROCW);
 int WINAPI EnumPropsExA(HWND,PROPENUMPROCEXA,LPARAM);
