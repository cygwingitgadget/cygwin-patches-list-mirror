Return-Path: <cygwin-patches-return-4052-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2274 invoked by alias); 9 Aug 2003 16:29:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2265 invoked from network); 9 Aug 2003 16:29:40 -0000
Date: Sat, 09 Aug 2003 16:29:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Checking integrity of installed packages in cygcheck
Message-ID: <20030809162939.GA9863@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.44.0308071843550.5132-200000@slinky.cs.nyu.edu> <20030809161211.GB9514@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030809161211.GB9514@redhat.com>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00068.txt.bz2

On Sat, Aug 09, 2003 at 12:12:11PM -0400, Christopher Faylor wrote:
>On Thu, Aug 07, 2003 at 06:50:10PM -0400, Igor Pechtchanski wrote:
>>Hi,
>>
>>This patch adds most of the capability of the script from
>><http://cygwin.com/ml/cygwin-apps/2003-08/msg00106.html> to cygcheck.
>>It is triggered by the "-c" flag to cygcheck.  "Integrity" is a rather
>>strong word, actually, as all this checks for is the existence of files
>>and directories, but this could be further built upon (for example, tar
>>has a diff option that could be useful).  The patch is against cvs HEAD
>>with my previous micropatch
>>(<http://cygwin.com/ml/cygwin-patches/2003-q3/msg00058.html>) applied.
>>Comments and suggestions welcome.
>
>I'm getting some odd errors when I apply this patch:
>
>"4NT: Unknown command f:"
>
>(as you can see I use 4NT).
>
>I haven't had time to debug where these are coming from but I get one
>for every file displayed.

The enclosed patch fixes that.

I'll check this in but it would be nice if (WBNI) this used a mingw gzip
library rather than calling gzip directly.  That's a fair amount of
work but I could resurrect the zlib library in winsup if necessary.

I wonder why setup is using gzip rather than bzip2 for the package files...

cgf

--- dump_setup.cc~	2003-08-07 21:42:02.000000000 -0400
+++ dump_setup.cc	2003-08-09 12:16:39.658996759 -0400
@@ -242,6 +242,8 @@ check_package_files (int verbose, char *
   strcat(strcat(filelist, package), ".lst.gz");
   char *zcat = cygpath("/bin/gzip.exe", NULL);
   char command[4096];
+  while (char *p = strchr (zcat, '/'))
+    *p = '\\';
   strcat(strcpy(command, zcat), filelist);
   FILE *fp = popen (command, "rt");
   char buf[4096];
