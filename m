From: Earnie Boyd <earnie_boyd@yahoo.com>
To: Kazuhiro Fujieda <fujieda@jaist.ac.jp>, cygwin-patches@cygwin.com
Subject: Re: chroot("/") can't work.
Date: Wed, 29 Nov 2000 05:17:00 -0000
Message-id: <20001129131743.15031.qmail@web117.yahoomail.com>
X-SW-Source: 2000-q4/msg00023.html

Is this patch so that you can do `chroot /'?  Why would you want to do that?
Cheers,
Earnie.
--- Kazuhiro Fujieda <fujieda@jaist.ac.jp> wrote:
> ChangeLog:
> Wed Nov 29 18:25:53 2000  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
> 
> 	* cygheap.cc (chgheap_root::operator =): Check root dir properly.
> 
> Index: cygheap.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/cygheap.cc,v
> retrieving revision 1.12
> diff -u -p -r1.12 cygheap.cc
> --- cygheap.cc	2000/11/15 00:13:08	1.12
> +++ cygheap.cc	2000/11/29 09:23:37
> @@ -305,7 +305,7 @@ cygheap_root::operator =(const char *new
>      {
>        root = cstrdup (new_root);
>        rootlen = strlen (root);
> -      if (rootlen > 1 && root[rootlen - 1] == '/')
> +      if (rootlen >= 1 && root[rootlen - 1] == '/')
>  	root[--rootlen] = '\0';
>        if (!rootlen)
>  	{
> 
> ____
>   | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
>   | HOKURIKU  School of Information Science
> o_/ 1990      Japan Advanced Institute of Science and Technology


__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
