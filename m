Return-Path: <cygwin-patches-return-6035-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6774 invoked by alias); 8 Mar 2007 23:44:55 -0000
Received: (qmail 6763 invoked by uid 22791); 8 Mar 2007 23:44:55 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-54.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.54)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 08 Mar 2007 23:44:51 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 8397D13C01F; Thu,  8 Mar 2007 18:44:49 -0500 (EST)
Date: Thu, 08 Mar 2007 23:44:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Bug in pread/pwrite ?
Message-ID: <20070308234449.GA7745@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.LNX.4.64.0703082349050.17686@adsl.cgsecurity.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703082349050.17686@adsl.cgsecurity.org>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00016.txt.bz2

On Fri, Mar 09, 2007 at 12:05:47AM +0100, Christophe GRENIER wrote:
>After upgrading my compiler from cygwin 1.5.17-1 to 1.5.24-2, TestDisk
>& PhotoRec, my GPL data recovery programs, were unable to read data!

Please calm down.

>I have written a little program (see attachment) to reproduce the
>problem.  As administrator, run "test_pread /dev/sda".
>
>The program use lseek() to go the disk end, the function failed.  Now
>pread will now always failed, because it ends (cf
>cygwin-1.5.24-2/newlib/libc/unix/pread.c) by an lseek to the backuped
>location.  The same problem also applies to pwrite.
>
>I don't know if the following patch is a good idea:

Patches sent here are really supposed to be tested.  You obviously
didn't test this because your proposed patch doesn't modify a function
that Cygwin actually uses.

The pread() that Cygwin does uses is in fhandler_disk_file.cc.

All of that aside, I don't see how ignoring an lseek() failure
could be considered to be a good thing.

cgf
