Return-Path: <cygwin-patches-return-1894-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 11274 invoked by alias); 25 Feb 2002 18:01:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11189 invoked from network); 25 Feb 2002 18:01:09 -0000
Date: Mon, 25 Feb 2002 10:15:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Big checkin to allow 64bit file access
Message-ID: <20020225190107.W23094@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00251.txt.bz2

Hi,

after Chris has tagged Cygwin for the 1.3.10 release, I've now
applied the patches to allow 64 bit off_t.

Basically it adds the datatypes needed and new function calls
with trailing 64 as `lseek64', `stat64', etc.  Additionally
I renamed lstat to cygwin_lstat to circumvent a problem with
lstat being defined in a newlib header using struct stat
while cygwin_lstat uses struct __stat32.

All internal file access is using 64 bit offsets now, the old
32 bit functions are just calling the 64 bit functions now.
All fhandler methods only exist as 64 bit versions now.

These exported foo64 functions are not intended to ever be
defined as external API!  At one point we switch over to
using these functions when linking applications but older
applications will still use the old 32 bit API.  We don't
want to have the LARGEFILE64 discussions as with Linux.

There's just one define __CYGWIN_USE_BIG_TYPES__ which will
be defined always at one point and which will switch to 64
bit file offsets and 32 bit uid_t/gid_t types.

I tested this change against theygwin testsuite but that doesn't
mean it's error free so expect problems.

What's missing before we can switch over to __CYGWIN_USE_BIG_TYPES__:

- Change over to 32 bit uid_t and gid_t in internal datastructures.

- Add 32bit uid_t and gid_t function calls.

- !!! Tweak newlib to have fpos_t equal to __off64_t and add
  SUSv2 functions as ftello, fseeko, etc.

- Add functions like fgetpos64 to Cygwin to allow overriding
  fgetpos for new applications (actually, all functions using
  fpos_t).

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
