From: Christopher Faylor <cgf@redhat.com>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: tty-slave read() patch
Date: Wed, 28 Feb 2001 19:53:00 -0000
Message-id: <20010228224710.A756@redhat.com>
References: <115104181535.20010228192351@logos-m.ru> <20010228140956.L2327@redhat.com> <192120339128.20010228235310@logos-m.ru> <20010228210002.A9086@redhat.com>
X-SW-Source: 2001-q1/msg00138.html

On Wed, Feb 28, 2001 at 09:00:02PM -0500, Christopher Faylor wrote:
>On Wed, Feb 28, 2001 at 11:53:10PM +0300, Egor Duda wrote:
>>CF>    Won't  this  cause  problems when communicating with non-cygwin
>>CF> applications?
>>
>>as far as i can understand from source, if slave have pipe's handle to
>>get  input  from  master, it can assume that master is cygwin process.
>>that  means  that  opening input_mutex from slave's side is safe, this
>>mutex  (end  event) should already exist. if cygwin master opens  pipe
>>and  communicate   though  it  with  non-cygwin  child, it will freely
>>acquire and release input mutex, since noone else hold it.
>>
>>the  only  possible  problem is that master can have two children, one
>>cygwin  and  one non-cygwin, and they both are trying to read. in this
>>case  it's  possible that cygwin child will see input_available_event,
>>but  won't  see  any  data in pipe, since non-cygwin child had already
>>eaten it. but i think it was the same in old code, too.
>>
>>i've  tested  it  in  either  tty  or  notty  mode and with non-cygwin
>>programs in local console and via ssh.
>
>So, a non-cygwin program running under ssh, via a pty, will work correctly?
>In that case, check her in, with much thanks.
>
>One minor nit, however.  Please adhere to the coding standards of the
>code your changing.  You seem to have added at least one or two
      you're

Grrr...  Pet peeve...

cgf
