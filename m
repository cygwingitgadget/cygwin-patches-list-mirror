Return-Path: <cygwin-patches-return-7890-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29838 invoked by alias); 4 Jun 2013 11:53:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29825 invoked by uid 89); 4 Jun 2013 11:53:31 -0000
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,TW_CG autolearn=ham version=3.3.1
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Tue, 04 Jun 2013 11:53:31 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 87857520999; Tue,  4 Jun 2013 13:53:27 +0200 (CEST)
Date: Tue, 04 Jun 2013 11:53:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] DocBook XML toolchain modernization
Message-ID: <20130604115327.GB32667@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130425084305.GA29270@calimero.vinschen.de> <517F15AF.5080307@etr-usa.com> <20130430184703.GB6865@ednor.casa.cgf.cx> <51801469.9070606@etr-usa.com> <20130430190706.GC6865@ednor.casa.cgf.cx> <5181AF17.2090409@etr-usa.com> <20130523140211.GA5525@calimero.vinschen.de> <20130523141140.GB5525@calimero.vinschen.de> <519E680A.8010308@etr-usa.com> <20130523195000.GC25295@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130523195000.GC25295@calimero.vinschen.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SW-Source: 2013-q2/txt/msg00028.txt.bz2

Hi Warren,

On May 23 21:50, Corinna Vinschen wrote:
> On May 23 13:03, Warren Young wrote:
> > On 5/23/2013 08:11, Corinna Vinschen wrote:
> > >On May 23 16:02, Corinna Vinschen wrote:
> > >>For some reason doc/Makefile.in has lost all dependencies
> > 
> > I noted that in the original proposal: one of the things you got
> > from doctool is automatic dependency generation.  I'd put an item on
> > the Wishlist to this effect, saying I needed to replace it.
> > 
> > At your prompting, I now have.  There is a new script called
> > xidepend which generates Makefile.dep, which is included (and
> > cleaned, if asked) by Makefile.in.
> > 
> > It's not perfect.  Because of the time it takes to run the
> > dependency chaser, I've elected to make it dependent on only changes
> > to the top-level XML files.  This means that if you add an XInclude
> > to one of the leaf files, the referenced file won't get added to the
> > dependency list for the top-level file that indirectly depends on it
> > until you remove Makefile.dep, forcing its re-generation.
> 
> That should be sufficient.  We're only adding files pretty seldom
> anyway.

Unfortunately it doesn't work.  I just changed only the new-features.xml
file and `make' claimed "Nothing to be done for `all'".

Inspecting the generated Makefile.dep, I see this:

  /home/corinna/src/cygwin/vanilla/winsup/doc/cygwin-ug-net//home/corinna/src/cygwin/vanilla/winsup/doc/cygwin-ug-net.html: legal.xml overview.xml setup-net.xml using.xml programming.xml
  /home/corinna/src/cygwin/vanilla/winsup/doc/faq//home/corinna/src/cygwin/vanilla/winsup/doc/faq.html: faq-what.xml faq-setup.xml faq-resources.xml faq-using.xml faq-api.xml faq-programming.xml faq-copyright.xml

As you can see, the paths of the make targets are wrong, *and* the
list of dependencies is broken as well.

Running xidepend in the source file results in:

  cygwin-ug-net/cygwin-ug-net.html: legal.xml overview.xml setup-net.xml using.xml programming.xml  ov-ex-win.xml ov-ex-unix.xml highlights.xml new-features.xml  setup-env.xml setup-maxmem.xml setup-locale.xml setup-files.xml  pathnames.xml textbinary.xml filemodes.xml specialnames.xml cygwinenv.xml ntsec.xml cygserver.xml ../utils/utils.xml effectively.xml  gcc.xml gdb.xml dll.xml windres.xml 
  faq/faq.html: faq-what.xml faq-setup.xml faq-resources.xml faq-using.xml faq-api.xml faq-programming.xml faq-copyright.xml 

This looks a lot like you're still testing this with a in-tree build.

Again, as cgf already wrote, we do *NOT* support in-tree builds.  Always
test with a separate build directory, please.

I fixed this now temporarily like this:

- I fixed the generation of the basename in xidepend to take VPATH
  into account.

- I moved the `include Makefile.dep to the end of Makefile.in, otherwise
  the Makefile.dep rules clobber the all rule.

- I dropped the "$(srcdir)" from that include since Makefile.dep is
  created in the build dir.

- I fixed the Makefile.dep build rule to work from any build dir.

- I removed faq.xml as dependency from the Makefile.dep build rule
  since the faq sources are given via $FAQ_SOURCES anyway.

- I added the necessary rule to rebuild Makefile automatically if
  Makefile.in changes.

This works now, but it's unsatisfactory, because we now have three
different ways to implement dependencies:

- cygwin-api deps are generated by tweaking Makefile.in via doctool

- faq deps are generated via setting a variable and referring the
  variable in the build dependency.

- cygwin-ug-net deps are generated via xidepend and create a separate
  Makefile.dep file with a dependency rule.

It would be nice if this could be merged into one unified way to
generate the deps soonish, with the simple requirement that it should
work always, and from a spearate build dir in the first place.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
