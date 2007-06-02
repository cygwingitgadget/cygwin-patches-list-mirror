Return-Path: <cygwin-patches-return-6110-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25583 invoked by alias); 2 Jun 2007 23:27:54 -0000
Received: (qmail 25567 invoked by uid 22791); 2 Jun 2007 23:27:54 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 02 Jun 2007 23:27:52 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1Hud0g-00089x-Iz 	for cygwin-patches@cygwin.com; Sat, 02 Jun 2007 23:27:50 +0000
Message-ID: <4661FD22.BE882CE7@dessent.net>
Date: Sat, 02 Jun 2007 23:27:00 -0000
From: Brian Dessent <brian@dessent.net>
Reply-To: cygwin-patches@cygwin.com
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] "strace ./app.exe" probably runs application from /bin
References: <466183F3.5020900@t-online.de> <20070602154156.GA19696@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
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
X-SW-Source: 2007-q2/txt/msg00056.txt.bz2

Christopher Faylor wrote:

> Let me rephrase the problem:
> 
> "cygpath does not properly deal with the current directory"
> 
> Thanks for the patch but we won't be applying it in this form.

I've been meaning to take a look at fixing this myself, because I'm
tired of:

$ cd /usr/bin

$ cygcheck ./ls
.\.\.\.\ - Cannot open

$ cygcheck ls
 - Cannot open
Error: could not find ls

$ cygcheck ls.exe
 - Cannot open
Error: could not find ls.exe

$ cygcheck ./ls.exe
.\ls.exe
  .\cygwin1.dll
    C:\WINXP\system32\ADVAPI32.DLL
      C:\WINXP\system32\ntdll.dll
      C:\WINXP\system32\KERNEL32.dll
      C:\WINXP\system32\RPCRT4.dll
  .\cygintl-8.dll
    .\cygiconv-2.dll

Brian
