From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com, cygwin-xfree@cygwin.com
Subject: Re: [PATCH] Re: pthread -- Corinna?
Date: Mon, 16 Apr 2001 20:06:00 -0000
Message-id: <20010416230650.A25111@redhat.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF79BE@itdomain002.itdomain.net.au> <20010416225423.A24590@redhat.com>
X-SW-Source: 2001-q2/msg00083.html

On Mon, Apr 16, 2001 at 10:54:23PM -0400, Christopher Faylor wrote:
>It still seems like there is potential for error if two threads call
>get_id_from_sid.  One may correctly read a UID via getpwuid, one will
>short-circuit.  Hmm.  This would be a problem even if we were attempting
>to detect recursion via a static variable.
>
>Maybe we need another passwd_state == 'initializing'.
>
>Hmm, again.  We actually have *three* variables controlling how this
>operates now, passwd_state, passwd_sem, and etc_passwd_mutex.  IMO,
>that's too many.

On reflection, I don't see how we can ever get into the state where
fopen is called recursively from read_etc_passwd.  Your mutex protects
against that.  So, I am still of the opinion that we can remove the
passwd_sem.

And, we should do something similar for group_sem, too.

cgf
