From: Alexander Gottwald <Alexander.Gottwald@informatik.tu-chemnitz.de>
To: egcs@cygnus.com
Cc: cygwin-patches@cygwin.com
Subject: RE: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire streamas a  header
Date: Wed, 28 Nov 2001 11:27:00 -0000
Message-ID: <Pine.LNX.4.21.0111282007530.1783-100000@lupus.ago.vpn>
References: <1006914349.637.4.camel@lifelesswks>
X-SW-Source: 2001-q4/msg00280.html
Message-ID: <20011128112700.W1ruzmHYy5MoOzGXMNSccBrjdiUX-GFnxmRvgF8OBQE@z>

On 28 Nov 2001, Robert Collins wrote:

> ===
> NULL
> 
> #define NULL <either 0, 0L, or (void *)0> [0 in C++]
> 
> The macro yields a null pointer constant that is usable as an address
> constant expression.
> ===

I was once told that NULL might not be equal to 0 on all platforms. So 
there may be a platform where NULL equals to - let say -1 -. Any test
(!pointer) is on this platform pure nonsense. (pointer != NULL) would 
be correct. And so am I coding. I don't wan't to see my code crash 
just because of the assumption that the pointer to core[0] is not valid.

This is - afair - defined for C. For C++ I have no clues. But in my 
opinion it would be much better to test explicitly for an invalid pointer 
than implicitly. (pointer != NULL) than (pointer != 0)

bye
    ago
-- 
 Alexander.Gottwald@informatik.tu-chemnitz.de 
 http://www.gotti.org           ICQ: 126018723
 phone: +49 3725 349 80 80	mobile: +49 172 7854017
 4. Chemnitzer Linux-Tag http://www.tu-chemnitz.de/linux/tag/lt4
