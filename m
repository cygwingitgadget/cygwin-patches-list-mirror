Return-Path: <cygwin-patches-return-4273-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24708 invoked by alias); 30 Sep 2003 15:49:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24689 invoked from network); 30 Sep 2003 15:49:45 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Tue, 30 Sep 2003 15:49:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: New program: cygtweak
In-Reply-To: <20030930154434.GK20635@redhat.com>
Message-ID: <Pine.GSO.4.56.0309301146400.3193@slinky.cs.nyu.edu>
References: <Pine.GSO.4.44.0208161539040.21909-100000@slinky.cs.nyu.edu>
 <20030927034235.GA18807@redhat.com> <Pine.GSO.4.56.0309271124210.3193@slinky.cs.nyu.edu>
 <20030930121609.GA2022@cygbert.vinschen.de> <Pine.GSO.4.56.0309301058290.3193@slinky.cs.nyu.edu>
 <20030930150956.GE20635@redhat.com> <Pine.GSO.4.56.0309301112320.3193@slinky.cs.nyu.edu>
 <20030930154434.GK20635@redhat.com>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q3/txt/msg00289.txt.bz2

On Tue, 30 Sep 2003, Christopher Faylor wrote:

> On Tue, Sep 30, 2003 at 11:29:29AM -0400, Igor Pechtchanski wrote:
> >On Tue, 30 Sep 2003, Christopher Faylor wrote:
> >
> >> On Tue, Sep 30, 2003 at 11:02:39AM -0400, Igor Pechtchanski wrote:
> >> >On Tue, 30 Sep 2003, Corinna Vinschen wrote:
> >> >> Wouldn't it be sufficient to add $(srcdir)/cygprogctl to PROGS and to
> >> >> drop the copy rule?  The script only needs installing and that should
> >> >> work then.
> >> >
> >> >I just remembered why I did it this way: aren't all of the $(PROGS) are
> >> >deleted on "make clean"?  If I added $(srcdir)/cygprogctl to PROGS, I'd
> >> >have to change the "clean" rule.  I thought a copy would be easier and
> >> >less intrusive.
> >>
> >> Good point, but I think I'd prefer something like:
> >>
> >>   install: all cygprogctl
> >> 	  $(SHELL) $(updir1)/mkinstalldirs $(bindir) $(etcdir)
> >> 	  for i in $(PROGS) ${word 2,$^} ; do \
> >> 	    n=`echo $$i | sed '$(program_transform_name)'`; \
> >> 	    $(INSTALL_PROGRAM) $$i $(bindir)/$$n; \
> >> 	  done
> >>
> >> That would just let the standard install deal with installation.
> >> cgf
> >
> >Hmm, then it'll have to be
> >
> >install: all $(srcdir)/cygprogctl
> >	...
>
> No, it wouldn't.  Try it.
>
> >How is this cleaner than adding it to PROGS?
>
> Weren't you saying that adding it to PROGS causes it to be removed with
> a 'make clean'.

<quote>
  On Sat, Sep 27, 2003 at 12:42:50PM -0400, Igor Pechtchanski wrote:
  > The only thing I didn't test were the rules in the Makefile,
  > so if someone could please double-check them, it'd be great.
</quote>

> >dependence in the "all" rule, as a value for CLEAN_PROGS, and in the for
> >loop in the "install" rule.
>
> Except there is no reason for it to be in the all rule since it isn't
> being built.
>
> >Wait, doesn't ":=" expand the asigned value immediately?  Then Corinna's
> >right, and adding to PROGS after the assignment to CLEAN_PROGS will not
> >change CLEAN_PROGS (so the copy is redundant).  It would simply become
> >
> >Index: winsup/utils/Makefile.in
> >===================================================================
> >RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
> >retrieving revision 1.53
> >diff -u -p -r1.53 Makefile.in
> >--- winsup/utils/Makefile.in    12 Sep 2003 01:51:21 -0000      1.53
> >+++ winsup/utils/Makefile.in    27 Sep 2003 16:24:54 -0000
> >@@ -84,6 +84,8 @@ PROGS:=warn_dumper $(PROGS)
> > CLEAN_PROGS+=dumper.exe
> > endif
> >
> >+PROGS+=$(srcdir)/cygprogctl
> >+
> > .SUFFIXES:
> > .NOEXPORT:
>
> My proposed change eliminates the need for $(srcdir)/ but I guess the
> above is fine.
>
> cgf

Either way.  I'll resubmit the patch with whatever you and Corinna agree
upon.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
