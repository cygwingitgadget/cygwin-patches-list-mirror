From: Christopher Faylor <cgf@redhat.com>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: oem/ansi codepage support
Date: Sat, 09 Dec 2000 17:24:00 -0000
Message-id: <20001209194535.A9904@redhat.com>
References: <129109438394.20001129174705@logos-m.ru> <20001202000129.C4544@redhat.com> <71165146488.20001204191621@logos-m.ru>
X-SW-Source: 2000-q4/msg00041.html

On Mon, Dec 04, 2000 at 07:16:21PM +0300, Egor Duda wrote:
>Hi!
>
>Saturday, 02 December, 2000 Christopher Faylor cgf@redhat.com wrote:
>
>CF> The patch looks good but isn't there an LC_something environment
>CF> variable that is equivalent to this on Linux.
>
>CF> If so, I would like to use that (even though I suggested using the Cygwin
>CF> env variable).
>
>i agree  with Kazuhiro here. My patch is dealing with "kernel" part of
>cygwin.  On  Linux,  filesystem  translations  are controlled by mount
>options   and   console is controlled via driver's ioctl. so, i think,
>CYGWIN variable is more adequate than LC_* here.
>
>I'm not sure about globbing code in winsup/cygwin/miscfuncs.cc, though.

I've applied this patch.  Sorry for the delay.

cgf
