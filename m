Return-Path: <cygwin-patches-return-6112-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30253 invoked by alias); 3 Jun 2007 16:21:14 -0000
Received: (qmail 30228 invoked by uid 22791); 3 Jun 2007 16:21:14 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout03.sul.t-online.com (HELO mailout03.sul.t-online.com) (194.25.134.81)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 03 Jun 2007 16:21:12 +0000
Received: from fwd35.aul.t-online.de  	by mailout03.sul.t-online.com with smtp  	id 1HuspI-0007sj-03; Sun, 03 Jun 2007 18:21:08 +0200
Received: from [10.3.2.2] (TF9SAGZEoe3MzXc4KJOWnXE+kFlBxub6QIch7FDA1326G7XmRGkK8i@[217.235.234.52]) by fwd35.sul.t-online.de 	with esmtp id 1HuspG-1xvoYq0; Sun, 3 Jun 2007 18:21:06 +0200
Message-ID: <4662EA78.3060506@t-online.de>
Date: Sun, 03 Jun 2007 16:21:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.2pre) Gecko/20070111 SeaMonkey/1.1
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch] "strace ./app.exe" probably runs application from /bin
References: <466183F3.5020900@t-online.de> <20070602154156.GA19696@ednor.casa.cgf.cx> <4661FD22.BE882CE7@dessent.net>
In-Reply-To: <4661FD22.BE882CE7@dessent.net>
Content-Type: multipart/mixed;  boundary="------------090209050604090803050004"
X-ID: TF9SAGZEoe3MzXc4KJOWnXE+kFlBxub6QIch7FDA1326G7XmRGkK8i
X-TOI-MSGID: e13dfe26-fd21-4f28-b977-3d1c85a570cb
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00058.txt.bz2

This is a multi-part message in MIME format.
--------------090209050604090803050004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1137

Brian Dessent wrote:
> Christopher Faylor wrote:
>
>   
>> Let me rephrase the problem:
>>
>> "cygpath does not properly deal with the current directory"
>>
>> Thanks for the patch but we won't be applying it in this form.
>>     
>
> I've been meaning to take a look at fixing this myself, because I'm
> tired of:
>
> $ cd /usr/bin
>
> $ cygcheck ./ls
> .\.\.\.\ - Cannot open
>
> $ cygcheck ls
>  - Cannot open
> Error: could not find ls
>
> $ cygcheck ls.exe
>  - Cannot open
> Error: could not find ls.exe
>
> $ cygcheck ./ls.exe
> .\ls.exe
>   .\cygwin1.dll
>     C:\WINXP\system32\ADVAPI32.DLL
>       C:\WINXP\system32\ntdll.dll
>       C:\WINXP\system32\KERNEL32.dll
>       C:\WINXP\system32\RPCRT4.dll
>   .\cygintl-8.dll
>     .\cygiconv-2.dll
>
>   

This is a different and subtle issue in cygcheck itself:

The init_path() routine adds cwd first.
add_path() does not add duplicate path names later.
If cwd is C:\cygwin\bin, it only appears in the sysdirs part of the path.

find_on_path(.,.,.,0) does never check a PATH component equal to cwd.

The attached patch is a quick hack (again, sorry ;-) to fix this.

Christian


--------------090209050604090803050004
Content-Type: text/plain;
 name="cygwin-1.5.24-2-cygcheck.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-1.5.24-2-cygcheck.patch.txt"
Content-length: 499

--- cygwin-1.5.24-2.orig/winsup/utils/cygcheck.cc	2006-02-08 15:19:40.001000000 +0100
+++ cygwin-1.5.24-2/winsup/utils/cygcheck.cc	2007-06-03 17:55:04.406250000 +0200
@@ -196,7 +196,7 @@ add_path (char *s, int maxlen)
   char *e = paths[num_paths] + strlen (paths[num_paths]);
   if (e[-1] == '\\' && e[-2] != ':')
     *--e = 0;
-  for (int i = 1; i < num_paths; i++)
+  for (int i = 2; i < num_paths; i++)
     if (strcasecmp (paths[num_paths], paths[i]) == 0)
       {
 	free (paths[num_paths]);

--------------090209050604090803050004--
