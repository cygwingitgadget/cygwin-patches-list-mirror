Return-Path: <cygwin-patches-return-4496-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13915 invoked by alias); 11 Dec 2003 02:54:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13869 invoked from network); 11 Dec 2003 02:54:56 -0000
Message-Id: <3.0.5.32.20031210215430.0082faf0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Thu, 11 Dec 2003 02:54:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Fixing the PROCESS_DUP_HANDLE security hole (part
  1).
In-Reply-To: <20031209050834.GA15178@redhat.com>
References: <20031209043601.GA14369@redhat.com>
 <3.0.5.32.20031208221010.0082f7b0@incoming.verizon.net>
 <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net>
 <3.0.5.32.20030929215525.0082c4f0@incoming.verizon.net>
 <3.0.5.32.20031208221010.0082f7b0@incoming.verizon.net>
 <3.0.5.32.20031208224603.0082cc00@incoming.verizon.net>
 <20031209043601.GA14369@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q4/txt/msg00215.txt.bz2

At 12:08 AM 12/9/2003 -0500, Christopher Faylor wrote:
>On Mon, Dec 08, 2003 at 11:36:01PM -0500, Christopher Faylor wrote:
>>I would have but the information that the fhandler contains the
>>controlling tty is lost by the time dup is called.  Hmm.  I guess I
>>could just check the io_handle.  I'll do that.
>
>I did this but, in testing, found that there are still other problems
>with setsid assuming that it can close the cygheap ctty when there may
>still be open fds which wouldn't like that to happen.
>
>I'll work on that tomorrow.

OK, it works, but I found a few odd things.

This happens with   rxvt -d :0 -e sh

1) The master process opens /dev/ptmx and gets tty3 with fd = 4
  159  809780 [main] rxvt 46309609 open: open (/dev/ptmx, 0x8002)
  164  809944 [main] rxvt 46309609 normalize_posix_path: src /dev/ptmx
  158  810102 [main] rxvt 46309609 normalize_posix_path: /dev/ptmx = normalize_posix_path (/dev/ptmx)
  157  810259 [main] rxvt 46309609 mount_info::conv_to_win32_path: conv_to_win32_path (/dev/ptmx)
  159  810418 [main] rxvt 46309609 mount_info::conv_to_win32_path: src_path /dev/ptmx, dst \dev\ptmx, flags 0x2, rc 0
  180  810598 [main] rxvt 46309609 build_fh_pc: fh 0x616945B0
  200  810798 [main] rxvt 46309609 tty_list::allocate_tty: tty3 allocated
  282  811080 [main] rxvt 46309609 tty::make_pipes: tty3 from_slave 0xB8, to_slave 0xA8

  The forked process closes fd 4 but prints out that it closes tty2, althout it
  correctly closes the handles of tty3

  162 1213090 [main] rxvt 50291421 close: close (4)
  161 1213251 [main] rxvt 50291421 fhandler_tty_common::close: tty2 <0xB8,0xA8> closing
  169 1213420 [main] rxvt 50291421 delete_handle: nuking handle 'input_mutex'
  159 1213579 [main] rxvt 50291421 delete_handle: nuking handle 'output_mutex'
  196 1213775 [main] rxvt 50291421 close: 0 = close (4) 

2) sysinternals shows a lot more handles than expected with the new dup method.
   The reason is that the master process opens a slave /dev/tty3 as fd 5
   (this is not its ctty).
   The forked rxvt setsids, opens another slave tty3, which sets the ctty, but 
   it immediately closes that tty3.
   It then proceeds to dup2(5, 0), dup2(5, 1) and dup2(5, 2).
   Because the io_handle of 5 doesn't match the io_handle of the ctty, your 
   dup code doesn't kick in for those dups.
   Why can't we compare get_unit() with myself->ctty to determine if we can use
   the dup shortcut? (i.e. I don't understand the first quoted paragraph above).
   Also it would be safer to increment open_fhs only after the dup succeeds.

Pierre
