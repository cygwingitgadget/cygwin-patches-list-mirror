Return-Path: <cygwin-patches-return-2014-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25450 invoked by alias); 29 Mar 2002 05:05:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25436 invoked from network); 29 Mar 2002 05:05:15 -0000
Message-ID: <20020329050515.58965.qmail@web10106.mail.yahoo.com>
Date: Fri, 29 Mar 2002 01:25:00 -0000
From: David Robinow <drobinow@yahoo.com>
Subject: Patch to w32api/include/wingdi.h  (SetPixelFormat)
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1108667238-1017378315=:58594"
X-SW-Source: 2002-q1/txt/msg00371.txt.bz2

--0-1108667238-1017378315=:58594
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 879

In http://cygwin.com/ml/cygwin/2002-03/msg01545.html
I said,

... I was not able to get fltk-1.0.11 to compile by change HAVE_GL to
1, either.
I have no reason to think any of these problems have anything to do
with cygwin. ...

It turns out I was wrong wrt cygwin.  fltk-1.0.11 compiles properly
with the following patch.

2002-03-29  David Robinow <drobinow@yahoo.com>
	
	* include/wingdi.h (SetPixelFormat): Make 3rd parameter const.


This patch was previously suggested by
  http://sources.redhat.com/ml/cygwin/2001-05/msg01129.html
The MSDN reference quoted in that mail does not appear to be valid any
more.
This one works
http://msdn.microsoft.com/library/default.asp?url=/library/en-us/opengl/ntopnglr_3q5w.asp



__________________________________________________
Do You Yahoo!?
Yahoo! Greetings - send holiday greetings for Easter, Passover
http://greetings.yahoo.com/
--0-1108667238-1017378315=:58594
Content-Type: text/plain; name="wingdi.h-patch"
Content-Description: wingdi.h-patch
Content-Disposition: inline; filename="wingdi.h-patch"
Content-length: 761

Index: winsup/w32api/include/wingdi.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/wingdi.h,v
retrieving revision 1.10
diff -u -p -r1.10 wingdi.h
--- wingdi.h	2002/03/09 09:04:10	1.10
+++ wingdi.h	2002/03/29 04:44:48
@@ -2659,7 +2659,7 @@ int WINAPI SetMetaRgn(HDC);
 BOOL WINAPI SetMiterLimit(HDC,FLOAT,PFLOAT);
 UINT WINAPI SetPaletteEntries(HPALETTE,UINT,UINT,const PALETTEENTRY*);
 COLORREF WINAPI SetPixel(HDC,int,int,COLORREF);
-BOOL WINAPI SetPixelFormat(HDC,int,PIXELFORMATDESCRIPTOR*);
+BOOL WINAPI SetPixelFormat(HDC,int,const PIXELFORMATDESCRIPTOR*);
 BOOL WINAPI SetPixelV(HDC,int,int,COLORREF);
 int WINAPI SetPolyFillMode(HDC,int);
 BOOL WINAPI SetRectRgn(HRGN,int,int,int,int);

--0-1108667238-1017378315=:58594--
