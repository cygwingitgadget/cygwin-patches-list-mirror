From: egor duda <deo@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: memory leak in cygheap
Date: Thu, 27 Sep 2001 11:17:00 -0000
Message-id: <15899509507.20010927221556@logos-m.ru>
References: <15294469449.20010927205156@logos-m.ru> <20010927140039.A32577@redhat.com>
X-SW-Source: 2001-q3/msg00218.html

Hi!

Thursday, 27 September, 2001 Christopher Faylor cgf@redhat.com wrote:

>>do we need this "no free names" logic at all? the only suspicious
>>place is fhandler_disk_file::open () where we were storing pointer to
>>real_path's win32_path, so if it was changing later we were staying in
>>sync with those changes. but i can't see why it may change after open
>>is called, so making duplicate looks safe for me. Comments?

CF> We've recently changed build_fhandler so that it probably isn't necessary
CF> to use the no_free_names anymore.

CF> I don't have a lot of time to investigate right now, but it's possible that
CF> we can now get rid of this entirely.

CF> So, I think your patch is probably overkill.

? why overkill? i've just moved two identical pieces of code into
separate routine and removed no_free_names checks. I was thinking it's
rather "underkill" because no_free_names bit in flags are left intact.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
