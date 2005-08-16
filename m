Return-Path: <cygwin-patches-return-5619-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23268 invoked by alias); 16 Aug 2005 23:02:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23229 invoked by uid 22791); 16 Aug 2005 23:02:27 -0000
Received: from dessent.net (HELO dessent.net) (69.60.119.225)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 16 Aug 2005 23:02:27 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.52)
	id 1E5ARu-0008KB-6X
	for cygwin-patches@cygwin.com; Tue, 16 Aug 2005 23:02:26 +0000
Message-ID: <4302715C.528696C3@dessent.net>
Date: Tue, 16 Aug 2005 23:02:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix cygrunsrv invocation in cygcheck
References: <Pine.GSO.4.61.0508161203480.9560@slinky.cs.nyu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q3/txt/msg00074.txt.bz2

Igor Pechtchanski wrote:

> As mentioned in <http://cygwin.com/ml/cygwin/2005-08/msg00724.html>, I
> noticed something strange in the "cygcheck -s" output:

This fix was part of my patch from June in
<http://cygwin.com/ml/cygwin-patches/2005-q2/msg00138.html> but since it
was grouped with the unrelated cygcheck -p code, it kind of got lost on
the floor.

> why not simply run "cygrunsrv --list --verbose" in verbose mode, instead
> of actually going through one iteration of the loop?  Simply to reuse the
> "copy output" code?  Brian?

The reason I did it that way is because if I had run "cygrunsrv --list
--verbose" initially, then it would be necessary to parse the output and
extract out the service names, since it has to run "cygrunsrv --query"
for each individual service in the case of (!verbose).  By running just
"cygrunsrv --list" you get a simple listing of service names with no
parsing necessary, and I did not want to make cygcheck depend on the
particular output format of cygrunsrv.

This is awkward I admit because there is no cygrunsrv option that does
the equivalent of "--query" for all services.  So to support both
verbose and non-verbose listing of all services, you either have to run
"--list --verbose" and then filter out the fields that should not be in
the verbose output, or you have to run "--query" individually for each
service.  And I did not want to mess about with text parsing and
filtering so I decided to take the easy route and just invoke cygrunsrv
a few extra times.

Brian
