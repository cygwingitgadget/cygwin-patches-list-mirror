From: Egor Duda <deo@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: tty-slave read() patch
Date: Wed, 28 Feb 2001 12:54:00 -0000
Message-id: <192120339128.20010228235310@logos-m.ru>
References: <115104181535.20010228192351@logos-m.ru> <20010228140956.L2327@redhat.com>
X-SW-Source: 2001-q1/msg00133.html

Hi!

Wednesday, 28 February, 2001 Christopher Faylor cgf@redhat.com wrote:

>>  i've  changed  the  way  fhandler_tty_slave::read  communicates with
>>master.   it  addresses  a  couple  of  problems.  currently,  when in
>>non-canonical  mode  and  vmin=1,  read() never reads more then 1 byte
>>from  the  pipe,   even   if  more  input  is available. the result is
>>following:  when user  presses  F1 key in ssh window, this keypress is
>>actually  sent  to server  not  in  one  packet but in 4. This is very
>>noticeable on slow links. it also eliminates pipe polling.

CF> Can you go into more detail on how you accomplished this? It looks
CF> like you have used a mutex for communicating between the processes. 

tty  master  communicates with slaves by setting input_available_event
whenever it puts new input in pipe from master to slave. mutex is used
to serialize access to the pipe,  so  that  several  slaves  won't  do
PeekNamedPipe()  and  ReadFile()  simultaneously,  and  so that master
won't     set   input_available_event  again  before  waked slave read
info from pipe.

CF>    Won't  this  cause  problems when communicating with non-cygwin
CF> applications?

as far as i can understand from source, if slave have pipe's handle to
get  input  from  master, it can assume that master is cygwin process.
that  means  that  opening input_mutex from slave's side is safe, this
mutex  (end  event) should already exist. if cygwin master opens  pipe
and  communicate   though  it  with  non-cygwin  child, it will freely
acquire and release input mutex, since noone else hold it.

the  only  possible  problem is that master can have two children, one
cygwin  and  one non-cygwin, and they both are trying to read. in this
case  it's  possible that cygwin child will see input_available_event,
but  won't  see  any  data in pipe, since non-cygwin child had already
eaten it. but i think it was the same in old code, too.

i've  tested  it  in  either  tty  or  notty  mode and with non-cygwin
programs in local console and via ssh.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

