Return-Path: <cygwin-patches-return-2323-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26200 invoked by alias); 6 Jun 2002 00:34:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26186 invoked from network); 6 Jun 2002 00:34:01 -0000
Date: Wed, 05 Jun 2002 17:34:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch for sub-second resolution in stat(2)
Message-ID: <20020606003415.GC15072@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <00ef01c20cf1$08974c20$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ef01c20cf1$08974c20$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00306.txt.bz2

On Thu, Jun 06, 2002 at 01:28:08AM +0100, Conrad Scott wrote:
>After Chris's exciting news that my assignment has reached RedHat, here's a
>patch!
>
>This adds sub-second resolution to the access, modification, and creation
>times returned by stat(2) etc. I thought this would make a nice companion to
>Corinna's work on making other things in stat(2) be 64-bit.
>
>Also, I was having trouble with a makefile where the commands could execute
>in less than a second leading to irregular breakage: this patch fixes that.
>
>I've checked that this maintains both source and binary compatibility (tho'
>it does add macros for st_mtime etc. to hide the indirection involved).

Nice.

>I'm unclear whether this is the best naming / type scheme but it is one
>recognised by both the make and fileutils packages available from the cygwin
>setup (i.e. make this patch and re-compile those packages and they detect
>the new fields).

As long as there's precedent...  Is this how linux does it too?

>I've provided two separate patches: one for types.h (in the newlib.patch)
>and one for the cygwin sources (in winsup.patch). The changelog entries are:
>
>newlib:
>
>Changelog message:
>* types.h (timespec_t timestruc_t): New typedefs.

newlib patches should be sent to the newlib mailing list.

>winsup/cygwin:
>
>Changelog message:
>* fhandler.cc (fhandler_base::fstat):
>* fhandler_disk_file.cc (fhandler_disk_file::fstat_helper):
>* fhandler_process.cc (*fhandler_process::fstat)
>* glob.c (stat32_to_STAT):

I see from your next message that you're probably sending a better
ChangeLog.  :-)

I'll let Corinna comment on the patch itself.  It looks good to me, but
she's been modifying this code a lot lately so she has a better feel for
it.

cgf
