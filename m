Return-Path: <cygwin-patches-return-2719-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 22609 invoked by alias); 25 Jul 2002 17:40:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22594 invoked from network); 25 Jul 2002 17:40:40 -0000
Date: Thu, 25 Jul 2002 10:40:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: qt patch for winnt.h
Message-ID: <20020725174050.GE2281@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3D401950.1070803@netscape.net> <20020725154806.GE10541@redhat.com> <3D40323A.1070609@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D40323A.1070609@netscape.net>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q3/txt/msg00167.txt.bz2

On Thu, Jul 25, 2002 at 01:15:38PM -0400, Nicholas Wourms wrote:
>Christopher Faylor wrote:
>
>>On Thu, Jul 25, 2002 at 11:29:20AM -0400, Nicholas Wourms wrote:
>>
>>>2002-07-25  Nicholas Wourms  <nwourms@netscape.net>
>>>
>>>  * winnt.h (HANDLE): Add guard for compiling qt.
>>>
>>
>>I really think this sets an incredibly bad precedent.  Littering the
>>system headers with project specific defines is really distasteful
>>to me.
>>
>Ok,
>
>Perhaps you would prefer this better.  I changed the ifdef to be 
>feature-centric as opposed to project-centric.  Perhaps this is a little 
>more to your liking?

I do prefer feature-centric ifdefs, but I don't think that adding this
particular definition of HANDLE to the windows headers makes sense.
I'd rather see something like a "DONT_DEFINE_HANDLE" define and have
the handle defined elsewhere.

Isn't it possible to protect the handle with a define somewhere prior
to calling winnt.h and then undefine it after the includes?

I don't understand why the project needs a non-standard definition for
HANDLE unless they are using it in some other context than the Windows
one.  It is defined as a void * in my MSVC headers so why would
anyone try to use anything else?

cgf


>Cheers,
>Nicholas

>2002-07-25  Nicholas Wourms  <nwourms@netscape.net>
>
>    * winnt.h (HANDLE): Allow uint type for HANDLE.

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
>+#ifndef WINNT_H_UINT_HANDLE    /* Allow uint typedef for HANDLE  */
> typedef void *HANDLE;
>+#else
>+typedef unsigned int HANDLE;
>+#endif /* WINNT_H_UINT_HANDLE */
> typedef HANDLE *PHANDLE,*LPHANDLE;
> #ifdef STRICT
> #define DECLARE_HANDLE(n) typedef struct n##__{int i;}*n
