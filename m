Return-Path: <cygwin-patches-return-5620-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3344 invoked by alias); 16 Aug 2005 23:17:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3304 invoked by uid 22791); 16 Aug 2005 23:17:03 -0000
Received: from dessent.net (HELO dessent.net) (69.60.119.225)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 16 Aug 2005 23:17:03 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net)
	by dessent.net with esmtp (Exim 4.52)
	id 1E5Ag2-0008NV-2c
	for cygwin-patches@cygwin.com; Tue, 16 Aug 2005 23:17:02 +0000
Message-ID: <430274CC.FA870D37@dessent.net>
Date: Tue, 16 Aug 2005 23:17:00 -0000
From: Brian Dessent <brian@dessent.net>
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix cygrunsrv invocation in cygcheck
References: <Pine.GSO.4.61.0508161203480.9560@slinky.cs.nyu.edu> <4302715C.528696C3@dessent.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q3/txt/msg00075.txt.bz2

Brian Dessent wrote:

> > why not simply run "cygrunsrv --list --verbose" in verbose mode, instead
> > of actually going through one iteration of the loop?  Simply to reuse the
> > "copy output" code?  Brian?
> 
> The reason I did it that way is because if I had run "cygrunsrv --list

Now that I re-read what you said I think I misunderstood.  You're right,
it could have simply done

if(verbose)
  cygrunsrv --list --verbose
else
  foreach cygrunsrv --list
    cygrunsrv --query

And that would be somewhat more efficient.  But you're right, I did it
that way so that I wouldn't have to duplicate code between the two
cases... laziness.

Brian
