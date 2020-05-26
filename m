Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id A0E213893676
 for <cygwin-patches@cygwin.com>; Tue, 26 May 2020 08:27:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A0E213893676
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N17l4-1itgUz2H74-012UDN for <cygwin-patches@cygwin.com>; Tue, 26 May 2020
 10:27:39 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id ECA65A80FF8; Tue, 26 May 2020 10:27:36 +0200 (CEST)
Date: Tue, 26 May 2020 10:27:36 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/3 v3] Cygwin: tzcode resync: basics
Message-ID: <20200526082736.GH6801@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200522093253.995-1-mark@maxrnd.com>
 <20200522093253.995-2-mark@maxrnd.com>
 <20200525120634.GD6801@calimero.vinschen.de>
 <20200525154901.GG6801@calimero.vinschen.de>
 <bcff83ee-c3b6-0b99-90d6-650694562250@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bcff83ee-c3b6-0b99-90d6-650694562250@maxrnd.com>
X-Provags-ID: V03:K1:VXm3/r/dW3lX0yS6cxUdk25nIWRUANURcpC6Fr+vJfLTFlqBbf9
 93a9xSfB3BSB7kXWHQPs2gvPIpPsGAHrBexjkFeWYVUjQYfebP3g8lfYlTIXC7jByLuFBj1
 boJLDpjJmTL7DmojMX+z5MVDXg1W0woCWueRUbPqxuYwpX0wrOQumkYp5uQeVGFRqI6d/aY
 Th3W+WWMAvJq+yWb9QUJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pBYfs9M00xs=:+UX4Wa00hY85QOHN5iH9sV
 vo5qME6Uvch1kuYqaIArnytc2WUtkBmF5+2wKLRhuiUHey0lZvhuSb9c+WaFmEBas2/AtGapf
 /mifu5bJ/sVjuZAFYy14o8+D3nC2jhmnQXcU/uc0kA5t+zeTXgNMT5oxF7IlXkeK9USpsSbgn
 UGGXRh+LUk47D+7Bw/ZdM0dPyfG0bFFcxHV/8DxI+6riC6EeADdXlHQlgd/6xT7oDgFLdwRVV
 A7GjU/w9aN+MDegKYlN4YA8f3uyDnqP0abMnZ7HTJExy/Krh3J5NOyT9CHyGBa+W/1JXOGebL
 xh42yFj2/60FSK+0DAb0qEOjxHBNfEhfmUXpaVtAyxtlBf5a1X7XS6nBSaurlECsLwQVqlk5m
 3ORLOQg6N5tk6C9E6rwAk3Z1zvA9eMAGzJ1crNflNzTKkQG1b/X7Q9c/JRVBwKRNRjhAFmjHS
 TigBY3sO7YZePqUMee5nfxnemmfTgA8oS2T8ob8iFuKSz6JNF2T2Q6vPmo+nmVio2wG0X24wc
 EgIBnvO1uKhp0jazoIkjSdcXopMNczqXVre7SfZvJAb+8eNKZ5JXe+7QBiKrUB9eaQ2ZoPX3S
 hAndwOXhaUPZiqwHPudnMiIcC7qe0ieTpGUX/eQbeh5lvOS+TKCyKH6V8Ct3tC61XXBQrxxp8
 4UI95LhsPb+NNA/NNk81OYHMHHRB/VKsAqfMKguaFroJSos1R15haDZLDB4MJgnCUMfqt6rtA
 6nkgLVR72Es6nrsKv17hpYOd2KiimeIb6aa+bYax/p+zta9Rd82PUqv1t9XkgMojielrj6ao5
 kDT8UY7IF5ZzsABNNuLZW68wa5eBW3f3NOiIR8PEtBhD5uclHz1xnx6onzduw7EKEIeNKWz
X-Spam-Status: No, score=-98.6 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 26 May 2020 08:27:42 -0000

Hi Mark,

On May 26 00:09, Mark Geisert wrote:
> Hi Corinna,
> 
> Corinna Vinschen wrote:
> > Hi Mark,
> > 
> > > On May 22 02:32, Mark Geisert wrote:
> > On May 25 14:06, Corinna Vinschen wrote:
> > > > Modifies winsup/cygwin/Makefile.in to build localtime.o from items in
> > > > new winsup/cygwin/tzcode subdirectory.  Compiler option "-fpermissive"
> > > > is used to accept warnings about missing casts on the return values of
> > > > malloc() calls.  This patch also removes existing localtime.cc and
> > > > tz_posixrules.h from winsup/cygwin as they are superseded by the
> > > > subsequent patches in this set.
> > > > [...]
> > > > @@ -246,6 +246,15 @@ MATH_OFILES:= \
> > > >   	tgammal.o \
> > > >   	truncl.o
> > > > +TZCODE_OFILES:=localtime.o
> > > > +
> > > > +localtime.o: $(srcdir)/tzcode/localtime.cc $(srcdir)/tzcode/localtime.c.patch
> > > > +	(cd $(srcdir)/tzcode && \
> > > > +		patch -u -o localtime.c.patched localtime.c localtime.c.patch)
> > > > +	$(CXX) ${CXXFLAGS} ${localtime_CFLAGS} \
> > > > +		-I$(target_builddir)/winsup/cygwin \
> > > > +		-I$(srcdir) -I$(srcdir)/tzcode -c -o $@ $<
> > > > +
> > > 
> > > This doesn't work well for me.  That rule is the top rule in Makefile.in
> > > now, so just calling `make' doesn't build the DLL anymore, only
> > > localtime.o.  The rule should get moved way down Makefile.in.
> 
> Oops.  My workflow didn't make this apparent to me.  Thanks for the fix.
> 
> > > What still bugs me [...etc...]
> > > I attached the followup patches to this mail.  Please scrutinize it and
> > > don't hesitate to discuss the changes.  For a start:
> > > 
> > > - I do not exactly like the name "localtime_wrapper.c" but I don't
> > >    have a better idea.
> 
> localtime_cygwin.c?  cyglocaltime.c?  Not much nicer IMO.
> 
> > > - muto's are C++-only, so I changed rwlock_wrlock/rwlock_unlock to use
> > >    Windows SRWLocks.  I think this is a good thing and I'm inclined
> > >    to drop the muto datatype entirely in favor of using SRWLocks since
> > >    they are cleaner and langauge-agnostic.
> > 
> > Two changes in my patchset:
> > 
> > - I didn't initialize the SRWLOCK following the books.  Fixed that.
> > 
> > - Rather than creating the patched file in the source dir, I changed
> >    the Makefile.in rule so that the patched file is created in the build
> >    dir.  This drops the requirement to tweak .gitignore.  It's also
> >    cleaner.
> > 
> > - Splitting the build rule for localtime.c.patched from the build rule
> >    for localtime.o makes sure that the patched file is not regenerated
> >    every time we build localtime.o.
> > 
> > I attached my patchset again, but only patch 3 and 4 actually changed.
> 
> All the above are great improvements.  But I would now remove the "// Get
> ready to wrap NetBSD's localtime.c" line and blank line following it.

(Belatedly) done.

> Good to go!

Great!  I added two more tweaks:

- I renamed the generated file from localtime.c.patched to
  localtime.patched.c so the .c suffix remains intact.  Seems
  a bit cleaner to me.  I also added it to the 'clean' rule,
  so that it gets removed at `make clean' time.

- I simplified the #includes in the wrapper file.  The paths to these
  headers are searched anyway, so they don't have to be written out
  explicitely.

> Thank you,

Good job, thank you!


Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
