Return-Path: <cygwin-patches-return-4578-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32582 invoked by alias); 25 Feb 2004 20:05:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32571 invoked from network); 25 Feb 2004 20:05:01 -0000
X-Authentication-Warning: thing1-200.fsi.com: ford owned process doing -bs
Date: Wed, 25 Feb 2004 20:05:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@thing1-200
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: munmap slowness; IsBadReadPtr considered harmful
In-Reply-To: <20040225105505.GV1587@cygbert.vinschen.de>
Message-ID: <Pine.GSO.4.58.0402251335320.24531@thing1-200>
References: <Pine.GSO.4.58.0402201138400.25876@thing1-200>
 <Pine.GSO.4.58.0402231502330.6954@thing1-200> <20040224165708.GS1587@cygbert.vinschen.de>
 <Pine.GSO.4.58.0402241658050.14041@thing1-200> <20040225105505.GV1587@cygbert.vinschen.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-684387517-1077738646=:24531"
Content-ID: <Pine.GSO.4.58.0402251351050.24531@thing1-200>
X-SW-Source: 2004-q1/txt/msg00068.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-684387517-1077738646=:24531
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.58.0402251351051.24531@thing1-200>
Content-length: 2696

On Wed, 25 Feb 2004, Corinna Vinschen wrote:
> On Feb 24 17:23, Brian Ford wrote:
> > I guess it all depends on your interpretation of the following lines from:
> >
> > http://www.opengroup.org/onlinepubs/007904975/functions/munmap.html
> >
> > ERRORS:
> >
> > [EINVAL]
> >     Addresses in the range [addr,addr+len) are outside the valid range for
> > the address space of a process.
> >
> > What does that *really* mean, especially in terms of
> > COMMIT/RESERVE/FREE and NOACCESS/GUARD?
> >
> That's true.  On Linux, calling munmap on an already munmap'd memory
> is no problem.  Even more interesting, regardless of the state of the
> page allocation, all addresses valid as virtual memory addresses of
> a process do not fail with munmap.
>
> Since NOACCESS is used to mark munmapped pages in Cygwin's mmap
> implementation, this would mean that munmapping an already munmapped
> page would fail on Cygwin when checking for NOACCESS.  Testing reveals
> that this is already the case right now so using IsBadReadPtr in this
> context is actually wrong.  Oh boy.
>
> I tested your first implementation of that function.  To say it in
> simple words, the function only checks if the addresses are in the
> valid virtual address space of the process.  I used it in the munmap
> context and munmap behaves like on Linux now, only failing for addresses
> outside the valid virtual address space of the process.
>
> What I did is this:  I stripped the function to the bare minimum and
> put it into miscfuncs.cc, called "check_invalid_virtual_addr".  Also
> munmap now calls check_invalid_virtual_addr instead of IsBadReadPtr
>
Great, thanks!  That should give a *big* performance boost to any app
that mmaps a large, or network based file but doesn't touch all of it.

One minor nit, though.  There is no problem with the current usage in
munmap because the address is garanteed to be page aligned.  However,
since this is supposed to be a generic function, that assumption could
cause you to not test the last page in a range on the rare occassion
where its attributes are different since:

lpAddress: This value is rounded down to the next page boundary.

2004-02-25  Brian Ford  <ford@vss.fsi.com>

        * miscfuncs.cc (check_invalid_virtual_addr): Assure the last page
	in the range is always tested.  Add appropriate const.

	* mmap.cc (mmap_record::aloc_fh): Remove unused static path_conf
	object.

I'm not as sure about the mmap.cc change, but it looks unused to me and
I've been running that way for a week or so without any problems.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
---559023410-684387517-1077738646=:24531
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="munmap.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.58.0402251404530.24531@thing1-200>
Content-Description: 
Content-Disposition: attachment; filename="munmap.patch"
Content-length: 1798

SW5kZXg6IG1pc2NmdW5jcy5jYw0KPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
UkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL21pc2NmdW5j
cy5jYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMjkNCmRpZmYgLXUgLXAg
LXIxLjI5IG1pc2NmdW5jcy5jYw0KLS0tIG1pc2NmdW5jcy5jYwkyNSBGZWIg
MjAwNCAxMDo1NDozMSAtMDAwMAkxLjI5DQorKysgbWlzY2Z1bmNzLmNjCTI1
IEZlYiAyMDA0IDE5OjIwOjMwIC0wMDAwDQpAQCAtMjE4LDkgKzIxOCwxMCBA
QCBpbnQgX19zdGRjYWxsDQogY2hlY2tfaW52YWxpZF92aXJ0dWFsX2FkZHIg
KGNvbnN0IHZvaWQgKnMsIHVuc2lnbmVkIHN6KQ0KIHsNCiAgIE1FTU9SWV9C
QVNJQ19JTkZPUk1BVElPTiBtYnVmOw0KLSAgdm9pZCAqZW5kOw0KKyAgY29u
c3Qgdm9pZCAqZW5kOw0KIA0KLSAgZm9yIChlbmQgPSAoY2hhciAqKSBzICsg
c3o7IHMgPCBlbmQ7IHMgPSAoY2hhciAqKSBzICsgbWJ1Zi5SZWdpb25TaXpl
KQ0KKyAgZm9yIChlbmQgPSAoY2hhciAqKSBzICsgc3o7IHMgPCBlbmQ7DQor
ICAgICAgIHMgPSAoY2hhciAqKSBtYnVmLkJhc2VBZGRyZXNzICsgbWJ1Zi5S
ZWdpb25TaXplKQ0KICAgICBpZiAoIVZpcnR1YWxRdWVyeSAocywgJm1idWYs
IHNpemVvZiBtYnVmKSkNCiAgICAgICByZXR1cm4gRUlOVkFMOw0KICAgcmV0
dXJuIDA7DQpJbmRleDogbW1hcC5jYw0KPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL21tYXAu
Y2Msdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjk0DQpkaWZmIC11IC1wIC1y
MS45NCBtbWFwLmNjDQotLS0gbW1hcC5jYwkyNSBGZWIgMjAwNCAxMDo1NDoz
MSAtMDAwMAkxLjk0DQorKysgbW1hcC5jYwkyNSBGZWIgMjAwNCAxOToyMDoz
MCAtMDAwMA0KQEAgLTI5NSw3ICsyOTUsNiBAQCBtbWFwX3JlY29yZDo6YWxs
b2NfZmggKCkNCiAgICAgICByZXR1cm4gJmZoX3BhZ2luZ19maWxlOw0KICAg
ICB9DQogDQotICBzdGF0aWMgcGF0aF9jb252IHBjOyAvLyBzaG91bGQgYmUg
dGhyZWFkIHNhZmUgLSBDR0YNCiAgIC8qIFRoZSBmaWxlIGRlc2NyaXB0b3Ig
Y291bGQgaGF2ZSBiZWVuIGNsb3NlZCBvciwgZXZlbg0KICAgICAgd29yc2Us
IGNvdWxkIGhhdmUgYmVlbiByZXVzZWQgZm9yIGFub3RoZXIgZmlsZSBiZWZv
cmUNCiAgICAgIHRoZSBjYWxsIHRvIGZvcmsoKS4gVGhpcyByZXF1aXJlcyBj
cmVhdGluZyBhIGZoYW5kbGVyDQo=

---559023410-684387517-1077738646=:24531--
