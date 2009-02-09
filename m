Return-Path: <cygwin-patches-return-6411-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2603 invoked by alias); 9 Feb 2009 07:19:49 -0000
Received: (qmail 2591 invoked by uid 22791); 9 Feb 2009 07:19:47 -0000
X-SWARE-Spam-Status: No, hits=2.1 required=5.0 	tests=AWL,BAYES_00,SARE_MSGID_LONG40,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from fk-out-0910.google.com (HELO fk-out-0910.google.com) (209.85.128.190)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 09 Feb 2009 07:19:40 +0000
Received: by fk-out-0910.google.com with SMTP id z23so1453634fkz.2         for <cygwin-patches@cygwin.com>; Sun, 08 Feb 2009 23:19:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.109.148 with SMTP id j20mr888143fap.43.1234163976311; Sun,  	08 Feb 2009 23:19:36 -0800 (PST)
Date: Mon, 09 Feb 2009 07:19:00 -0000
Message-ID: <83b27df30902082319v6195318ch3e1e843f4f1631e4@mail.gmail.com>
Subject: [PATCH] w32api fixes
From: Michael James <james.me@gmail.com>
To: mingw-users@lists.sourceforge.net, cygwin-patches@cygwin.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2009-q1/txt/msg00009.txt.bz2

Some corrections to w32api I needed while porting an application to
mingw in this patch.

Index: ChangeLog
===================================================================
RCS file: /cvs/src/src/winsup/w32api/ChangeLog,v
retrieving revision 1.985
diff -r1.985 ChangeLog
0a1,12
> 2009-02-08  Michael James  <james.me@gmail.com>
>
>       * include/wingdi.h (CLEARTYPE_QUALITY): Define.
>       * include/winuser.h (WM_KEYLAST): Alternative definition when
>       _WIN32_WINNT >= 0x0501.
>       (WM_UNICHAR,UNICODE_NOCHAR): Define.
>       * lib/comctl32.def (DefSubclassProc@16,GetWindowSubclass@16,
>       RemoveWindowSubclass@12): Add exports.
>       * lib/gdi32.def (GetDCBrushColor@4,GetDCPenColor@4): Add exports.
>       * lib/msimg32.def (GetDCBrushColor@4,GetDCPenColor@4): Remove exports,
>       belong in gdi32.def originally in msimg32 due to bad documentation.
>
Index: include/wingdi.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/wingdi.h,v
retrieving revision 1.61
diff -r1.61 wingdi.h
361c361
< //http://www.pinvoke.net/default.aspx/Structures/LOGFONT.html
---
> /* http://www.pinvoke.net/default.aspx/Structures/LOGFONT.html */
374a375,377
> #if _WIN32_WINNT >= 0x0500
> #define CLEARTYPE_QUALITY 5
> #endif
Index: include/winuser.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/winuser.h,v
retrieving revision 1.128
diff -r1.128 winuser.h
1556a1557,1561
> #if _WIN32_WINNT >= 0x0501
> #define WM_KEYLAST 265
> #define WM_UNICHAR 265
> #define UNICODE_NOCHAR 0xffff
> #else
1557a1563
> #endif
Index: lib/comctl32.def
===================================================================
RCS file: /cvs/src/src/winsup/w32api/lib/comctl32.def,v
retrieving revision 1.5
diff -r1.5 comctl32.def
42a43
> DefSubclassProc@16
57a59
> GetWindowSubclass@16
103a106
> RemoveWindowSubclass@12
Index: lib/gdi32.def
===================================================================
RCS file: /cvs/src/src/winsup/w32api/lib/gdi32.def,v
retrieving revision 1.9
diff -r1.9 gdi32.def
145a146
> GetDCBrushColor@4
146a148
> GetDCPenColor@4
Index: lib/msimg32.def
===================================================================
RCS file: /cvs/src/src/winsup/w32api/lib/msimg32.def,v
retrieving revision 1.2
diff -r1.2 msimg32.def
4,5d3
< GetDCBrushColor@4
< GetDCPenColor@4
