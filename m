Return-Path: <cygwin-patches-return-6935-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22048 invoked by alias); 1 Feb 2010 19:59:57 -0000
Received: (qmail 22036 invoked by uid 22791); 1 Feb 2010 19:59:56 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from ey-out-1920.google.com (HELO ey-out-1920.google.com) (74.125.78.150)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 01 Feb 2010 19:59:50 +0000
Received: by ey-out-1920.google.com with SMTP id 3so934603eyh.2         for <cygwin-patches@cygwin.com>; Mon, 01 Feb 2010 11:59:47 -0800 (PST)
Received: by 10.213.25.75 with SMTP id y11mr5015986ebb.5.1265054387485;         Mon, 01 Feb 2010 11:59:47 -0800 (PST)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 10sm10846313eyd.21.2010.02.01.11.59.45         (version=SSLv3 cipher=RC4-MD5);         Mon, 01 Feb 2010 11:59:46 -0800 (PST)
Message-ID: <4B6736C1.8030101@gmail.com>
Date: Mon, 01 Feb 2010 19:59:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: Dave Korn <dave.korn.cygwin@googlemail.com>
CC: cygwin-patches@cygwin.com
Subject: Re: dlclose not calling destructors of static variables.
References: <4B61732F.4030804@gmail.com>  <4B62DDE6.5070106@gmail.com>  <4B62F118.8010305@gmail.com>  <20100129184514.GA9550@ednor.casa.cgf.cx>  <4B66BF2F.4060802@gmail.com>  <20100201162603.GB25374@ednor.casa.cgf.cx>  <4B6710CE.40300@gmail.com>  <20100201174611.GA26080@ednor.casa.cgf.cx> <20100201175123.GB26080@ednor.casa.cgf.cx> <4B672B74.4090808@gmail.com>
In-Reply-To: <4B672B74.4090808@gmail.com>
Content-Type: multipart/mixed;  boundary="------------010302040405050401090605"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00051.txt.bz2

This is a multi-part message in MIME format.
--------------010302040405050401090605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1627

On 01/02/2010 19:28, Dave Korn wrote:
> On 01/02/2010 17:51, Christopher Faylor wrote:
>> On Mon, Feb 01, 2010 at 12:46:11PM -0500, Christopher Faylor wrote:
> 
>>>> Cribbing from the gdb source code, it looks like they use BaseAddrees + 
>>>> 0x1000 for the start point and then call GetModuleInformation to workout 
>>>> the size of the module.
>>> Yeah, duh.  "they" == "me".  I should have checked gdb for this since I've
>>> already done this research once before.
>>>
>>> If you do find that this works, then I think this may fall into the
>>> realm of a non-trivial patch so it may be best to just tell me what
>>> you've found rather than provide a patch - unless you want to go through
>>> the approval process with Red Hat.
>>>
>>> Or, you can just wait for me to adapt what's in gdb to cygwin.  I can do
>>> tonight when I get back to a windows system.
>> Btw, it isn't entirely clear that GetModuleInformation will work with
>> older versions of Windows NT so this may not be a complete solution.  We
>> do use GetModuleInformation in Cygwin but it is not in anything as
>> crucial as this.
> 
>   Can't we use the info in the dll struct?  It has pointers to the data and
> bss section, we could take the max out of them and the data in the M_B_I
> struct.  (Tell you what, I'll try it.)

  Yep, that makes the original testcase work for me.  How about it?

winsup/cygwin/ChangeLog:


	* dll_init.cc (remove_dll_atexit): Take pointer to dll and
	estimate end of dll more generously.
	(dll_list::detach): Update caller.

  (This is just the first patch on its way relating to this subject.)

    cheers,
      DaveK

--------------010302040405050401090605
Content-Type: text/x-c;
 name="mbi-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mbi-fix.diff"
Content-length: 1307

Index: dll_init.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dll_init.cc,v
retrieving revision 1.68
diff -p -u -r1.68 dll_init.cc
--- dll_init.cc	29 Jan 2010 18:34:09 -0000	1.68
+++ dll_init.cc	1 Feb 2010 19:55:10 -0000
@@ -153,11 +153,15 @@ dll_list::alloc (HINSTANCE h, per_proces
    register an atexit function outside of the DLL and that should be
    run when the DLL detachs.  */
 static void
-remove_dll_atexit (MEMORY_BASIC_INFORMATION& m)
+remove_dll_atexit (const MEMORY_BASIC_INFORMATION& m, const dll *d)
 {
   unsigned char *dll_beg = (unsigned char *) m.AllocationBase;
   unsigned char *dll_end = (unsigned char *) m.AllocationBase + m.RegionSize;
   struct _atexit *p = _GLOBAL_REENT->_atexit;
+  if (dll_end < d->p.data_end)
+    dll_end = (unsigned char *) d->p.data_end;
+  if (dll_end < d->p.bss_end)
+    dll_end = (unsigned char *) d->p.bss_end;
   for (int n = p->_ind - 1; n >= 0; n--)
     {
       void (*fn) (void) = p->_fns[n];
@@ -188,7 +192,7 @@ dll_list::detach (void *retaddr)
       system_printf ("WARNING: trying to detach an already detached dll ...");
     else if (--d->count == 0)
       {
-	remove_dll_atexit (m);
+	remove_dll_atexit (m, d);
 	d->run_dtors ();
 	d->prev->next = d->next;
 	if (d->next)

--------------010302040405050401090605--
