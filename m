Return-Path: <cygwin-patches-return-2337-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 24518 invoked by alias); 6 Jun 2002 12:25:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24494 invoked from network); 6 Jun 2002 12:25:29 -0000
Message-ID: <032201c20d55$73b57bd0$6132bc3e@BABEL>
From: "Conrad Scott" <Conrad.Scott@dsl.pipex.com>
To: <cygwin-patches@cygwin.com>
References: <01ae01c20cf5$551007f0$6132bc3e@BABEL> <20020606013947.GB851@redhat.com> <025101c20cfd$930b0f70$6132bc3e@BABEL>
Subject: Re: Patch for sub-second resolution in stat(2)
Date: Thu, 06 Jun 2002 05:25:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_031F_01C20D5D.D5320560"
X-Priority: 3
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-SW-Source: 2002-q2/txt/msg00320.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_031F_01C20D5D.D5320560
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 1076

Oh sh*t. It turns out that my changelog entry was more broken than just
formatting. I've appended and attached a new one to this email (the
attachment is because I'm unclear that Outlook Express keeps the
formatting).

Sorry for imposing my sordid learning experience on everyone.

// Conrad

2002-06-05  Conrad Scott  <conrad.scott@dsl.pipex.com>

 * fhandler.cc (fhandler_base::fstat): Initialise tv_nsec member of
 st_atim, st_mtim, and st_ctim fields.
 * fhandler_disk_file.cc (fhandler_disk_file::fstat_helper): Ditto.
 * fhandler_process.cc (fhandler_process::fstat): Ditto.
 * glob.c (stat32_to_STAT): Copy across the whole st_atim,
 st_mtime, and st_ctim fields.
 * syscalls.cc (stat64_to_stat32): Ditto.
 * times.cc (to_timestruc_t): New function.
 (time_as_timestruc_t): New function.
 * winsup.h: Add to_timestruc_t and time_as_timestruc_t functions.
 * include/cygwin/stat.h: Replace time_t with timestruc_t
 throughout for all file times, removing the st_spare1, st_spare2,
 and st_spare3 fields in the process. Add macros to access tv_sec
 fields by old names.


------=_NextPart_000_031F_01C20D5D.D5320560
Content-Type: application/octet-stream;
	name="ChangeLog"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ChangeLog"
Content-length: 782

2002-06-05  Conrad Scott  <conrad.scott@dsl.pipex.com>

	* fhandler.cc (fhandler_base::fstat): Initialise tv_nsec member of
	st_atim, st_mtim, and st_ctim fields.
	* fhandler_disk_file.cc (fhandler_disk_file::fstat_helper): Ditto.
	* fhandler_process.cc (fhandler_process::fstat): Ditto.
	* glob.c (stat32_to_STAT): Copy across the whole st_atim,
	st_mtime, and st_ctim fields.
	* syscalls.cc (stat64_to_stat32): Ditto.
	* times.cc (to_timestruc_t): New function.
	(time_as_timestruc_t): New function.
	* winsup.h: Add to_timestruc_t and time_as_timestruc_t functions.
	* include/cygwin/stat.h: Replace time_t with timestruc_t
	throughout for all file times, removing the st_spare1, st_spare2,
	and st_spare3 fields in the process. Add macros to access tv_sec
	fields by old names.

------=_NextPart_000_031F_01C20D5D.D5320560--

