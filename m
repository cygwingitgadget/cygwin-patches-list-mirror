From: DJ Delorie <dj@delorie.com>
To: cygwin-patches@cygwin.com
Subject: Re: cinstall/Makefile.in and configure.
Date: Wed, 07 Feb 2001 17:54:00 -0000
Message-id: <200102080154.UAA03265@envy.delorie.com>
References: <3A81E0C9.65A57BA9@yahoo.com> <200102080000.TAA02270@envy.delorie.com> <3A81E3BC.BF96D3CB@yahoo.com> <200102080056.TAA02750@envy.delorie.com> <3A81F1C3.70103D7A@yahoo.com>
X-SW-Source: 2001-q1/msg00064.html

> The patch is reverse of what you state.  w32api will only be found if
> -mno-cygwin or -mwin32 are specified.  Are these switches available with
> windres?

windres just runs "gcc -E -xc -".  You'd have to specify a whole new
command string to add an option to gcc.
