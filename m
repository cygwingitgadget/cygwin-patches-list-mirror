Return-Path: <cygwin-patches-return-1759-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8039 invoked by alias); 23 Jan 2002 00:38:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8025 invoked from network); 23 Jan 2002 00:38:13 -0000
Message-ID: <0d4401c1a3a6$3c1a9c00$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Danny Smith" <danny_r_smith_2001@yahoo.co.nz>,
	"cygwin-patches" <cygwin-patches@cygwin.com>
References: <20020123002014.53355.qmail@web14510.mail.yahoo.com>
Subject: Re: recent patch to w32api/include/commctrl.h
Date: Tue, 22 Jan 2002 16:38:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 23 Jan 2002 00:38:12.0142 (UTC) FILETIME=[3CB41CE0:01C1A3A6]
X-SW-Source: 2002-q1/txt/msg00116.txt.bz2


===
----- Original Message -----
From: "Danny Smith" <danny_r_smith_2001@yahoo.co.nz>
To: "cygwin-patches" <cygwin-patches@cygwin.com>
Sent: Wednesday, January 23, 2002 11:20 AM
Subject: recent patch to w32api/include/commctrl.h


> Robert,
> Your recent patch:
> Log message:
> 2001-12-17  Robret Collins  <rbtcollins@hotmail.com>
>
> * include/commctrl.h: New typedefs for HDLAYOUT and LPHDLAYOUT based
> on MSDN documentation for XP.
>
> added a new struct _HDITEM, which has a UNICODED field (LPTSTR
pszText) in
> it. However, some code expects to have explicit HDITEMA and HDITEMW
> structures.  Since the the new structure is essantially a replacement
> (since IE 3.0) for old HD_ITEM[AW], wouldn't following make more sense
> (second part of attached patch).  I'm also suggesting same approach
for
> NMLISTVIEW.

Wuoting from MSDN:
"typedef struct _HDITEM {
    UINT    mask;
    int     cxy;
    LPTSTR  pszText;
    HBITMAP hbm;
    int     cchTextMax;
    int     fmt;
    LPARAM  lParam;
#if (_WIN32_IE >= 0x0300)
    int     iImage;
    int     iOrder;
#endif
#if (_WIN32_IE >= 0x0500)
    UINT    type;
    LPVOID  pvFilter;
#endif
} HDITEM, *LPHDITEM;
"

I've no set opinion, as long as setup still builds :}.

Rob
