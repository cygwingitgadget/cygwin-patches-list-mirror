Return-Path: <cygwin-patches-return-3533-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13358 invoked by alias); 6 Feb 2003 19:01:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13348 invoked from network); 6 Feb 2003 19:01:38 -0000
Date: Thu, 06 Feb 2003 19:01:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ntsec odds and ends
Message-ID: <20030206190136.GM5822@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030206174750.GK5822@cygbert.vinschen.de> <Pine.GSO.4.44.0302061302440.16397-100000@slinky.cs.nyu.edu> <20030206182413.GL5822@cygbert.vinschen.de> <20030206182837.GI21655@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030206182837.GI21655@redhat.com>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00182.txt.bz2

On Thu, Feb 06, 2003 at 01:28:37PM -0500, Christopher Faylor wrote:
> On Thu, Feb 06, 2003 at 07:24:13PM +0100, Corinna Vinschen wrote:
> >I think we never get that right.  The problem is that the ls entries
> >only are 8 chars long, not enough to be really informative.  Whatever
> >you put in there ("unknown", "????????", "mkpasswd", "run mkpa",
> >"dumbass"), you will deterministically get confused users.
> 
> Hey.  "dumbass".  That may be the best suggstion yet.  I'd definitely
> want to get rid of that if I saw it!  I'd probably spend some time
> researching how to do it.
> 
> I like it!

Just ask and I'll check it in.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
