From: egor duda <deo@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: src/winsup/cygwin ChangeLog thread.cc thread.h ...
Date: Thu, 27 Sep 2001 11:08:00 -0000
Message-id: <099067241.20010927220834@logos-m.ru>
References: <20010925114527.23687.qmail@sourceware.cygnus.com> <14472692346.20010927144858@logos-m.ru> <007b01c14743$2a0005b0$01000001@lifelesswks> <12280602580.20010927170049@logos-m.ru> <008301c1475e$afb0c4e0$01000001@lifelesswks> <20010927140440.B32577@redhat.com>
X-SW-Source: 2001-q3/msg00217.html

Hi!

Thursday, 27 September, 2001 Christopher Faylor cgf@redhat.com wrote:

>>I'm having some trouble with cvs+ssh with this patch .. though I'm not
>>sure why. For a little while I though it might be chris's tuesday
>>sleep(1) change, because I was getting strange results from pspec> I'm
>>not sure though.

CF> Huh?  What is my "sleep(1)" change?  The only change I made on Tuesday was
CF> to fhandler_tty_common::ready_for_read.  How would that affect cvs?

it does. i've seen the following at the end of strace (where ssh
seemed to block in ReadFile() on empty pipe)

  517 12076688 [main] ssh 7436 peek_socket: considering handle 0x24
  242 12076930 [main] ssh 7436 peek_socket: adding read fd_set /dev/tcp, fd 4
  235 12077165 [main] ssh 7436 peek_socket: adding write fd_set /dev/tcp, fd 4
  291 12077456 [main] ssh 7436 peek_socket: WINSOCK_SELECT returned 1
  434 12077890 [main] ssh 7436 set_bits: me 0xA013CC0, testing fd 4 (/dev/tcp)
  281 12078171 [main] ssh 7436 set_bits: ready 1
  242 12078413 [main] ssh 7436 peek_pipe: already ready
  236 12078649 [main] ssh 7436 set_bits: me 0xA013C78, testing fd 0 (/dev/piper)
  241 12078890 [main] ssh 7436 set_bits: ready 1
  233 12079123 [main] ssh 7436 select_stuff::poll: returning 2
  242 12079365 [main] ssh 7436 select_stuff::cleanup: calling cleanup routines
  248 12079613 [main] ssh 7436 select_stuff::~select_stuff: deleting select records
  694 12080307 [main] ssh 7436 _read: read (0, 0x24AD7C4, 8192) blocking, sigcatchers 3
  320 12080627 [main] ssh 7436 peek_pipe: /dev/piper, saw EOF
  261 12080888 [main] ssh 7436 peek_pipe: saw eof on '/dev/piper'
  238 12081126 [main] ssh 7436 fhandler_pipe::ready_for_read: returning 1

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
