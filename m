From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: tty-slave read() patch
Date: Wed, 28 Feb 2001 11:10:00 -0000
Message-id: <20010228140956.L2327@redhat.com>
References: <115104181535.20010228192351@logos-m.ru>
X-SW-Source: 2001-q1/msg00130.html

On Wed, Feb 28, 2001 at 07:23:51PM +0300, Egor Duda wrote:
>Hi!
>
>  i've  changed  the  way  fhandler_tty_slave::read  communicates with
>master.   it  addresses  a  couple  of  problems.  currently,  when in
>non-canonical  mode  and  vmin=1,  read() never reads more then 1 byte
>from  the  pipe,   even   if  more  input  is available. the result is
>following:  when user  presses  F1 key in ssh window, this keypress is
>actually  sent  to server  not  in  one  packet but in 4. This is very
>noticeable on slow links. it also eliminates pipe polling.

Can you go into more detail on how you accomplished this?  It looks like
you have used a mutex for communicating between the processes.  Won't
this cause problems when communicating with non-cygwin applications?

cgf
