Return-Path: <cygwin-patches-return-4317-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14677 invoked by alias); 25 Oct 2003 12:33:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14665 invoked from network); 25 Oct 2003 12:33:29 -0000
Date: Sat, 25 Oct 2003 12:33:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_base::ioctl (FIONBIO)
Message-ID: <20031025123328.GF1653@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.56.0310231800010.823@eos> <20031024124302.GD1653@cygbert.vinschen.de> <Pine.GSO.4.56.0310240944580.823@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0310240944580.823@eos>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00036.txt.bz2

On Fri, Oct 24, 2003 at 09:50:38AM -0500, Brian Ford wrote:
> On Fri, 24 Oct 2003, Corinna Vinschen wrote:
> 
> > On Thu, Oct 23, 2003 at 06:06:09PM -0500, Brian Ford wrote:
> > > Any reason not to support this?  It seams to me that this patch just
> > > parallels what is already in fhandler_base::fcntl (F_SETFL) for
> > > O_NONBLOCK.
> >
> > Yes, I think you're right.  However, I'd like to ask you to rearrange
> > your patch a bit.  Most (all?) other ioctl methods are using a switch
> > statement rather than a if/else clause.  To allow later easier extension,
> > I think using a switch here would be better as well, even though there's
> > only one case so far.
> >
> Ok.  Revised as suggested and attached.  Same ChangeLog entry.
> [...]
> > > 	* fhandler.cc (fhandler_base::ioctl): Handle FIONBIO.

Thanks.  I've checked it in.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
