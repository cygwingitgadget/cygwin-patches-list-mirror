Return-Path: <cygwin-patches-return-4434-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28559 invoked by alias); 21 Nov 2003 11:02:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28532 invoked from network); 21 Nov 2003 11:02:24 -0000
Date: Fri, 21 Nov 2003 11:02:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: thunking, the next step
Message-ID: <20031121110223.GB8815@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3FB4C443.2040301@cygwin.com> <20031114155716.GA16485@redhat.com> <1068832363.1109.101.camel@localhost> <20031114191010.GA22870@redhat.com> <20031117112126.GE18706@cygbert.vinschen.de> <1069068688.2287.219.camel@localhost> <20031117120229.GH18706@cygbert.vinschen.de> <1069361541.1117.42.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069361541.1117.42.camel@localhost>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00153.txt.bz2

On Fri, Nov 21, 2003 at 07:52:21AM +1100, Robert Collins wrote:
> On Mon, 2003-11-17 at 23:02, Corinna Vinschen wrote:
> 
> > >  And, structures like
> > > the FindNext* details change in definition when UNICODE is defined. I
> > > was trying to avoid all that complexity, which is significant, by
> > > staying in a thunk approach.
> > 
> > Yep, I agree, that's an extra problem.  But it doesn't invalidate the
> > general idea of putting the work into autoload and path_conv.  The
> > FindFile example might be something which justifies the use of wrapper
> > functions for these very cases.
> 
> Ok. Well for now, I'm going to leave the thunks in place, until / if
> they become nothing more than if (unicode) ...W() else A(). That said,
> all the calls we are thunking require kernel mode transitions, so I
> really don't believe that the thunking will add any overhead on it's
> own: the context switch going into kernel will obliterate the much
> smaller overhead of checking which call we want to make.

I don't think so.  You can't take the kernel into account, really, since
it spends its time either case.

Anyway, *sic* I don't like the thunking.  It's fairly intrusive to the
code.  It adds another complexity level to a lot of functions which seems
pretty unnecessary.  It also adds a lot of decisions which are made on
runtime over and over again, even though actually it would be sufficient
from a logical level to make this decision once.  Or at least only once
per Win32 function call.  

Btw., what does "thunk" mean literally?  While I know its meaning in the
software context, I can't find a simple translation.  I looked up three
dictionaries to no avail.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
