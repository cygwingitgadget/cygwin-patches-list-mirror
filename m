From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: einval-on-wrong-args patch
Date: Fri, 16 Feb 2001 09:07:00 -0000
Message-id: <20010216120709.B19422@redhat.com>
References: <12986060127.20010216183755@logos-m.ru>
X-SW-Source: 2001-q1/msg00081.html

On Fri, Feb 16, 2001 at 06:37:55PM +0300, Egor Duda wrote:
>Hi!
>
>[pedantic mode on]
>
>  return  EINVAL  if  signal()  or  lseek()  are  called  with illegal
>arguments.
>
>[pedantic mode off :)]

Either your signal() change is not quite right, or sigaction() is wrong.
sigaction() allows setting the handler for SIGKILL to SIG_DFL.  Is
that incorrect?  If not, then please modify your change (and check it in).
If it is the incorrect behavior, could you fix sigaction, too?

cgf
