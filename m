From: Egor Duda <deo@logos-m.ru>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: fhandler_console
Date: Fri, 02 Mar 2001 04:54:00 -0000
Message-id: <16264348483.20010302155321@logos-m.ru>
References: <16286062992.20010216183758@logos-m.ru> <20010219214951.A23483@redhat.com> <7888578378.20010220130012@logos-m.ru> <17613156858.20010223151715@logos-m.ru> <20010226191432.E6209@redhat.com> <20010228182620.R8464@cygbert.vinschen.de> <109112986916.20010228215037@logos-m.ru> <20010228203308.V8464@cygbert.vinschen.de> <83117508187.20010228230559@logos-m.ru> <20010301101600.C874@cygbert.vinschen.de> <20010302132358.Q5481@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00141.html

Hi!

Friday, 02 March, 2001 Corinna Vinschen cygwin-patches@cygwin.com wrote:

CV> the problem disappeared after a full rebuild of Cygwin today.
CV> I fear I have created the problem by myself for some reason.
CV> The rebuild solved the problem immediately. Is it possible
CV> that you always need a full rebuild after there's a change
CV> in class hierarchies? Your change has moved some class members
CV> in the fhandler class hierarchy, so...

hmm.  i  don't  think  so.  unless  something  goes  wrong  with  your
dependency   files.  i'm  doing test builds without doing 'make clean'
beforehand.  i did complete rebuild almost half year ago. and yet i do
change  class  members   from  time  to  time.  after fhandler_console
patch   there   was   a  lot of files being rebuilt (all that  include
fhandler.h).   The   only   reason  of  broken build i can imagine  is
that  patching and building is done on different machines, with source
code   shared   over   network,  and  their  clocks  wasn't  properly
synchronized. 

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

