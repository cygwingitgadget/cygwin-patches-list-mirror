From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: race in tty handling code
Date: Mon, 26 Feb 2001 16:12:00 -0000
Message-id: <20010226191134.D6209@redhat.com>
References: <2170208116.20010222140316@logos-m.ru> <1989782887.20010222185416@logos-m.ru>
X-SW-Source: 2001-q1/msg00117.html

On Thu, Feb 22, 2001 at 06:54:16PM +0300, Egor Duda wrote:
>Hi!
>
>Thursday, 22 February, 2001 Egor Duda deo@logos-m.ru wrote:
>
>ED>   if  application performs write to tty with ONLCR flag turned off and
>ED>   then    immediately    calls    tcsetattr    to    turn    it    on,
>ED> fhandler_pty_master::process_slave_output     gets    confused.   it
>ED> calculates rlen according to old tty settings and signals output_done
>ED> event.  then  it process the buffer according to new tty settings, and
>ED> stumbles  over  internal  error  message. Patch attached  (well,  this
>ED> time  i  triple-checked  that  it does contain changelog entry :)
>
>the  patch  is  wrong, however :( it seems that pty_master cannot tell
>when   it   got   all  data  from  slave's  write()  and  can  signal
>output_done_event.     How    about    sending
>'<data_length (1 byte)><data_block (up to 255 bytes)>'
>through  pipe  between  slave  and  master?  this  would  also  solve
>PeekNamedPipe  polling  problem.

I've thought about doing this but it would break using cygwin ptys with non-cygwin
apps.

I guess you could open up another channel with this info but that channel would
get filled up in the same scenario.

cgf
