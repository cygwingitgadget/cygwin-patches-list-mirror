From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: memory leak in cygheap
Date: Thu, 27 Sep 2001 10:59:00 -0000
Message-id: <20010927140039.A32577@redhat.com>
References: <15294469449.20010927205156@logos-m.ru>
X-SW-Source: 2001-q3/msg00214.html

On Thu, Sep 27, 2001 at 08:51:56PM +0400, egor duda wrote:
>Hi!
>
>  this simple program:
>
>#include <sys/types.h>
>#include <dirent.h>
>
>int main ()
>{
>  DIR* x = 0;
>  for (;;)
>    {
>      x = opendir ("/");
>      closedir (x);
>    }
>  return 0;
>}
>
>leaks memory and eventually dies with "can't allocate cygwin heap"
>error message.
>
>attached patch fix this.
>do we need this "no free names" logic at all? the only suspicious
>place is fhandler_disk_file::open () where we were storing pointer to
>real_path's win32_path, so if it was changing later we were staying in
>sync with those changes. but i can't see why it may change after open
>is called, so making duplicate looks safe for me. Comments?

We've recently changed build_fhandler so that it probably isn't necessary
to use the no_free_names anymore.

I don't have a lot of time to investigate right now, but it's possible that
we can now get rid of this entirely.

So, I think your patch is probably overkill.  Thanks for bringing it to my
attention, though.  I was wondering if we had this problem and you verified
that we did.

cgf
