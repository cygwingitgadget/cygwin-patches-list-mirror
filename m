Return-Path: <cygwin-patches-return-3989-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4817 invoked by alias); 2 Jul 2003 17:53:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4806 invoked from network); 2 Jul 2003 17:53:56 -0000
From: "Chris January" <chris@atomice.net>
To: <cygwin-patches@cygwin.com>
Subject: RE: killall utility
Date: Wed, 02 Jul 2003 17:53:00 -0000
Message-ID: <ICEBIHGCEJIPLNMBNCMKCEEECIAA.chris@atomice.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <Pine.CYG.4.55.0307021542280.2156@ellixia>
Importance: Normal
X-SW-Source: 2003-q3/txt/msg00005.txt.bz2

> On Wed, 2 Jul 2003, Christopher Faylor wrote:
>
> > On Wed, Jul 02, 2003 at 11:47:04AM +0100, Elfyn McBratney wrote:
> > >I have written a killall utility based on the code already in
> utils/kill.cc .
> > >Would this make a worthy addition to Cygwin? If so, there's a
> bit of code
> > >duplication, so maybe moving the generic code into a file
> called `sigutil.cc' or
> > >something would be sufficient, having kill{,all}.exe depending
> on `sigutil.o'.
> > >
> > >Any ideas bofore I submit a patch?
> >
> > Can't you do something like this with the kill in procps?
>
> I did look and from the usage info, it doesn't look that way.
However you can compile the source for the /proc-based killall and it should
work as-is.

Chris
