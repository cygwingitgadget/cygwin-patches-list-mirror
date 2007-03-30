Return-Path: <cygwin-patches-return-6052-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2370 invoked by alias); 30 Mar 2007 22:42:36 -0000
Received: (qmail 2354 invoked by uid 22791); 30 Mar 2007 22:42:35 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.codesourcery.com (HELO mail.codesourcery.com) (65.74.133.4)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 30 Mar 2007 23:42:33 +0100
Received: (qmail 12699 invoked from network); 30 Mar 2007 22:42:32 -0000
Received: from unknown (HELO ?192.168.0.2?) (mitchell@127.0.0.2)   by mail.codesourcery.com with ESMTPA; 30 Mar 2007 22:42:32 -0000
Message-ID: <460D9252.3090708@codesourcery.com>
Date: Fri, 30 Mar 2007 22:42:00 -0000
From: Mark Mitchell <mark@codesourcery.com>
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
MIME-Version: 1.0
To: Mark Mitchell <mark@codesourcery.com>
CC:  cygwin-patches@cygwin.com
Subject: Re: PATCH: Fix resource leak in cygpath.cc
References: <460D91AE.8030203@codesourcery.com>
In-Reply-To: <460D91AE.8030203@codesourcery.com>
Content-Type: multipart/mixed;  boundary="------------090704010305090804010600"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00033.txt.bz2

This is a multi-part message in MIME format.
--------------090704010305090804010600
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 782

Mark Mitchell wrote:
> The cygpath utility calls FindFirstFile, but never calls FindClose.  As
> a result, in leaks search handles.  When you're using it for just one
> file, that's not a big deal, but if you feed it enough files, it gets
> unhappy.  Also, if you've got a long running cygpath in one window, you
> can't do file renames in named directories in another because cygpath
> still has the handles open.
> 
> Here's a patch.  I don't claim to have tested this in any comprehensive
> way, but I've played with it, and it fixes the problems I've been seeing.
> 
> Hope this helps,

Bleck!  My first posting on this list, and I rudely attached the wrong
file.  I'm very sorry.

Here's the right one.

-- 
Mark Mitchell
CodeSourcery
mark@codesourcery.com
(650) 331-3385 x713

--------------090704010305090804010600
Content-Type: text/plain;
 name="cygpath.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygpath.patch"
Content-length: 705

2007-03-30  Mark Mitchell  <mark@codesourcery.com>

	* utils/cygpath.cc (get_long_path_name_w32impl): Close handles
	returned by FindFirstFile.

--- /home/mitchell/Desktop/cygpath.cc	2007-03-30 15:26:57.339051200 -0700
+++ cygpath.cc	2007-03-30 14:16:39.474059200 -0700
@@ -375,8 +375,13 @@ get_long_path_name_w32impl (LPCSTR src, 
       ptr[len] = 0;
       if (next[1] != ':' && strcmp(next, ".") && strcmp(next, ".."))
 	{
-	  if (FindFirstFile (buf2, &w32_fd) != INVALID_HANDLE_VALUE)
+	  HANDLE h;
+	  h = FindFirstFile (buf2, &w32_fd);
+	  if (h != INVALID_HANDLE_VALUE)
+	    {
 	    strcpy (ptr, w32_fd.cFileName);
+	      FindClose (h);
+	    }
 	}
       ptr += strlen (ptr);
       if (pelem)

--------------090704010305090804010600--
