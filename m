From: Benjamin Riefenstahl <Benjamin.Riefenstahl@epost.de>
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Subject: Console codepage
Date: Sun, 28 Jan 2001 12:43:00 -0000
Message-id: <u7l3fv26h.fsf@mail.epost.de>
X-SW-Source: 2001-q1/msg00038.html

Hi everybody,


The code to support I/O to the console (fhandler_console.cc) currently
assumes that the console uses the default OEM codepage.  The user can
change that with CHCP.COM though, and I for one do that routinely.  It
is amoung other things a very usefull to do when running a shell in
NTEmacs.  Because of this customization, 8-bit character console I/O
in Cygwin has for some time been broken for me.

I corrected this in fhandler_console.cc by replacing functions
OemToChar() and CharToOem() with a combo of MultiByteToWideChar() and
WideCharToMultiByte().

I tested console output on Win2000 with "time od test.data" and it
doesn't look like there is a noticeable difference in efficiency.

I include the result of a "cvs diff" below. 

This is my first submission for Cygwin so if there is anything I can
do to make this easier to process, just tell me. 


so long, benny
