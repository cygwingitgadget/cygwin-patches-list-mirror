Return-Path: <cygwin-patches-return-4077-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19656 invoked by alias); 13 Aug 2003 14:19:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19646 invoked from network); 13 Aug 2003 14:19:09 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Wed, 13 Aug 2003 14:19:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [PATCH] Consider extensions for special names in managed mode
In-Reply-To: <20030813083512.GG13155@linux_rln.harvest>
Message-ID: <Pine.GSO.4.44.0308131014360.8046-200000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-33463914-1060784348=:8046"
X-SW-Source: 2003-q3/txt/msg00093.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-33463914-1060784348=:8046
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1131

On Wed, 13 Aug 2003, Ronald Landheer-Cieslak wrote:

> On Tue, Aug 12, 2003 at 01:39:18PM -0400, Igor Pechtchanski wrote:
> > Ronald,
> >
> > I think there might be a bug in the way managed mode figures special
> > filenames.  Try simply "touch aux" instead of "touch aux.x".  If that
> > works, it'll confirm my reading the code.  I'll submit a patch later today
> > if noone beats me to it.
> >       Igor
>
> `touch aux' works like a charm :|
>
> rlc

Yeah.  I promised a patch, didn't I?  *Sigh*.
	Igor
==============================================================================
2003-08-13  Igor Pechtchanski  <pechtcha@cs.nyu.edu>

	* path.cc (special_name): Add checks for some specials
	followed by a "." and a FIXME comment.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton

---559023410-33463914-1060784348=:8046
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="path-special-names.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0308131019080.8046@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename="path-special-names.patch"
Content-length: 1216

SW5kZXg6IHdpbnN1cC9jeWd3aW4vcGF0aC5jYw0KPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PQ0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2lu
L3BhdGguY2Msdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjI2Mg0KZGlmZiAt
dSAtcCAtcjEuMjYyIHBhdGguY2MNCi0tLSB3aW5zdXAvY3lnd2luL3BhdGgu
Y2MJNSBBdWcgMjAwMyAwNDo0OTo0NCAtMDAwMAkxLjI2Mg0KKysrIHdpbnN1
cC9jeWd3aW4vcGF0aC5jYwkxMyBBdWcgMjAwMyAxNDoxNjo1NyAtMDAwMA0K
QEAgLTE0MTgsMTAgKzE0MTgsMTUgQEAgc3BlY2lhbF9uYW1lIChjb25zdCBj
aGFyICpzLCBpbnQgaW5jID0gMQ0KICAgaWYgKHN0cnBicmsgKHMsIHNwZWNp
YWxfY2hhcnMpKQ0KICAgICByZXR1cm4gIXN0cm5jYXNlbWF0Y2ggKHMsICIl
MmYiLCAzKTsNCiANCisgIC8vIEZJWE1FOiBhZGQgY29tMCBhbmQge2NvbSxs
cHR9Ti4qDQogICBpZiAoc3RyY2FzZW1hdGNoIChzLCAibnVsIikNCisgICAg
ICB8fCBzdHJuY2FzZW1hdGNoIChzLCAibnVsLiIsIDQpDQogICAgICAgfHwg
c3RyY2FzZW1hdGNoIChzLCAiYXV4IikNCisgICAgICB8fCBzdHJuY2FzZW1h
dGNoIChzLCAiYXV4LiIsIDQpDQogICAgICAgfHwgc3RyY2FzZW1hdGNoIChz
LCAicHJuIikNCisgICAgICB8fCBzdHJuY2FzZW1hdGNoIChzLCAicHJuLiIs
IDQpDQogICAgICAgfHwgc3RyY2FzZW1hdGNoIChzLCAiY29uIikNCisgICAg
ICB8fCBzdHJuY2FzZW1hdGNoIChzLCAiY29uLiIsIDQpDQogICAgICAgfHwg
c3RyY2FzZW1hdGNoIChzLCAiY29uaW4kIikNCiAgICAgICB8fCBzdHJjYXNl
bWF0Y2ggKHMsICJjb25vdXQkIikpDQogICAgIHJldHVybiAtMTsNCg==

---559023410-33463914-1060784348=:8046--
