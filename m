Return-Path: <cygwin-patches-return-2213-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19838 invoked by alias); 23 May 2002 11:00:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19805 invoked from network); 23 May 2002 11:00:54 -0000
Date: Thu, 23 May 2002 04:00:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: getfacl help/version patch
Message-ID: <20020523130052.Q10218@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <20020522121404.C10218@cygbert.vinschen.de> <20020522175700.95652.qmail@web20002.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020522175700.95652.qmail@web20002.mail.yahoo.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00197.txt.bz2

On Wed, May 22, 2002 at 10:57:00AM -0700, Joshua Daniel Franklin wrote:
> --- Corinna Vinschen <cygwin-patches@cygwin.com> wrote:
> > On Tue, May 21, 2002 at 05:23:22PM -0500, Joshua Daniel Franklin wrote:
> > > > On Mon, May 20, 2002 at 05:33:01PM -0500, Joshua Daniel Franklin wrote:
> > > > > Here is a patch to getfacl that adds longopts for all options,
> > > > > standardizes the usage output, and adds the GNU standard --version
> > option.
> > > >
> > What I don't get is
> > the reasoning for introducing the --examples option.  From my point
> > of view that output should still be a part of --help.  
> > 
> > Corinna
> 
> OK, here is a patch that does as you suggested. I don't like all the 

I understand your reasoning.  I've applied your latest patch, though
since I think the --examples isn't straightforward enough.  It's not
a really good point, it's just an opinion, so...

OTOH, perhaps we should drop that text completely at a later point as
soon as we have the man page?!?

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
