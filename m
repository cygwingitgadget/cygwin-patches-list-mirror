Return-Path: <cygwin-patches-return-1620-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25954 invoked by alias); 21 Dec 2001 06:55:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25932 invoked from network); 21 Dec 2001 06:54:59 -0000
Message-ID: <055701c189ec$558d8630$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: [W32API] att getrandomrgn
Date: Thu, 08 Nov 2001 15:22:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 21 Dec 2001 06:54:57.0935 (UTC) FILETIME=[672CA1F0:01C189EC]
X-SW-Source: 2001-q4/txt/msg00152.txt.bz2

I've checked this in. It's needed for setup.exe compilation.

Rob

2001-12-21  Robert Collins  <rbtcollins@hotmail.com>

        * include/wingdi.h: Add GetRandomRgn and SYSRGN.

Index: include/wingdi.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/wingdi.h,v
retrieving revision 1.7
diff -u -p -r1.7 wingdi.h
--- wingdi.h    2001/08/29 13:45:46     1.7
+++ wingdi.h    2001/12/21 06:52:36
@@ -2009,6 +2009,8 @@ typedef struct _RGNDATA {
        RGNDATAHEADER rdh;
        char Buffer[1];
 } RGNDATA,*LPRGNDATA;
+/* for GetRandomRgn */
+#define SYSRGN  4
 typedef struct tagGCP_RESULTSA {
        DWORD lStructSize;
        LPSTR lpOutString;
@@ -2539,6 +2541,7 @@ COLORREF WINAPI GetPixel(HDC,int,int);
 int WINAPI GetPixelFormat(HDC);
 int WINAPI GetPolyFillMode(HDC);
 BOOL WINAPI GetRasterizerCaps(LPRASTERIZER_STATUS,UINT);
+int WINAPI GetRandomRgn (HDC,HRGN,INT);
 DWORD WINAPI GetRegionData(HRGN,DWORD,LPRGNDATA);
 int WINAPI GetRgnBox(HRGN,LPRECT);
 int WINAPI GetROP2(HDC);
