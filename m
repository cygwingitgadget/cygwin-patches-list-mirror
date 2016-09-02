Return-Path: <cygwin-patches-return-8634-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31799 invoked by alias); 2 Sep 2016 10:23:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 31787 invoked by uid 89); 2 Sep 2016 10:23:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=mechanisms, createprocess, CreateProcess, HTo:U*cygwin-patches
X-HELO: smtp.salomon.at
Received: from smtp.salomon.at (HELO smtp.salomon.at) (193.186.16.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 02 Sep 2016 10:22:58 +0000
Received: from samail03.wamas.com ([172.28.33.235] helo=mailhost.salomon.at)	by smtp.salomon.at with esmtps (UNKNOWN:DHE-RSA-AES256-SHA:256)	(Exim 4.80.1)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1bflcd-0001l2-87	for cygwin-patches@cygwin.com; Fri, 02 Sep 2016 12:22:55 +0200
Received: from s01en24.wamas.com ([172.28.41.34])	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1bflcc-0004bO-KJ	for cygwin-patches@cygwin.com; Fri, 02 Sep 2016 12:22:54 +0200
Subject: Re: [PATCH 4/4] dlopen: on unspecified lib dir search exe dir
To: cygwin-patches@cygwin.com
References: <1472666829-32223-1-git-send-email-michael.haubenwallner@ssi-schaefer.com> <1472666829-32223-5-git-send-email-michael.haubenwallner@ssi-schaefer.com> <20160901140526.GF1128@calimero.vinschen.de>
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <12c1f823-1f30-18b7-ccd2-e944817391fb@ssi-schaefer.com>
Date: Fri, 02 Sep 2016 10:23:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160901140526.GF1128@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------EDAF4238918F8AE7BAEA747F"
X-SW-Source: 2016-q3/txt/msg00042.txt.bz2

This is a multi-part message in MIME format.
--------------EDAF4238918F8AE7BAEA747F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-length: 1876

Hi Corinna,

On 09/01/2016 04:05 PM, Corinna Vinschen wrote:
> On Aug 31 20:07, Michael Haubenwallner wrote:
>> Applications installed to some prefix like /opt/application do expect
>> dlopen("libAPP.so") to load "/opt/application/bin/cygAPP.dll", which
>> is similar to "/opt/application/lib/libAPP.so" on Linux.
>>
>> See also https://cygwin.com/ml/cygwin-developers/2016-08/msg00020.html
>>
>> * dlfcn.cc (dlopen): For dlopen("N"), search directory where the
>> application executable is in.
>> ---
>>  winsup/cygwin/dlfcn.cc | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/winsup/cygwin/dlfcn.cc b/winsup/cygwin/dlfcn.cc
>> index f8b8743..974092e 100644
>> --- a/winsup/cygwin/dlfcn.cc
>> +++ b/winsup/cygwin/dlfcn.cc
>> @@ -232,6 +232,12 @@ dlopen (const char *name, int flags)
>>  	     not use the LD_LIBRARY_PATH environment variable. */
>>  	  finder.add_envsearchpath ("LD_LIBRARY_PATH");
>>  
>> +	  /* Search the current executable's directory like
>> +	     the Windows loader does for linked dlls. */
>> +	  int exedirlen = get_exedir (cpath, wpath);
>> +	  if (exedirlen)
>> +	    finder.add_searchdir (cpath, exedirlen);
>> +
>>  	  /* Finally we better have some fallback. */
>>  	  finder.add_searchdir ("/usr/bin", 8);
>>  	  finder.add_searchdir ("/usr/lib", 8);
>> -- 
>> 2.7.3
> 
> Still not quite sure if that's the right thing to do...

Hmm... dlopen ought to be an API to the "runtime loader",
and as such it ought to use the same search algorithm as
exec (=CreateProcess) when searching for the linked dlls.

So as far as I understand: The Windows loader uses the main
executable's directory as kinda "embedded runpath" for process
startup, and dlopen is not the right place to change this - even
if LoadLibrary provides such mechanisms (Set/AddDllDirectory).

btw: Patch 4 updated to follow the update of patch 3.

Thanks!
/haubi/

--------------EDAF4238918F8AE7BAEA747F
Content-Type: text/x-patch;
 name="0004-dlopen-on-unspecified-lib-dir-search-exe-dir.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0004-dlopen-on-unspecified-lib-dir-search-exe-dir.patch"
Content-length: 1359

From a94e55a6ba366e960533c610464043afa0e8bff0 Mon Sep 17 00:00:00 2001
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Date: Wed, 31 Aug 2016 18:25:13 +0200
Subject: [PATCH 4/4] dlopen: on unspecified lib dir search exe dir

Applications installed to some prefix like /opt/application do expect
dlopen("libAPP.so") to load "/opt/application/bin/cygAPP.dll", which
is similar to "/opt/application/lib/libAPP.so" on Linux.

See also https://cygwin.com/ml/cygwin-developers/2016-08/msg00020.html

* dlfcn.cc (dlopen): For dlopen("N"), search directory where the
application executable is in.
---
 winsup/cygwin/dlfcn.cc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/winsup/cygwin/dlfcn.cc b/winsup/cygwin/dlfcn.cc
index 3b07208..c5839a7 100644
--- a/winsup/cygwin/dlfcn.cc
+++ b/winsup/cygwin/dlfcn.cc
@@ -232,6 +232,12 @@ dlopen (const char *name, int flags)
 	     not use the LD_LIBRARY_PATH environment variable. */
 	  finder.add_envsearchpath ("LD_LIBRARY_PATH");
 
+	  /* Search the current executable's directory like
+	     the Windows loader does for linked dlls. */
+	  int exedirlen = get_exedir (cpath);
+	  if (exedirlen)
+	    finder.add_searchdir (cpath, exedirlen);
+
 	  /* Finally we better have some fallback. */
 	  finder.add_searchdir ("/usr/bin", 8);
 	  finder.add_searchdir ("/usr/lib", 8);
-- 
2.8.3


--------------EDAF4238918F8AE7BAEA747F--
