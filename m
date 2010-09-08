Return-Path: <cygwin-patches-return-7079-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13690 invoked by alias); 8 Sep 2010 22:41:23 -0000
Received: (qmail 13662 invoked by uid 22791); 8 Sep 2010 22:41:14 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-46-163.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.46.163)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 08 Sep 2010 22:41:10 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id BFD6113C061	for <cygwin-patches@cygwin.com>; Wed,  8 Sep 2010 18:41:08 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id B93D52B352; Wed,  8 Sep 2010 18:41:08 -0400 (EDT)
Date: Wed, 08 Sep 2010 22:41:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Mounting /tmp at TMP or TEMP as a last resort
Message-ID: <20100908224108.GB13153@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4C880761.2030503@ixiacom.com> <4C880DC2.1070706@ixiacom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C880DC2.1070706@ixiacom.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q3/txt/msg00039.txt.bz2

On Wed, Sep 08, 2010 at 03:27:14PM -0700, Earl Chew wrote:
>We have an installation that we deploy to a bunch of workstations. We prefer
>if the installation uses the temporary file directory that Windows has already
>allocated for the user.
>
>The entry for /tmp in /etc/fstab, or the directory /tmp, is preferred.
>If neither is found, the patch mounts /tmp at the directory indicated
>by the environment variable TMP or, if that is not set, TEMP. The patch
>does nothing if neither environment variable is set.

Thanks for the patch but I don't think this is generally useful.  If you
need to mount /tmp somewhere else then it should be fairly trivial to
automatically update /etc/fstab.  Corinna may disagree, but I think we
should keep the parsing of /etc/fstab as lean as possible; particularly
when there are alternatives to modifying Cygwin to achieve the desired
result.

cgf
