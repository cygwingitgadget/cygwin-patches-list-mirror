Return-Path: <cygwin-patches-return-1553-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 21995 invoked by alias); 28 Nov 2001 19:27:37 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 21975 invoked from network); 28 Nov 2001 19:27:36 -0000
Date: Mon, 29 Oct 2001 13:10:00 -0000
From: Alexander Gottwald <Alexander.Gottwald@informatik.tu-chemnitz.de>
Cc: cygwin-patches@cygwin.com
Subject: RE: [PATCH] setup.exe: Stop NetIO_HTTP from treating entire stream
 as a  header
In-Reply-To: <1006914349.637.4.camel@lifelesswks>
Message-ID: <Pine.LNX.4.21.0111282007530.1783-100000@lupus.ago.vpn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2001-q4/txt/msg00085.txt.bz2

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
