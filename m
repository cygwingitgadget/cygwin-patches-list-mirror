Return-Path: <cygwin-patches-return-4268-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23672 invoked by alias); 30 Sep 2003 14:56:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23639 invoked from network); 30 Sep 2003 14:56:30 -0000
Date: Tue, 30 Sep 2003 14:56:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: New program: cygtweak
Message-ID: <20030930145629.GC20635@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.44.0208161539040.21909-100000@slinky.cs.nyu.edu> <20030927034235.GA18807@redhat.com> <Pine.GSO.4.56.0309271124210.3193@slinky.cs.nyu.edu> <20030930121609.GA2022@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930121609.GA2022@cygbert.vinschen.de>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00284.txt.bz2

On Tue, Sep 30, 2003 at 02:16:09PM +0200, Corinna Vinschen wrote:
>On Sat, Sep 27, 2003 at 12:42:50PM -0400, Igor Pechtchanski wrote:
>> The only thing I didn't test were the rules in the Makefile,
>> so if someone could please double-check them, it'd be great. 
>
>> Index: winsup/utils/Makefile.in
>> ===================================================================
>> RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
>> retrieving revision 1.53
>> diff -u -p -r1.53 Makefile.in
>> --- winsup/utils/Makefile.in	12 Sep 2003 01:51:21 -0000	1.53
>> +++ winsup/utils/Makefile.in	27 Sep 2003 16:24:54 -0000
>> @@ -84,12 +84,17 @@ PROGS:=warn_dumper $(PROGS)
>>  CLEAN_PROGS+=dumper.exe
>>  endif
>>  
>> +PROGS+=cygprogctl
>> +
>>  .SUFFIXES:
>>  .NOEXPORT:
>>  
>>  .PHONY: all install clean realclean warn_dumper
>>  
>>  all: Makefile $(PROGS)
>> +
>> +cygprogctl: $(srcdir)/cygprogctl
>> +	cp -p $< $@
>>  
>>  strace.exe: strace.o path.o $(MINGW_DEP_LDLIBS)
>>  ifdef VERBOSE
>
>Wouldn't it be sufficient to add $(srcdir)/cygprogctl to PROGS and to
>drop the copy rule?  The script only needs installing and that should
>work then.

That sounds right to me.  I'm still not wild about the name but nothing
better comes to mind (other than cygoption).

Before I say "ok, check this in" does anyone have a brilliant idea for
a name for this script?

cgf
