Return-Path: <cygwin-patches-return-2329-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4344 invoked by alias); 6 Jun 2002 01:39:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4329 invoked from network); 6 Jun 2002 01:39:32 -0000
Date: Wed, 05 Jun 2002 18:39:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch for sub-second resolution in stat(2)
Message-ID: <20020606013947.GB851@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01ae01c20cf5$551007f0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01ae01c20cf5$551007f0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00312.txt.bz2

On Thu, Jun 06, 2002 at 01:58:55AM +0100, Conrad Scott wrote:
>Oh! and I hope the Changelog's a little better this time. Good enough?
>
>Changelog message:
>* fhandler.cc (fhandler_base::fstat): Initialise tv_nsec member of st_atim,
>st_mtim, st_ctim fields.
>* fhandler_disk_file.cc (fhandler_disk_file::fstat_helper): ditto.
>* fhandler_process.cc (fhandler_process::fstat): ditto.
>* glob.c (stat32_to_STAT): Copy across the whole st_atim. st_mtime, st_ctim
>fields.
>* syscalls.cc (stat64_to_stat32): ditto.
>* times.cc (to_timestruc_t time_as_timestruc_t): New functions.

The ChangeLog is closer, but still not complete.  You should provide a
*complete* ChangeLog, including time/date name, email address.  The entries
should also be capitalized ("Ditto."  not "ditto.").

If you can also indent the code, as per a normal ChangeLog, that is good,
too.

The goal is for this process to be as painless for the person applying the
patch as possible.  There are two reasons for this 1) It's nice to be nice
and 2) A patch reviewer is apt to be more interested in a patch if it looks
clean and requires little or no editing.  This means that your patch gets
applied faster and you get a reputation for submitting good patches (take
a bow Joshua).

There is no need to resubmit the ChangeLog with these trivial fixes but please
keep it in mind for your next submission.

Thanks, and now waiting for Corinna...

cgf
