Return-Path: <cygwin-patches-return-2714-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19905 invoked by alias); 25 Jul 2002 15:47:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19890 invoked from network); 25 Jul 2002 15:47:56 -0000
Date: Thu, 25 Jul 2002 08:47:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: qt patch for winnt.h
Message-ID: <20020725154806.GE10541@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3D401950.1070803@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D401950.1070803@netscape.net>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00162.txt.bz2

On Thu, Jul 25, 2002 at 11:29:20AM -0400, Nicholas Wourms wrote:
>2002-07-25  Nicholas Wourms  <nwourms@netscape.net>
>
>    * winnt.h (HANDLE): Add guard for compiling qt.

I really think this sets an incredibly bad precedent.  Littering the
system headers with project specific defines is really distasteful
to me.

This is Danny's call, though.

cgf

>Index: winnt.h
>===================================================================
>RCS file: /cvs/src/src/winsup/w32api/include/winnt.h,v
>retrieving revision 1.52
>diff -u -3 -p -u -p -r1.52 winnt.h
>--- winnt.h 17 Jul 2002 03:37:45 -0000  1.52
>+++ winnt.h 25 Jul 2002 15:09:11 -0000
>@@ -108,7 +108,11 @@ typedef const TCHAR *LPCTSTR;
> #define TEXT(q) __TEXT(q)    
> typedef SHORT *PSHORT;
> typedef LONG *PLONG;
>+#ifndef QT_CYGWIN  /* To allow qt to compile under Cygwin */
> typedef void *HANDLE;
>+#else
>+typedef unsigned int HANDLE;
>+#endif /* QT_CYGWIN */
> typedef HANDLE *PHANDLE,*LPHANDLE;
> #ifdef STRICT
> #define DECLARE_HANDLE(n) typedef struct n##__{int i;}*n
