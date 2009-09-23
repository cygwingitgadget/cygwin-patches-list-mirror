Return-Path: <cygwin-patches-return-6632-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26458 invoked by alias); 23 Sep 2009 14:09:20 -0000
Received: (qmail 26447 invoked by uid 22791); 23 Sep 2009 14:09:18 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-151.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.151)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 23 Sep 2009 14:09:16 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 11F9C13C0C4 	for <cygwin-patches@cygwin.com>; Wed, 23 Sep 2009 10:09:06 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 0CF0B2B352; Wed, 23 Sep 2009 10:09:06 -0400 (EDT)
Date: Wed, 23 Sep 2009 14:09:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] rename/renameat error
Message-ID: <20090923140905.GA2527@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AA52B5E.8060509@byu.net>  <20090907192046.GA12492@calimero.vinschen.de>  <loom.20090909T005422-847@post.gmane.org>  <loom.20090909T183010-83@post.gmane.org>  <loom.20090922T225033-801@post.gmane.org>  <4ABA1B92.9080406@byu.net>  <20090923133015.GA16976@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090923133015.GA16976@calimero.vinschen.de>
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
X-SW-Source: 2009-q3/txt/msg00086.txt.bz2

On Wed, Sep 23, 2009 at 03:30:15PM +0200, Corinna Vinschen wrote:
>Urgh.  I stumbled over the need_directory flag only two days ago.  while
>debugging the symlink errno problem you reported on the list.  CGF is my
>witness.  It's the reason I made the trailing slash change in symlink
>rather than in path_conv::check.  It's quite tricky to keep all possible
>cases working.  Have you tested this change with the entire coreutils
>testsuite?  It seems to be quite thorough.

Yes, I'm a witness.  I mentioned that this has to still work:

ls -l foo/

where foo is a directory.  I think that requirement is the cause for
some complication in the code.

Do we really want to be making many changes to this code at this point
in the release cycle?  Maybe we could branch 1.7.1 and keep making
riskier changes on the trunk, just like the real projects do it?

cgf
