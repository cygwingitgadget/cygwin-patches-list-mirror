Return-Path: <cygwin-patches-return-5555-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30974 invoked by alias); 5 Jul 2005 20:59:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30953 invoked by uid 22791); 5 Jul 2005 20:58:59 -0000
Received: from main.gmane.org (HELO ciao.gmane.org) (80.91.229.2)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 05 Jul 2005 20:58:59 +0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DpuUy-0000Zz-3q
	for cygwin-patches@cygwin.com; Tue, 05 Jul 2005 22:58:32 +0200
Received: from eblake.csw.L-3com.com ([128.170.36.44])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Tue, 05 Jul 2005 22:58:32 +0200
Received: from ebb9 by eblake.csw.L-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <cygwin-patches@cygwin.com>; Tue, 05 Jul 2005 22:58:32 +0200
To: cygwin-patches@cygwin.com
From:  Eric Blake <ebb9@byu.net>
Subject:  Re: cygcheck exit status
Date: Tue, 05 Jul 2005 20:59:00 -0000
Message-ID:  <loom.20050705T225652-764@post.gmane.org>
References:  <loom.20050705T224501-8@post.gmane.org> <20050705205334.GA12357@trixie.casa.cgf.cx>
Mime-Version:  1.0
Content-Type:  text/plain; charset=us-ascii
Content-Transfer-Encoding:  7bit
User-Agent: Loom/3.14 (http://gmane.org/)
X-SW-Source: 2005-q3/txt/msg00010.txt.bz2

Christopher Faylor <cgf-no-personal-reply-please <at> cygwin.com> writes:

> 
> On Tue, Jul 05, 2005 at 08:49:06PM +0000, Eric Blake wrote:
> > <at>  <at>  -1677,7 +1681,7  <at>  <at>  main (int argc, char **argv)
> >       {
> >        if (i)
> >          puts ("");
> >-       cygcheck (argv[i]);
> >+       ok &= cygcheck (argv[i]);
> 
> Why are you anding the result here?  Why not just set ok = cygcheck (...)?

Because it's in a for loop, and when the first file fails but second succeeds, 
you still want the overall command to exit with failure.



