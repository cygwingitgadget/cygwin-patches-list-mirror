Return-Path: <cygwin-patches-return-3606-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7189 invoked by alias); 20 Feb 2003 15:52:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7177 invoked from network); 20 Feb 2003 15:52:30 -0000
Date: Thu, 20 Feb 2003 15:52:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Create new files as sparse on NT systems. (2nd try)
Message-ID: <20030220155222.GD1403@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030218165804.GB7145@redhat.com> <20030218221239.U46120-100000@logout.sh.cvut.cz> <20030220101606.GA2467@cygbert.vinschen.de> <20030220152500.GA21943@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030220152500.GA21943@redhat.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00255.txt.bz2

On Thu, Feb 20, 2003 at 10:25:00AM -0500, Christopher Faylor wrote:
> On Thu, Feb 20, 2003 at 11:16:06AM +0100, Corinna Vinschen wrote:
> >I've applied that patch now.  If anybody still has problems with it,
> >please feel free to post a *testcase* which shows the problem.
> 
> Um.  I was still hoping for benchmarks indicating that there was no performance
> hit from this patch.  Also, this patch introduces a change to wincap which is
> never used.  We don't need to change wincap.

I can quickly remove the wincap change (I didn't realize it isn't used
after all the discussions here).

However, since some people were objecting so doggedly, I was thinking
that committing this patch would give a hint that a testcase(tm) is more
useful than just musing.  Everybody who wants this patch removed can
accomplish this by showing us the testcase and the oh so bad results...

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
