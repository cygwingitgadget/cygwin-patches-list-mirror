Return-Path: <cygwin-patches-return-3990-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 633 invoked by alias); 2 Jul 2003 22:39:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 616 invoked from network); 2 Jul 2003 22:39:36 -0000
Date: Wed, 02 Jul 2003 22:39:00 -0000
From: Elfyn McBratney <elfyn@cygwin.com>
X-X-Sender: elfyn@ellixia
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: RE: killall utility
In-Reply-To: <ICEBIHGCEJIPLNMBNCMKCEEECIAA.chris@atomice.net>
Message-ID: <Pine.CYG.4.55.0307022338530.536@ellixia>
References: <ICEBIHGCEJIPLNMBNCMKCEEECIAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q3/txt/msg00006.txt.bz2

On Wed, 2 Jul 2003, Chris January wrote:

> > On Wed, 2 Jul 2003, Christopher Faylor wrote:
> >
> > > On Wed, Jul 02, 2003 at 11:47:04AM +0100, Elfyn McBratney wrote:
> > > >I have written a killall utility based on the code already in
> > utils/kill.cc .
> > > >Would this make a worthy addition to Cygwin? If so, there's a
> > bit of code
> > > >duplication, so maybe moving the generic code into a file
> > called `sigutil.cc' or
> > > >something would be sufficient, having kill{,all}.exe depending
> > on `sigutil.o'.
> > > >
> > > >Any ideas bofore I submit a patch?
> > >
> > > Can't you do something like this with the kill in procps?
> >
> > I did look and from the usage info, it doesn't look that way.
> However you can compile the source for the /proc-based killall and it should
> work as-is.

I haven't tested it, but presuming it works, will you add it to the distro? :-)

Elfyn
-- 
