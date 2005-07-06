Return-Path: <cygwin-patches-return-5559-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16612 invoked by alias); 6 Jul 2005 14:21:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14176 invoked by uid 22791); 6 Jul 2005 14:20:21 -0000
Received: from main.gmane.org (HELO ciao.gmane.org) (80.91.229.2)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 06 Jul 2005 14:20:21 +0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DqAkN-00063n-VK
	for cygwin-patches@cygwin.com; Wed, 06 Jul 2005 16:19:33 +0200
Received: from eblake.csw.L-3com.com ([128.170.36.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Wed, 06 Jul 2005 16:19:31 +0200
Received: from ebb9 by eblake.csw.L-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Wed, 06 Jul 2005 16:19:31 +0200
To: cygwin-patches@cygwin.com
From:  Eric Blake <ebb9@byu.net>
Subject:  Re: cygcheck exit status
Date: Wed, 06 Jul 2005 14:21:00 -0000
Message-ID:  <loom.20050706T160843-889@post.gmane.org>
References:  <loom.20050705T224501-8@post.gmane.org> <20050705205334.GA12357@trixie.casa.cgf.cx> <loom.20050705T225652-764@post.gmane.org> <Pine.GSO.4.61.0507061001050.17582@slinky.cs.nyu.edu>
Mime-Version:  1.0
Content-Type:  text/plain; charset=us-ascii
Content-Transfer-Encoding:  7bit
User-Agent: Loom/3.14 (http://gmane.org/)
X-SW-Source: 2005-q3/txt/msg00014.txt.bz2

Igor Pechtchanski <pechtcha <at> cs.nyu.edu> writes:
> > Because it's in a for loop, and when the first file fails but second
> > succeeds, you still want the overall command to exit with failure.
> 
> That's the correct intent, but shouldn't it be &&= instead of &=,
> technically?

There's no such thing as &&=.  And even if there was, you wouldn't want to use 
it, because it would short-circuit running cygcheck().  The whole point of the 
boolean collector is to run the test on every file, but to remember if any of 
the tests failed.  Maybe thinking of a short-circuit in the reverse direction 
will help you understand:

ok = cygcheck (argv[i]) && ok;

But since ok is a simple boolean, short-circuiting doesn't save us any side 
effects, so we can use:

ok = cygcheck (argv[i]) & ok;

And since & is commutative, it has the same outcome as:

ok = ok & cygcheck (argv[i]);

Hence my shorthand (coreutils uses this idiom a lot, too):

ok &= cygcheck (argv[i]);


[By deMorgan's law, I could have also reversed the sense of the collector:
bool failed = false;
for (int i; ...)
  failed |= test_that_returns_true_on_failure();
return failed ? EXIT_FAILURE : EXIT_SUCCESS;

But I hate thinking in negative logic, hence my definition of cygcheck to 
return true on success.]

--
Eric Blake

