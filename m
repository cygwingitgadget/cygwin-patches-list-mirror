From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: [W32API] att getrandomrgn
Date: Thu, 20 Dec 2001 22:55:00 -0000
Message-ID: <055701c189ec$558d8630$0200a8c0@lifelesswks>
X-SW-Source: 2001-q4/msg00347.html
Message-ID: <20011220225500._TKzFfxuSIJH5bdcaBDwr75R4JJhoemLENcfi2Kg0ug@z>

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
