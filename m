Return-Path: <cygwin-patches-return-5220-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11456 invoked by alias); 16 Dec 2004 16:56:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11410 invoked from network); 16 Dec 2004 16:56:45 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 16 Dec 2004 16:56:45 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id I8TR2G-0000QE-EZ
	for cygwin-patches@cygwin.com; Thu, 16 Dec 2004 11:56:40 -0500
Message-ID: <41C1BE47.F51C5141@phumblet.no-ip.org>
Date: Thu, 16 Dec 2004 16:56:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Patch to allow trailing dots on managed mounts
References: <41C1A1F4.CD3CC833@phumblet.no-ip.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00221.txt.bz2

cgf wrote:

> Is it correct to assume that only fhandler_base::open cares about
>trailing dots?

Good point. This bring back memories.

The initial motivation was to fix problems introduced by the 
use of NtCreateFile 

http://www.cygwin.com/ml/cygwin/2004-04/msg01250.html
and there were successive changes

2004-04-30  Corinna Vinschen  <corinna@vinschen.de>

        * path.cc (normalize_posix_path): Remove trailing dots and spaces.

http://cygwin.com/ml/cygwin-patches/2004-q2/msg00053.html

2004-05-06  Pierre Humblet <pierre.humblet@ieee.org>

        * path.cc (path_conv::check): Strip trailing dots and spaces and
        return error if the final component had only dots and spaces.
        (normalize_posix_path): Revert 2004-04-30.

However, as a side effect, checking the tail in :check
also cleanly fixed longstanding dormant issues with the path hash
and with chroot (at least).

So checking the tail in fhandler_base::open() is too late.
It should be done before exiting  :check(), perhaps only in the
case where the path refers to a disk file, preferably
with little processing overhead.

Although it wasn't done before 2004/04, we should also make sure
(I have no free time for the moment) that nothing goes wrong 
inside :check() while we lookup symbolic links.

Pierre
