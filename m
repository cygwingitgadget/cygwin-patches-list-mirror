Return-Path: <cygwin-patches-return-5277-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5878 invoked by alias); 23 Dec 2004 19:51:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5857 invoked from network); 23 Dec 2004 19:51:36 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 23 Dec 2004 19:51:36 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id I96XTY-00008D-P3
	for cygwin-patches@cygwin.com; Thu, 23 Dec 2004 14:51:34 -0500
Message-ID: <41CB21C6.636CECE4@phumblet.no-ip.org>
Date: Thu, 23 Dec 2004 19:51:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Still stripping
References: <41CAF567.365C09F7@phumblet.no-ip.org> <20041223193405.GJ13179@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00278.txt.bz2



Christopher Faylor wrote:
> 
> On Thu, Dec 23, 2004 at 11:42:15AM -0500, Pierre A. Humblet wrote:
> >In a case such as "abc..exe", the posix_path "abc." should not be
> >stripped. The patch below only strips the posix path if the win32
> >path was stripped. I don't think that the posix path can be empty
> >in that case.
> >
> >2004-12-23  Pierre Humblet <pierre.humblet@ieee.org>
> >
> >       * path.h (path_conv::set_normalized_path): Add second argument.
> >       * path.cc (path_conv::check): Declare, set and use "strip_tail".
> >       (path_conv::set_normalized_path): Add and use second argument,
> >       replacing all tail stripping tests.
> >
> 
> I'm not sure that your assumption of dot stripping is true in the first
> case of set_normalized_path in build_fh_dev in dtable.cc.  

Not sure I understand what you mean. At any rate there are two cases
where build_fh_dev is called with a non-empty second argument:
handler_tty.cc:  console = (fhandler_console *) build_fh_dev (*console_dev, "/dev/ttym");
path.cc:              fhandler_virtual *fh = (fhandler_virtual *) build_fh_dev (dev, path_copy); 
Neither is about a disk path.

> I do like the
> idea of letting the previously derived path_conv tail stripping test
> control whether set_normalized_path does stripping or not, though.
> 
> I have grown to dislike default parameters in c++.  I'm not sure why because
> I used to think they were pretty nifty.  

OK. Same here, having been burned.

> So, I'll check in your patch minus
> the default and keeping the original while loop in set_normalized_path
> more or less intact.

Aren't they the same? I thought it was nice to avoid having a strlen in one
case and a strchr in another. 

Pierre
