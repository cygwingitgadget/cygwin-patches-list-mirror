From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: fhandler_console
Date: Fri, 02 Mar 2001 05:35:00 -0000
Message-id: <20010302143512.S5481@cygbert.vinschen.de>
References: <7888578378.20010220130012@logos-m.ru> <17613156858.20010223151715@logos-m.ru> <20010226191432.E6209@redhat.com> <20010228182620.R8464@cygbert.vinschen.de> <109112986916.20010228215037@logos-m.ru> <20010228203308.V8464@cygbert.vinschen.de> <83117508187.20010228230559@logos-m.ru> <20010301101600.C874@cygbert.vinschen.de> <20010302132358.Q5481@cygbert.vinschen.de> <16264348483.20010302155321@logos-m.ru>
X-SW-Source: 2001-q1/msg00142.html

Doh, wrong mailing list...

On Fri, Mar 02, 2001 at 03:53:21PM +0300, Egor Duda wrote:
> Hi!
> 
> Friday, 02 March, 2001 Corinna Vinschen cygwin-patches@cygwin.com wrote:
> 
> CV> the problem disappeared after a full rebuild of Cygwin today.
> CV> I fear I have created the problem by myself for some reason.
> CV> The rebuild solved the problem immediately. Is it possible
> CV> that you always need a full rebuild after there's a change
> CV> in class hierarchies? Your change has moved some class members
> CV> in the fhandler class hierarchy, so...
> 
> hmm.  i  don't  think  so.  unless  something  goes  wrong  with  your
> dependency   files.  i'm  doing test builds without doing 'make clean'
> beforehand.  i did complete rebuild almost half year ago. and yet i do
> change  class  members   from  time  to  time.  after fhandler_console
> patch   there   was   a  lot of files being rebuilt (all that  include
> fhandler.h).   The   only   reason  of  broken build i can imagine  is
> that  patching and building is done on different machines, with source
> code   shared   over   network,  and  their  clocks  wasn't  properly
> synchronized. 

No everything was patched and build locally.

Anyway, it's ok. Now you can create NEW EXCITING patches instead
of debugging old boring patches :-)

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
