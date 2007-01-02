Return-Path: <cygwin-patches-return-6020-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9944 invoked by alias); 2 Jan 2007 18:46:01 -0000
Received: (qmail 9931 invoked by uid 22791); 2 Jan 2007 18:45:59 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-54.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.54)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 02 Jan 2007 18:45:55 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 903B413C042; Tue,  2 Jan 2007 13:45:51 -0500 (EST)
Date: Tue, 02 Jan 2007 18:46:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Increase st_blksize to 64k
Message-ID: <20070102184551.GA18182@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0701021158490.2464@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0701021158490.2464@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00001.txt.bz2

On Tue, Jan 02, 2007 at 12:04:49PM -0600, Brian Ford wrote:
>As suggested here:
>
>http://cygwin.com/ml/cygwin/2006-12/msg00911.html
>
>2007-01-02  Brian Ford  <Brian.Ford@FlightSafety.com>
>
>	* fhandler.cc (fhandler_base::fstat): Use system page size (64k)
>	as the st_blksize prefered I/O size for improved performance.
>	* fhandler_disk_file.cc (fhandler_base::fstat_helper): Likewise.

I don't see how replacing the constant "S_BLKSIZE" with what seems to be
an unrelated getpagesize () makes a lot of sense.  Assuming that this is
a good idea, should S_BLKSIZE be changed directly?

cgf

>Index: fhandler.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/fhandler.cc,v
>retrieving revision 1.273
>diff -u -p -r1.273 fhandler.cc
>--- fhandler.cc	11 Dec 2006 18:55:28 -0000	1.273
>+++ fhandler.cc	2 Jan 2007 17:55:07 -0000
>@@ -1328,7 +1328,7 @@ fhandler_base::fstat (struct __stat64 *b
>   buf->st_uid = geteuid32 ();
>   buf->st_gid = getegid32 ();
>   buf->st_nlink = 1;
>-  buf->st_blksize = S_BLKSIZE;
>+  buf->st_blksize = getpagesize ();
>   time_as_timestruc_t (&buf->st_ctim);
>   buf->st_atim = buf->st_mtim = buf->st_ctim;
>   return 0;
>Index: fhandler_disk_file.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
>retrieving revision 1.200
>diff -u -p -r1.200 fhandler_disk_file.cc
>--- fhandler_disk_file.cc	21 Dec 2006 10:59:47 -0000	1.200
>+++ fhandler_disk_file.cc	2 Jan 2007 17:55:07 -0000
>@@ -436,7 +436,7 @@ fhandler_base::fstat_helper (struct __st
>   else
>     buf->st_ino = get_namehash ();
> 
>-  buf->st_blksize = S_BLKSIZE;
>+  buf->st_blksize = getpagesize ();
> 
>   if (nAllocSize >= 0LL)
>     /* A successful NtQueryInformationFile returns the allocation size
