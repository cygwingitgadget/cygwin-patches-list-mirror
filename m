From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Pavel Tsekov" <ptsekov@syntrex.com>, <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] setup.exe: io_stream-ized SimpleSocket class
Date: Fri, 23 Nov 2001 11:27:00 -0000
Message-ID: <08ae01c17454$ef204970$0200a8c0@lifelesswks>
References: <3BFE8631.AFC9AEF6@syntrex.com>
X-SW-Source: 2001-q4/msg00244.html
Message-ID: <20011123112700.KRVG1V5o3P0X6RkbnZAeFzELTC3veZwW3S2jrISSUsc@z>

----- Original Message -----
From: "Pavel Tsekov" <ptsekov@syntrex.com>
To: <cygwin-patches@cygwin.com>
Sent: Saturday, November 24, 2001 4:24 AM
Subject: [PATCH] setup.exe: io_stream-ized SimpleSocket class


> Hello, there!
>
> This is a simple patch which is a step towards
> merging the NetIO hierarchy with the new
> io_stream hierarchy. The supplied patch implemnts
> all the abstract methods of io_stream except
> tell() and seek(), and also implements its own
> gets() method.
>
> There is no Changelog since I post this patch
> for comments/critics/flames/etc. I just want to
> know if this change is needed and if this is the
> right way to do it.

This change is needed. io_stream needs http and ftp support before
cacheless-installs can happen.

A few points ...
1) io_streams _never_ interact with the user - all feedback is via
return codes and error values. The gui code then gets to perform error
handling.
Impact on your code: the msg() routines may need to be turned into a
error return val. Also, the proxy password request screen needs to be
taken out of the netio classes, and put into the gui code base. I had
ben thinking about how best to pass that through, and proxy auth errors
back, and I think EPERM may be the easiest way to indicate that proxy
auth may be needed. Also something is needed to pass through a ftp url
via http proxy request .. something like
http://proxyusername:proxypassword@proxyaddress:port/ftp://ftpuser:ftppa
ss@ftpsite.com/bar is a minor variation from the HTTP RFC and should be
easily parseable. The http code will need to understand what urls' if
can proxy  - as you'd expect :].
2) No global variables. You should be able to build your updated classes
without state.h.
3) Use static data members sparingly. Only use them if they really add
value to the class. (i.e. my recent package_db class uses static data
members because it really is global - the package db represents all
installed and available packages from all mirrors.

Thank you for getting started on this, I hope to see more soon :]

Rob
