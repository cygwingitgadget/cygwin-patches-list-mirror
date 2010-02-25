Return-Path: <cygwin-patches-return-6975-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27799 invoked by alias); 25 Feb 2010 13:14:04 -0000
Received: (qmail 27776 invoked by uid 22791); 25 Feb 2010 13:14:03 -0000
X-SWARE-Spam-Status: No, hits=-1.0 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,HK_OBFDOMREQ
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f211.google.com (HELO mail-fx0-f211.google.com) (209.85.220.211)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 25 Feb 2010 13:13:58 +0000
Received: by fxm3 with SMTP id 3so3263555fxm.18         for <cygwin-patches@cygwin.com>; Thu, 25 Feb 2010 05:13:55 -0800 (PST)
Received: by 10.223.65.12 with SMTP id g12mr1122540fai.69.1267103635136;         Thu, 25 Feb 2010 05:13:55 -0800 (PST)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 15sm319253fxm.4.2010.02.25.05.13.52         (version=SSLv3 cipher=RC4-MD5);         Thu, 25 Feb 2010 05:13:53 -0800 (PST)
Message-ID: <4B867BBF.4010700@gmail.com>
Date: Thu, 25 Feb 2010 13:14:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Statically initialising pthread attributes in dynamic dlls.
References: <4B825D76.6000105@gmail.com>  <4B82C093.7010001@gmail.com>  <4B83A727.3030101@gmail.com>  <4B841026.1000905@gmail.com>  <20100224004403.GA24591@ednor.casa.cgf.cx>  <4B848353.2010209@gmail.com>  <4B84B08C.7060302@gmail.com>  <4B84B887.6070801@gmail.com>  <4B856401.2000905@gmail.com> <20100224214459.GA19766@ednor.casa.cgf.cx>
In-Reply-To: <20100224214459.GA19766@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------090502020604000908030005"
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
X-SW-Source: 2010-q1/txt/msg00091.txt.bz2

This is a multi-part message in MIME format.
--------------090502020604000908030005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 816

On 24/02/2010 21:44, Christopher Faylor wrote:

> Hmm.  That would presumably cause the behavior that Dave Korn noted of
> removing the handler after FreeLibrary returns.  So you'd have to put it
> there and in dlclose.  

  The temporary handler in dll_dllcrt0_1 approach seems an awful lot simpler
and more reliable to me than all this tedious mucking about in hyperspace...
erm, I mean all this tedious unlinking and relinking the chain and hoping
nothing bad happens during the window when we have no handler installed at
all.  Why don't we just fix it this way instead?

winsup/cygwin/ChangeLog:

	* dll_init.cc (dll_dllcrt0_1): Install a temporary SEH frame instead
	of redirecting the global registration.
	* dlfcn.cc (dlopen): Revert last change rendered superfluous by the
	above.

    cheers,
      DaveK


--------------090502020604000908030005
Content-Type: text/x-c;
 name="dlopen-seh-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dlopen-seh-fix.diff"
Content-length: 4306

Index: winsup/cygwin/dll_init.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dll_init.cc,v
retrieving revision 1.70
diff -p -u -r1.70 dll_init.cc
--- winsup/cygwin/dll_init.cc	5 Feb 2010 15:05:22 -0000	1.70
+++ winsup/cygwin/dll_init.cc	25 Feb 2010 12:32:00 -0000
@@ -322,14 +322,51 @@ dll_dllcrt0_1 (VOID *x)
   per_process*& p = ((dllcrt0_info *)x)->p;
   int& res = ((dllcrt0_info *)x)->res;
 
-  /* Make sure that our exception handler is installed.
-     That should always be the case but this just makes sure.
+  /* Make sure that our exception handler is installed.  Those few
+     simple words unlock a not nearly so simple can of worms.
 
-     At some point, we may want to just remove this code since
-     the exception handler should be guaranteed to be installed.
-     I'm leaving it in until potentially after the release of
-     1.7.1 */
-  _my_tls.init_exception_handler (_cygtls::handle_exceptions);
+     This function is part of every Cygwin-based DLL's C runtime
+     startup sequence, called from the DllMain implementation in
+     DECLARE_CYGWIN_DLL at process attach notification time.  This
+     can arise in one of two ways: at initial process startup when the
+     statically-linked DLLs are being mapped, or as a result of a call
+     to dlopen() at runtime.
+
+     In the first case, the cygwin DLL may not have been initialised
+     yet, and our exception handler may or may not yet be installed.
+     In the second case, it is definitely installed, but the OS runtime
+     loader has installed its own SEH handlers ahead of ours.
+
+     That's a problem; we need ours to be the first, not just for signal
+     handling (which is probably irrelevant, as you shouldn't try anything
+     too complex inside a DllMain function when the OS loader lock is held)
+     but also to support the sjfault-handling/verifyable_object mechanism.
+
+     Earlier versions of the code called _cygtls::init_exception_handler
+     here, but that is problematic.  There is only a single exception_list
+     member in the _cygtls class that we use to register our SEH handler,
+     and in order to reuse it to add at the head of the SEH chain, it would
+     either have to create a loop in the list, or unlink it from its original
+     earlier position in the list.  The former is disallowed by the SEH chain
+     validation performed for security reasons on modern versions of the OS;
+     the latter works fine, but it gets implicitly unlinked when we return 
+     from this function, as the OS loader removes its own frames, and the
+     main application then carries on without any SEH handler installed,
+     breaking the world.
+
+     We could try temporarily moving it to the head of the list, marking
+     the original position, and moving it back there before we return from
+     here, but the simplest solution is to just install a regular stack-
+     based EH frame right here, and unwind it when we leave.  (We don't want
+     to leave it to be implicitly unwound when the OS loader unwinds its
+     own frames, as there would be at least a short window while the SEH
+     chain was invalid.)  */
+
+  extern exception_list *_except_list asm ("%fs:0");
+  exception_list seh;
+  seh.handler = _cygtls::handle_exceptions;
+  seh.prev = _except_list;
+  _except_list = &seh;
 
   if (p == NULL)
     p = &__cygwin_user_data;
@@ -390,6 +427,9 @@ dll_dllcrt0_1 (VOID *x)
     res = -1;
   else
     res = (DWORD) d;
+
+  /* Finally unwind our SEH handler before returning.  */
+  _except_list = seh.prev;
 }
 
 /* OBSOLETE: This function is obsolete and will go away in the
Index: winsup/cygwin/dlfcn.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dlfcn.cc,v
retrieving revision 1.44
diff -p -u -r1.44 dlfcn.cc
--- winsup/cygwin/dlfcn.cc	24 Feb 2010 08:03:44 -0000	1.44
+++ winsup/cygwin/dlfcn.cc	25 Feb 2010 12:32:00 -0000
@@ -109,9 +109,6 @@ dlopen (const char *name, int)
 
 	  ret = (void *) LoadLibraryW (path);
 
-	  /* In case it was removed by LoadLibrary. */
-	  _my_tls.init_exception_handler (_cygtls::handle_exceptions);
-
 	  /* Restore original cxx_malloc pointer. */
 	  __cygwin_user_data.cxx_malloc = tmp_malloc;
 

--------------090502020604000908030005--
