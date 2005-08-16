Return-Path: <cygwin-patches-return-5621-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3716 invoked by alias); 16 Aug 2005 23:17:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3607 invoked by uid 22791); 16 Aug 2005 23:17:18 -0000
Received: from slinky.cs.nyu.edu (HELO slinky.cs.nyu.edu) (128.122.20.14)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 16 Aug 2005 23:17:18 +0000
Received: from localhost (localhost [127.0.0.1])
	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id j7GNHHuA029935;
	Tue, 16 Aug 2005 19:17:17 -0400 (EDT)
Date: Tue, 16 Aug 2005 23:17:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Brian Dessent <brian@dessent.net>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix cygrunsrv invocation in cygcheck
In-Reply-To: <4302715C.528696C3@dessent.net>
Message-ID: <Pine.GSO.4.61.0508161911500.9560@slinky.cs.nyu.edu>
References: <Pine.GSO.4.61.0508161203480.9560@slinky.cs.nyu.edu>
 <4302715C.528696C3@dessent.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q3/txt/msg00076.txt.bz2

On Tue, 16 Aug 2005, Brian Dessent wrote:

> Igor Pechtchanski wrote:
>
> > As mentioned in <http://cygwin.com/ml/cygwin/2005-08/msg00724.html>, I
> > noticed something strange in the "cygcheck -s" output:
>
> This fix was part of my patch from June in
> <http://cygwin.com/ml/cygwin-patches/2005-q2/msg00138.html> but since it
> was grouped with the unrelated cygcheck -p code, it kind of got lost on
> the floor.

That's why it's better to send many micro-patches instead of one monster
patch...  :-)
Hmm, you should ping the list about it, then -- it's been what, two months?

> > why not simply run "cygrunsrv --list --verbose" in verbose mode, instead
> > of actually going through one iteration of the loop?  Simply to reuse the
> > "copy output" code?  Brian?
>
> The reason I did it that way is because if I had run "cygrunsrv --list
> --verbose" initially, then it would be necessary to parse the output and
> extract out the service names, since it has to run "cygrunsrv --query"
> for each individual service in the case of (!verbose).  By running just
> "cygrunsrv --list" you get a simple listing of service names with no
> parsing necessary, and I did not want to make cygcheck depend on the
> particular output format of cygrunsrv.
>
> This is awkward I admit because there is no cygrunsrv option that does
> the equivalent of "--query" for all services.  So to support both
> verbose and non-verbose listing of all services, you either have to run
> "--list --verbose" and then filter out the fields that should not be in
> the verbose output, or you have to run "--query" individually for each
> service.  And I did not want to mess about with text parsing and
> filtering so I decided to take the easy route and just invoke cygrunsrv
> a few extra times.

I actually meant something like

if (verbose) {
  f = popen("cygrunsrv --list --verbose");
  copy_output(f, stdout);
} else {
  f = popen("cygrunsrv --list");
  buf[fread(buf, 1, sizeof(buf)-1, f)] = '\0';
  pclose(f);
  for (char *srv = strtok(buf), "\n"); srv; srv = strtok(NULL, "\n")) {
    f = popen("cygrunsrv --query "+srv);
    copy_output(f, stdout);
  }
}

	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

If there's any real truth it's that the entire multidimensional infinity
of the Universe is almost certainly being run by a bunch of maniacs. /DA
