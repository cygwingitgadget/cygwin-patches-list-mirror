Return-Path: <cygwin-patches-return-4270-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1431 invoked by alias); 30 Sep 2003 15:09:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1422 invoked from network); 30 Sep 2003 15:09:57 -0000
Date: Tue, 30 Sep 2003 15:09:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: New program: cygtweak
Message-ID: <20030930150956.GE20635@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.44.0208161539040.21909-100000@slinky.cs.nyu.edu> <20030927034235.GA18807@redhat.com> <Pine.GSO.4.56.0309271124210.3193@slinky.cs.nyu.edu> <20030930121609.GA2022@cygbert.vinschen.de> <Pine.GSO.4.56.0309301058290.3193@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0309301058290.3193@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00286.txt.bz2

On Tue, Sep 30, 2003 at 11:02:39AM -0400, Igor Pechtchanski wrote:
>On Tue, 30 Sep 2003, Corinna Vinschen wrote:
>> Wouldn't it be sufficient to add $(srcdir)/cygprogctl to PROGS and to
>> drop the copy rule?  The script only needs installing and that should
>> work then.
>
>I just remembered why I did it this way: aren't all of the $(PROGS) are
>deleted on "make clean"?  If I added $(srcdir)/cygprogctl to PROGS, I'd
>have to change the "clean" rule.  I thought a copy would be easier and
>less intrusive.

Good point, but I think I'd prefer something like:

  install: all cygprogctl
	  $(SHELL) $(updir1)/mkinstalldirs $(bindir) $(etcdir) 
	  for i in $(PROGS) ${word 2,$^} ; do \
	    n=`echo $$i | sed '$(program_transform_name)'`; \
	    $(INSTALL_PROGRAM) $$i $(bindir)/$$n; \
	  done

That would just let the standard install deal with installation.

cgf
