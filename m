Return-Path: <cygwin-patches-return-3641-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1801 invoked by alias); 27 Feb 2003 21:42:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1792 invoked from network); 27 Feb 2003 21:42:19 -0000
Date: Thu, 27 Feb 2003 21:42:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: interruptable connect
Message-ID: <20030227214217.GE24097@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0302271616590.314-200000@algeria.intern.net> <20030227164537.GB10601@redhat.com> <20030227173728.GA24097@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030227173728.GA24097@cygbert.vinschen.de>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q1/txt/msg00290.txt.bz2

On Thu, Feb 27, 2003 at 06:37:28PM +0100, Corinna Vinschen wrote:
> On Thu, Feb 27, 2003 at 11:45:37AM -0500, Christopher Faylor wrote:
> > On Thu, Feb 27, 2003 at 04:21:33PM +0100, Thomas Pfaff wrote:
> > >
> > >Hi Corinna,
> > >
> > >this is a slightly modified version of my proposed solution from
> > >yesterday. Not tested exhaustiv but seems to work pretty well.
> > 
> > I appreciate the effort that you and Corinna have put into this
> > very much.
> > 
> > Out of curiousity, is there any way to generalize the (I think) common
> > code that is now in fhandler_socket::accept and fhandler_socket::connect
> > into one common function?
> 
> Well... more or less, yes.  I think this could be worth to create a class.

Done.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
