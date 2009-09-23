Return-Path: <cygwin-patches-return-6634-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16145 invoked by alias); 23 Sep 2009 16:41:44 -0000
Received: (qmail 16133 invoked by uid 22791); 23 Sep 2009 16:41:43 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-98-110-183-151.bstnma.fios.verizon.net (HELO cgf.cx) (98.110.183.151)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 23 Sep 2009 16:41:38 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 0D4B63B0002 	for <cygwin-patches@cygwin.com>; Wed, 23 Sep 2009 12:41:28 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id DCBC32B352; Wed, 23 Sep 2009 12:41:27 -0400 (EDT)
Date: Wed, 23 Sep 2009 16:41:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] rename/renameat error
Message-ID: <20090923164127.GB3172@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AA52B5E.8060509@byu.net>  <20090907192046.GA12492@calimero.vinschen.de>  <loom.20090909T005422-847@post.gmane.org>  <loom.20090909T183010-83@post.gmane.org>  <loom.20090922T225033-801@post.gmane.org>  <4ABA1B92.9080406@byu.net>  <20090923133015.GA16976@calimero.vinschen.de>  <20090923140905.GA2527@ednor.casa.cgf.cx>  <20090923160846.GA18954@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090923160846.GA18954@calimero.vinschen.de>
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
X-SW-Source: 2009-q3/txt/msg00088.txt.bz2

On Wed, Sep 23, 2009 at 06:08:46PM +0200, Corinna Vinschen wrote:
>On Sep 23 10:09, Christopher Faylor wrote:
>>On Wed, Sep 23, 2009 at 03:30:15PM +0200, Corinna Vinschen wrote:
>>>Urgh.  I stumbled over the need_directory flag only two days ago.
>>>while debugging the symlink errno problem you reported on the list.
>>>CGF is my witness.  It's the reason I made the trailing slash change in
>>>symlink rather than in path_conv::check.  It's quite tricky to keep all
>>>possible cases working.  Have you tested this change with the entire
>>>coreutils testsuite?  It seems to be quite thorough.
>>
>>Yes, I'm a witness.  I mentioned that this has to still work:
>>
>>ls -l foo/
>>
>>where foo is a directory.  I think that requirement is the cause for
>
>Actually, where foo is a symlink pointing to an existing directory.

Yes.  Imprecise language on my part.

>>some complication in the code.
>>
>>Do we really want to be making many changes to this code at this point
>>in the release cycle?  Maybe we could branch 1.7.1 and keep making
>>riskier changes on the trunk, just like the real projects do it?
>
>Also less risky would be to make changes locally in mkdir, link, and
>rename for now.

I'm not clear if this is a regression or not.  If it isn't a regression,
I'd opt for leaving it until 1.7.2.

cgf
