Return-Path: <cygwin-patches-return-3986-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24532 invoked by alias); 2 Jul 2003 11:28:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24522 invoked from network); 2 Jul 2003 11:28:46 -0000
Date: Wed, 02 Jul 2003 11:28:00 -0000
From: Elfyn McBratney <elfyn@cygwin.com>
X-X-Sender: elfyn@ellixia
Reply-To: cygwin-patches@cygwin.com
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: killall utility
In-Reply-To: <20030702110600.GL1165@cygbert.vinschen.de>
Message-ID: <Pine.CYG.4.55.0307021227520.2156@ellixia>
References: <Pine.CYG.4.55.0307021143080.2156@ellixia>
 <20030702110600.GL1165@cygbert.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q3/txt/msg00002.txt.bz2

On Wed, 2 Jul 2003, Corinna Vinschen wrote:

> On Wed, Jul 02, 2003 at 11:47:04AM +0100, Elfyn McBratney wrote:
> > Hi,
> >
> > I have written a killall utility based on the code already in utils/kill.cc .
> > Would this make a worthy addition to Cygwin? If so, there's a bit of code
> > duplication, so maybe moving the generic code into a file called `sigutil.cc' or
> > something would be sufficient, having kill{,all}.exe depending on `sigutil.o'.
> >
> > Any ideas bofore I submit a patch?
>
> Except for "go ahead"?  No.

Cool. Thinking about it more, it might also be a good idea to do the same with
the process enumeration code in ps.cc to cut-down on duplication.

Elfyn
-- 
