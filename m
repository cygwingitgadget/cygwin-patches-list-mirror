Return-Path: <cygwin-patches-return-2205-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2145 invoked by alias); 22 May 2002 10:26:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2110 invoked from network); 22 May 2002 10:26:11 -0000
Date: Wed, 22 May 2002 03:26:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: getfacl help/version patch
Message-ID: <20020522122609.D10218@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <Pine.CYG.4.44.0205211721230.416-200000@iocc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.44.0205211721230.416-200000@iocc.com>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q2/txt/msg00189.txt.bz2

On Tue, May 21, 2002 at 05:23:22PM -0500, Joshua Daniel Franklin wrote:
> > On Mon, May 20, 2002 at 05:33:01PM -0500, Joshua Daniel Franklin wrote:
> > > Here is a patch to getfacl that adds longopts for all options,
> > > standardizes the usage output, and adds the GNU standard --version option.
> >
> > I'm all for it but the patch doesn't apply cleanly against current CVS.
> > Could you please send another diff?
> >
> > Corinna
> >
> Yes. Here it is.

Hi Joshua,

this patch applies cleanly but I have a problem.  What I don't get is
the reasoning for introducing the --examples option.  From my point
of view that output should still be a part of --help.  Probably the
short form w/o that stuff in case of a getfacl w/o args or with
wrong args and the long form incuding the examples when -h/--help
is given on the command line.  The --examples is somewhat unnatural
IMHO.  Would you mind to change that?

I'm sorry that this comes so late, I haven't seen that yesterday.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
