Return-Path: <cygwin-patches-return-2338-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 17377 invoked by alias); 6 Jun 2002 13:09:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17333 invoked from network); 6 Jun 2002 13:09:13 -0000
Date: Thu, 06 Jun 2002 06:09:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch for sub-second resolution in stat(2)
Message-ID: <20020606150911.A22789@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <01ae01c20cf5$551007f0$6132bc3e@BABEL> <20020606013947.GB851@redhat.com> <025101c20cfd$930b0f70$6132bc3e@BABEL> <032201c20d55$73b57bd0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <032201c20d55$73b57bd0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00321.txt.bz2

On Thu, Jun 06, 2002 at 01:26:57PM +0100, Conrad Scott wrote:
> Oh sh*t. It turns out that my changelog entry was more broken than just
> formatting. I've appended and attached a new one to this email (the
> attachment is because I'm unclear that Outlook Express keeps the
> formatting).
> 
> Sorry for imposing my sordid learning experience on everyone.
> 
> // Conrad
> 
> 2002-06-05  Conrad Scott  <conrad.scott@dsl.pipex.com>
> 
>  * fhandler.cc (fhandler_base::fstat): Initialise tv_nsec member of
>  st_atim, st_mtim, and st_ctim fields.
>  * fhandler_disk_file.cc (fhandler_disk_file::fstat_helper): Ditto.
>  * fhandler_process.cc (fhandler_process::fstat): Ditto.
>  * glob.c (stat32_to_STAT): Copy across the whole st_atim,
>  st_mtime, and st_ctim fields.
>  * syscalls.cc (stat64_to_stat32): Ditto.
>  * times.cc (to_timestruc_t): New function.
>  (time_as_timestruc_t): New function.
>  * winsup.h: Add to_timestruc_t and time_as_timestruc_t functions.
>  * include/cygwin/stat.h: Replace time_t with timestruc_t
>  throughout for all file times, removing the st_spare1, st_spare2,
>  and st_spare3 fields in the process. Add macros to access tv_sec
>  fields by old names.

 ^^
 If you now substitute the leading space by a leading TAB, the
 ChangeLog entry would be correct.

;-)
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
