From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: raw-win32-keyboard-mode patch
Date: Mon, 19 Feb 2001 18:49:00 -0000
Message-id: <20010219214951.A23483@redhat.com>
References: <16286062992.20010216183758@logos-m.ru>
X-SW-Source: 2001-q1/msg00087.html

On Fri, Feb 16, 2001 at 06:37:58PM +0300, Egor Duda wrote:
>2001-02-16  Egor Duda  <deo@logos-m.ru>
>  
>        * fhandler_console.cc (use_mouse): Remove. Make mouse handling
>        per-console.
>        * fhandler.h (class fhandler_console): Move use_mouse here.
>        * fhandler.cc (fhandler_console::set_raw_win32_keyboard_mode): New
>        function.
>        * fhandler_console.cc (fhandler_console::fhandler_console): Turn
>        mouse handling and raw-win32 keyboard mode off by default.
>        * fhandler_console.cc (fhandler_console::read): If in raw-win32
>        keyboard mode, encode win32 keyboard events in \033{x;y;z;t;u;wK
>        sequences.
>        * fhandler_console.cc (fhandler_console::char_command): Treat
>        \033[2000h as a command to enable raw-win32 keyboard mode and
>        \033[2000l as a command to disable it.

Oops.  Sorry for the delay.

Please check this in.  It looks interesting.

cgf
