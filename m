From: Egor Duda <deo@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: oem/ansi codepage support
Date: Mon, 04 Dec 2000 08:18:00 -0000
Message-id: <71165146488.20001204191621@logos-m.ru>
References: <129109438394.20001129174705@logos-m.ru> <20001202000129.C4544@redhat.com>
X-SW-Source: 2000-q4/msg00038.html

Hi!

Saturday, 02 December, 2000 Christopher Faylor cgf@redhat.com wrote:

CF> The patch looks good but isn't there an LC_something environment
CF> variable that is equivalent to this on Linux.

CF> If so, I would like to use that (even though I suggested using the Cygwin
CF> env variable).

i agree  with Kazuhiro here. My patch is dealing with "kernel" part of
cygwin.  On  Linux,  filesystem  translations  are controlled by mount
options   and   console is controlled via driver's ioctl. so, i think,
CYGWIN variable is more adequate than LC_* here.

I'm not sure about globbing code in winsup/cygwin/miscfuncs.cc, though.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

