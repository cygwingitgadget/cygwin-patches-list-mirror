From: Pavel Tsekov <ptsekov@syntrex.com>
To: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>, cygwin-patches@sourceware.cygnus.com
Subject: Re: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream as a header
Date: Tue, 27 Nov 2001 01:16:00 -0000
Message-ID: <3C0359E8.818982A1@syntrex.com>
References: <NCBBIHCHBLCMLBLOBONKKEJHCHAA.g.r.vansickle@worldnet.att.net> <3C035977.BF151D0A@syntrex.com>
X-SW-Source: 2001-q4/msg00249.html
Message-ID: <20011127011600.LnSDAcYZl1c3Ms3rg_a_qFhobVr8nYJmjCXrz9NsIHo@z>

Pavel Tsekov wrote:
> 
> "Gary R. Van Sickle" wrote:
> >
> 

Argh... Please, ignore the lines below :(

> And add a break here:
> 
>         if (_strnicmp (l, "Content-Length:", 15) == 0)
>  +        {
>  +          sscanf (l, "%*s %d", &file_size);
>  +          break;
>  +        }
>
