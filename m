Return-Path: <cygwin-patches-return-3564-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13722 invoked by alias); 13 Feb 2003 23:38:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13713 invoked from network); 13 Feb 2003 23:38:16 -0000
From: "Gary R Van Sickle" <tiberius@braemarinc.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: Produce beeps using soundcard
Date: Thu, 13 Feb 2003 23:38:00 -0000
Message-ID: <000b01c2d3b9$41b49780$2101a8c0@BRAEMARINC.COM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <20030213232335.GB31877@redhat.com>
X-SW-Source: 2003-q1/txt/msg00213.txt.bz2

What am I missing here?  Beep (412, 100) ==> MessageBeep ((unsigned)-1) and
we're done, right?  No need for any CYGWIN= hoobajoob or another static BOOL
or anything.

--
Gary R. Van Sickle
Braemar Inc.
11481 Rupp Dr.
Burnsville, MN 55337

> On Thu, Feb 13, 2003 at 10:32:47PM -0000, Max Bowsher wrote:
> >> I don't like to introduce lots of unnecessary decision
> points into a
> >> product.  It increases support and it increases code complexity.
> >
> >Complexity? Slightly, but only at CYGWIN-parsing time, and
> Beeping time.
> >That's not that much, surely?
>
> This is a cumulative thing.  Every "it's only a couple of lines" adds
> up.  It's a couple lines of code, a couple of extra lines in
> documentation, a couple of extra email messages with people struggling
> to use it.
>
> I don't mind adding the lines when we are moving closer to UNIX
> compatibility but I will always push back on adding arbitrary
> options to
> the CYGWIN environment variable.  I'm in good company.  My predecessor
> did the same thing.
>
> >>Once again, how does linux handle this scenario?  You don't do a
> >>"export LINUX=linbeep" to get linux to use the soundcard.
> >
> >If Vaclav is correct - that it required a kernel module - I
> think this
> >question is answered.
>
> Ok.  How about if I say "I don't think it requires a kernel module".
> Does that put things back on course?
>
> cgf
