Return-Path: <cygwin-patches-return-6510-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25938 invoked by alias); 13 Apr 2009 19:04:45 -0000
Received: (qmail 25782 invoked by uid 22791); 13 Apr 2009 19:04:44 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-58-89.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.58.89)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 13 Apr 2009 19:04:38 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id DA27913C023 	for <cygwin-patches@cygwin.com>; Mon, 13 Apr 2009 15:04:28 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id D3D862B35E; Mon, 13 Apr 2009 15:04:28 -0400 (EDT)
Date: Mon, 13 Apr 2009 19:04:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add libz to dumper.exe link  [was Re: Re: speclib vs. 	-lc  trouble.]
Message-ID: <20090413190428.GA32672@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49E3641E.6040407@gmail.com> <20090413165923.GA13222@ednor.casa.cgf.cx> <49E3778C.2020706@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49E3778C.2020706@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00052.txt.bz2

On Mon, Apr 13, 2009 at 06:34:04PM +0100, Dave Korn wrote:
>Christopher Faylor wrote:
>>I think you can get by with just adding -lz to the ALL_LDFLAGS line and
>>removing the other stuff.  The tests for libintl and libbfd are
>>supposed to just detect if the appropriate directories are available.
>>There isn't likely going to be a libz two levels above cygwin's source
>>directory so I don't see any reason to specfically check for it.
>
>I thought that might happen in a combined tree build with /src and /gcc
>together?

That wasn't the intent of the current checks in the makefile.  They were
just to detect newer versions of libbfd.a or libintl.a.  Even libintl.a
isn't really necessary IMO.  It's not likely that is going to be under
active development and different from what should be installed in /lib.

cgf
