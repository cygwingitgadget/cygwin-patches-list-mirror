From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: Re: NT Shutdown Handling Patch
Date: Wed, 18 Jul 2001 15:03:00 -0000
Message-id: <s1sy9pl3nei.fsf@jaist.ac.jp>
References: <20010718165558.G608@dothill.com>
X-SW-Source: 2001-q3/msg00025.html

>>> On Wed, 18 Jul 2001 16:55:58 -0400
>>> Jason Tishler <jason@tishler.net> said:

> The attached patch changes ctrl_c_handler() to send SIGTERM (instead
> of SIGHUP) when NT shuts down (or a close event is received).  See the
> following for the motivation:
> 
>     http://www.cygwin.com/ml/cygwin/2001-07/msg00827.html
>     http://www.cygwin.com/ml/cygwin/2001-07/msg01060.html

My daemon patch includes the change against ctrl_c_handler
similar to yours. In my patch, the ctrl_c_handler send SIGTERM
in response to CTRL_SHUTDOWN_EVENT, while send SIGHUP to
terminate shells in response to CTRL_CLOSE_EVENT.

Please see
http://cygwin.com/ml/cygwin-patches/2001-q3/msg00010.html
____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  Center for Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
