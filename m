Return-Path: <cygwin-patches-return-4274-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 595 invoked by alias); 30 Sep 2003 15:58:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 583 invoked from network); 30 Sep 2003 15:58:34 -0000
Date: Tue, 30 Sep 2003 15:58:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: New program: cygtweak
Message-ID: <20030930155833.GA29428@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.44.0208161539040.21909-100000@slinky.cs.nyu.edu> <20030927034235.GA18807@redhat.com> <Pine.GSO.4.56.0309271124210.3193@slinky.cs.nyu.edu> <20030930121609.GA2022@cygbert.vinschen.de> <Pine.GSO.4.56.0309301058290.3193@slinky.cs.nyu.edu> <20030930150956.GE20635@redhat.com> <Pine.GSO.4.56.0309301112320.3193@slinky.cs.nyu.edu> <20030930154434.GK20635@redhat.com> <Pine.GSO.4.56.0309301146400.3193@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0309301146400.3193@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00290.txt.bz2

On Tue, Sep 30, 2003 at 11:49:44AM -0400, Igor Pechtchanski wrote:
>On Tue, 30 Sep 2003, Christopher Faylor wrote:
>
>> On Tue, Sep 30, 2003 at 11:29:29AM -0400, Igor Pechtchanski wrote:
>> >On Tue, 30 Sep 2003, Christopher Faylor wrote:
>> >
>> >> On Tue, Sep 30, 2003 at 11:02:39AM -0400, Igor Pechtchanski wrote:
>> >> >On Tue, 30 Sep 2003, Corinna Vinschen wrote:
>> >> >> Wouldn't it be sufficient to add $(srcdir)/cygprogctl to PROGS and to
>> >> >> drop the copy rule?  The script only needs installing and that should
>> >> >> work then.
>> >> >
>> >> >I just remembered why I did it this way: aren't all of the $(PROGS) are
>> >> >deleted on "make clean"?  If I added $(srcdir)/cygprogctl to PROGS, I'd
>> >> >have to change the "clean" rule.  I thought a copy would be easier and
>> >> >less intrusive.
>> >>
>> >> Good point, but I think I'd prefer something like:
>> >>
>> >>   install: all cygprogctl
>> >> 	  $(SHELL) $(updir1)/mkinstalldirs $(bindir) $(etcdir)
>> >> 	  for i in $(PROGS) ${word 2,$^} ; do \
>> >> 	    n=`echo $$i | sed '$(program_transform_name)'`; \
>> >> 	    $(INSTALL_PROGRAM) $$i $(bindir)/$$n; \
>> >> 	  done
>> >>
>> >> That would just let the standard install deal with installation.
>> >> cgf
>> >
>> >Hmm, then it'll have to be
>> >
>> >install: all $(srcdir)/cygprogctl
>> >	...
>>
>> No, it wouldn't.  Try it.
>>
>> >How is this cleaner than adding it to PROGS?
>>
>> Weren't you saying that adding it to PROGS causes it to be removed with
>> a 'make clean'.
>
><quote>
>  On Sat, Sep 27, 2003 at 12:42:50PM -0400, Igor Pechtchanski wrote:
>  > The only thing I didn't test were the rules in the Makefile,
>  > so if someone could please double-check them, it'd be great.
></quote>

1) I towed the car to the driveway, the battery may be dead.  (igor)

2) You can replace the battery. (corinna)

3) I considered doing that but I don't have the proper wrench. (igor)

4) You could use jumper cables to get the car started.  (cgf)

5) How is that better than replacing the battery?  (igor)

6) You said that you didn't have the proper wrench.  (cgf)

7) I said "the battery *may* be dead".  (igor)

cgf
