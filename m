From: Egor Duda <deo@logos-m.ru>
To: Christopher Faylor <cgf@redhat.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: known issues with current dll
Date: Sun, 18 Mar 2001 09:38:00 -0000
Message-id: <147785134.20010318203623@logos-m.ru>
References: <5627632543.20010316225211@logos-m.ru> <20010316163702.A22471@redhat.com> <20010316164626.A22656@redhat.com> <20010316211721.A3489@redhat.com> <19889636700.20010317160536@logos-m.ru> <20010317121739.B8183@redhat.com> <171293451.20010318180902@logos-m.ru> <20010318122036.G12880@redhat.com>
X-SW-Source: 2001-q1/msg00208.html

Hi!

Sunday, 18 March, 2001 Christopher Faylor cgf@redhat.com wrote:

CF> On Sun, Mar 18, 2001 at 06:09:02PM +0300, Egor Duda wrote:
>>Saturday, 17 March, 2001 Christopher Faylor cgf@redhat.com wrote:
>>CF> On Sat, Mar 17, 2001 at 04:05:36PM +0300, Egor Duda wrote:
>>>>to  solve  ctrl-D  problem  i  see  2 ways -- either return to the old
>>>>scheme,  when  master  sends dummy buffer to slave via pipe on eof, or
>>>>tweak   ready_to_read  stuff  for fhandler_tty_slave, so it will react
>>>>when  input_available_event  is  signalled, not when pipe handle does.
>>>>currently, i'm trying to do the latter.
>>CF> I think that the latter makes sense.
>>
>>CF> Maybe it's time to separate the pipe stuff from the tty stuff in select.cc
>>
>>this  patch  fixes  ctrl-d  problem.  this  also  make  cygwin discard
>>contents of input buffer in canonical mode when user type VINTR, VSTOP
>>or VSUSP character.

CF> Looks perfect, with one comment:

CF> @@ -762,4 +762,6 @@ public:
         
CF>    off_t lseek (off_t, int) { return 0; }
CF> +  virtual select_record *select_read (select_record *s);
CF> +  int ready_for_read (int fd, DWORD howlong, int ignra);
CF>  };

CF> Is there any reason for this method to be virtual?

no. actually, 'virtual' here is ignored as this method was declared as
virtual in the base class. i'll remove 'virtual' here.

CF> Otherwise, please check this in.  It will be interesting to see if this
CF> fixes Earnie's problem.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

