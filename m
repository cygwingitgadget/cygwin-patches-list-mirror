From: "Robert Collins" <robert.collins@itdomain.com.au>
To: "Pavel Tsekov" <ptsekov@syntrex.com>, <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] setup.exe: io_stream-ized SimpleSocket class
Date: Mon, 26 Nov 2001 06:13:00 -0000
Message-ID: <00eb01c17684$78718230$0200a8c0@lifelesswks>
References: <3BFE8631.AFC9AEF6@syntrex.com> <08ae01c17454$ef204970$0200a8c0@lifelesswks> <3C02323E.ACFEECF0@syntrex.com>
X-SW-Source: 2001-q4/msg00246.html
Message-ID: <20011126061300.RairwymHaLHjOAk5OofABcejhSqU9CVHWE88JsFH1qg@z>

RFC 2616 and 2617 are the current HTTP specs.

However, the format of a URI is defined elsewhere :|. Uhmm, see the
begining of rfc 2616 for a pointer to the correct URI defining RFC>

Rob
===
----- Original Message -----
From: "Pavel Tsekov" <ptsekov@syntrex.com>
To: <cygwin-patches@cygwin.com>
Sent: Monday, November 26, 2001 11:14 PM
Subject: Re: [PATCH] setup.exe: io_stream-ized SimpleSocket class


> Robert Collins wrote:
> >
> >
> > A few points ...
>
> [ snip ]
>
> > auth may be needed. Also something is needed to pass through a ftp
url
> > via http proxy request .. something like
> >
http://proxyusername:proxypassword@proxyaddress:port/ftp://ftpuser:ftppa
> > ss@ftpsite.com/bar is a minor variation from the HTTP RFC and should
be
> > easily parseable. The http code will need to understand what urls'
if
> > can proxy  - as you'd expect :].
>
> Where do you read this from ? rfc2068 ? Can you point me to the right
> docu.
>
