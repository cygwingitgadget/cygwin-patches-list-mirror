Return-Path: <cygwin-patches-return-2718-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8774 invoked by alias); 25 Jul 2002 17:15:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8719 invoked from network); 25 Jul 2002 17:15:57 -0000
Message-ID: <3D40323A.1070609@netscape.net>
Date: Thu, 25 Jul 2002 10:15:00 -0000
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0rc2) Gecko/20020512 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: qt patch for winnt.h
References: <3D401950.1070803@netscape.net> <20020725154806.GE10541@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------010704020407020605020303"
X-SW-Source: 2002-q3/txt/msg00166.txt.bz2


--------------010704020407020605020303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 542

Christopher Faylor wrote:

>On Thu, Jul 25, 2002 at 11:29:20AM -0400, Nicholas Wourms wrote:
>
>>2002-07-25  Nicholas Wourms  <nwourms@netscape.net>
>>
>>   * winnt.h (HANDLE): Add guard for compiling qt.
>>
>
>I really think this sets an incredibly bad precedent.  Littering the
>system headers with project specific defines is really distasteful
>to me.
>
Ok,

Perhaps you would prefer this better.  I changed the ifdef to be 
feature-centric as opposed to project-centric.  Perhaps this is a little 
more to your liking?

Cheers,
Nicholas

--------------010704020407020605020303
Content-Type: text/plain;
 name="ChangeLog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ChangeLog.txt"
Content-length: 105

2002-07-25  Nicholas Wourms  <nwourms@netscape.net>

    * winnt.h (HANDLE): Allow uint type for HANDLE.

--------------010704020407020605020303
Content-Type: text/plain;
 name="winnt.h-handle.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="winnt.h-handle.diff"
Content-length: 682

Index: winnt.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/winnt.h,v
retrieving revision 1.52
diff -u -3 -p -u -p -r1.52 winnt.h
--- winnt.h 17 Jul 2002 03:37:45 -0000  1.52
+++ winnt.h 25 Jul 2002 15:09:11 -0000
@@ -108,7 +108,11 @@ typedef const TCHAR *LPCTSTR;
 #define TEXT(q) __TEXT(q)    
 typedef SHORT *PSHORT;
 typedef LONG *PLONG;
+#ifndef WINNT_H_UINT_HANDLE    /* Allow uint typedef for HANDLE  */
 typedef void *HANDLE;
+#else
+typedef unsigned int HANDLE;
+#endif /* WINNT_H_UINT_HANDLE */
 typedef HANDLE *PHANDLE,*LPHANDLE;
 #ifdef STRICT
 #define DECLARE_HANDLE(n) typedef struct n##__{int i;}*n

--------------010704020407020605020303--
