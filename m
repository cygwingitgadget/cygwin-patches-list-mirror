From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: rxvt pops up console with 2001-Aug-07 shapshot
Date: Sat, 25 Aug 2001 10:28:00 -0000
Message-id: <20010825132846.B21709@redhat.com>
References: <4268681989.20010822182438@logos-m.ru> <s1sbsl7hp0u.fsf@jaist.ac.jp> <20010823103544.H20320@cygbert.vinschen.de> <s1sheuycxbu.fsf@jaist.ac.jp> <s1sg0aicqdh.fsf@jaist.ac.jp>
X-SW-Source: 2001-q3/msg00087.html

On Fri, Aug 24, 2001 at 08:23:38AM +0900, Kazuhiro Fujieda wrote:
>>>> On 24 Aug 2001 05:53:25 +0900
>>>> Kazuhiro Fujieda <fujieda@jaist.ac.jp> said:
>
>> I have another idea:
>> 
>> If the process has a pty slave, setsid() shouldn't call
>> FreeConsole() because it has a chance to execute Windows
>> application on the pty.
>> 
>> I will try it later.
>
>I've done.
>The following patch can solve the problem indicated by the subject.
>
>2001-08-24  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
>
>	* syscalls.cc (check_tty_fds): New function. Check whether there
>	is a fd referring to pty slave.
>	(setsid): Don't detach console if the process has a pty slave.

Looks good to me.  I've applied this patch.

cgf
