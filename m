Return-Path: <cygwin-patches-return-6552-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29750 invoked by alias); 4 Jul 2009 12:34:57 -0000
Received: (qmail 29739 invoked by uid 22791); 4 Jul 2009 12:34:56 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,J_CHICKENPOX_82,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f213.google.com (HELO mail-ew0-f213.google.com) (209.85.219.213)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 04 Jul 2009 12:34:49 +0000
Received: by ewy9 with SMTP id 9so3276300ewy.2         for <cygwin-patches@cygwin.com>; Sat, 04 Jul 2009 05:34:46 -0700 (PDT)
Received: by 10.210.118.14 with SMTP id q14mr3001227ebc.74.1246710886686;         Sat, 04 Jul 2009 05:34:46 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 5sm11214975eyf.12.2009.07.04.05.34.45         (version=SSLv3 cipher=RC4-MD5);         Sat, 04 Jul 2009 05:34:46 -0700 (PDT)
Message-ID: <4A4F4F5B.8090806@gmail.com>
Date: Sat, 04 Jul 2009 12:34:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: AttachConsole broken autoload
Content-Type: multipart/mixed;  boundary="------------080109040404070904070404"
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
X-SW-Source: 2009-q3/txt/msg00006.txt.bz2

This is a multi-part message in MIME format.
--------------080109040404070904070404
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1228


  Got this error when I tried to run with a DLL built from today's CVS HEAD:

> ---------------------------
> bash.exe - Entry Point Not Found
> ---------------------------
> The procedure entry point AttachConsole could not be located in the dynamic link library KERNEL32.dll. 
> ---------------------------
> OK   
> ---------------------------

  Checked that it doesn't exist on W2K:

http://msdn.microsoft.com/en-us/library/ms681952(VS.85).aspx
> Minimum supported client	Windows XP
> Minimum supported server	Windows Server 2003

  Something's gone wrong with the autoload definition, because here's the
reference:

> $ nm fhandler_console.o | grep AttachConsole
>          U _AttachConsole@4

... but here's the definition:

> $ nm autoload.o | grep AttachConsole
> 00000000 T _AttachConsole@0
> 00000000 T _win32_AttachConsole@0

... leading to the DLL still having an explicit import for it:

> $ dumpbin /imports new-cygwin1.dll | grep AttachConsole
>                    D  AttachConsole

  Attached patch looks like the obvious fix to me and builds a DLL without an
import for AttachConsole; resulting DLL loads and runs on W2k.  Ok?

	* autoload.cc (AttachConsole):  Correct size of args.

    cheers,
      DaveK


--------------080109040404070904070404
Content-Type: text/x-c;
 name="autoload-attachconsole-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="autoload-attachconsole-fix.diff"
Content-length: 674

Index: winsup/cygwin/autoload.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/autoload.cc,v
retrieving revision 1.161
diff -p -u -r1.161 autoload.cc
--- winsup/cygwin/autoload.cc	3 Jul 2009 10:50:51 -0000	1.161
+++ winsup/cygwin/autoload.cc	4 Jul 2009 12:27:59 -0000
@@ -409,7 +409,7 @@ LoadDLLfuncEx2 (SendARP, 16, iphlpapi, 1
 
 LoadDLLfunc (CoTaskMemFree, 4, ole32)
 
-LoadDLLfuncEx (AttachConsole, 0, kernel32, 1)
+LoadDLLfuncEx (AttachConsole, 4, kernel32, 1)
 LoadDLLfuncEx (FindFirstVolumeA, 8, kernel32, 1)
 LoadDLLfuncEx (FindNextVolumeA, 12, kernel32, 1)
 LoadDLLfuncEx (FindVolumeClose, 4, kernel32, 1)

--------------080109040404070904070404--
