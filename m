From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: /dev/clipboard update
Date: Thu, 22 Mar 2001 13:54:00 -0000
Message-id: <20010322165422.A18649@redhat.com>
References: <002c01c0b2be$dbdbcf40$0200a8c0@lifelesswks>
X-SW-Source: 2001-q1/msg00235.html

On Thu, Mar 22, 2001 at 09:57:14PM +1100, Robert Collins wrote:
>here's a patch for /dev/clipboard that
>* allows sequential reads (the existing code only allowed a single
>read() ).
>* allows writes (sequential only.. I haven't thought thru the logic for
>the boundary cases of random writes).
>* allows binary data (ie it's 8 bit clean). A text version is exported
>for windows, to the first \0.

Sorry but the ChangeLog is not right.  It doesn't list all of the functions
that you modified in fhandler_clipboard.cc.

Also, please don't add user32 to the link line in Makefile.in.  Take a look
at autoload.cc and add whatever functions you need there.

cgf
