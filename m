Return-Path: <cygwin-patches-return-4316-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17588 invoked by alias); 24 Oct 2003 14:50:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17575 invoked from network); 24 Oct 2003 14:50:40 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Fri, 24 Oct 2003 14:50:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@cygwin.com
Subject: Re: fhandler_base::ioctl (FIONBIO)
In-Reply-To: <20031024124302.GD1653@cygbert.vinschen.de>
Message-ID: <Pine.GSO.4.56.0310240944580.823@eos>
References: <Pine.GSO.4.56.0310231800010.823@eos> <20031024124302.GD1653@cygbert.vinschen.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-632592458-1067007038=:823"
X-SW-Source: 2003-q4/txt/msg00035.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-632592458-1067007038=:823
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1375

On Fri, 24 Oct 2003, Corinna Vinschen wrote:

> On Thu, Oct 23, 2003 at 06:06:09PM -0500, Brian Ford wrote:
> > Any reason not to support this?  It seams to me that this patch just
> > parallels what is already in fhandler_base::fcntl (F_SETFL) for
> > O_NONBLOCK.
>
> Yes, I think you're right.  However, I'd like to ask you to rearrange
> your patch a bit.  Most (all?) other ioctl methods are using a switch
> statement rather than a if/else clause.  To allow later easier extension,
> I think using a switch here would be better as well, even though there's
> only one case so far.
>
Ok.  Revised as suggested and attached.  Same ChangeLog entry.

BTW, I noticed that, but I decided to just follow what was there already.
It looked like someone started to do this and then just forgot.  Also,
comming from a realtime background, I can't/don't always rely on the
compiler to just "do the right thing", even for simple optimizations like
this; been burned too many times with new compiler releases.  Just FYI.

> > I was trying to fix this issue:
> >
> > http://www.cygwin.com/ml/cygwin/2003-10/msg01159.html
> >
> > 2003-10-23  Brian Ford  <ford@vss.fsi.com>
> >
> > 	* fhandler.cc (fhandler_base::ioctl): Handle FIONBIO.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
---559023410-632592458-1067007038=:823
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fhandler.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.56.0310240950380.823@eos>
Content-Description: 
Content-Disposition: attachment; filename="fhandler.patch"
Content-length: 1204

SW5kZXg6IGZoYW5kbGVyLmNjDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpS
Q1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIu
Y2Msdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjE2MA0KZGlmZiAtdSAtcCAt
cjEuMTYwIGZoYW5kbGVyLmNjDQotLS0gZmhhbmRsZXIuY2MJMjQgT2N0IDIw
MDMgMTI6MTE6MjAgLTAwMDAJMS4xNjANCisrKyBmaGFuZGxlci5jYwkyNCBP
Y3QgMjAwMyAxNDo0MTo1OCAtMDAwMA0KQEAgLTkwOSwxMyArOTA5LDIyIEBA
IGZoYW5kbGVyX2Jhc2U6OmNsb3NlICgpDQogaW50DQogZmhhbmRsZXJfYmFz
ZTo6aW9jdGwgKHVuc2lnbmVkIGludCBjbWQsIHZvaWQgKmJ1ZikNCiB7DQot
ICBpZiAoY21kID09IEZJT05CSU8pDQotICAgIHN5c2NhbGxfcHJpbnRmICgi
aW9jdGwgKEZJT05CSU8sICVwKSIsIGJ1Zik7DQotICBlbHNlDQotICAgIHN5
c2NhbGxfcHJpbnRmICgiaW9jdGwgKCV4LCAlcCkiLCBjbWQsIGJ1Zik7DQor
ICBpbnQgcmVzOw0KIA0KLSAgc2V0X2Vycm5vIChFSU5WQUwpOw0KLSAgcmV0
dXJuIC0xOw0KKyAgc3dpdGNoIChjbWQpDQorICAgIHsNCisgICAgY2FzZSBG
SU9OQklPOg0KKyAgICAgIHNldF9ub25ibG9ja2luZyAoKihpbnQgKikgYnVm
KTsNCisgICAgICByZXMgPSAwOw0KKyAgICAgIGJyZWFrOw0KKyAgICBkZWZh
dWx0Og0KKyAgICAgIHNldF9lcnJubyAoRUlOVkFMKTsNCisgICAgICByZXMg
PSAtMTsNCisgICAgICBicmVhazsNCisgICAgfQ0KKw0KKyAgc3lzY2FsbF9w
cmludGYgKCIlZCA9IGlvY3RsICgleCwgJXApIiwgcmVzLCBjbWQsIGJ1Zik7
DQorICByZXR1cm4gcmVzOw0KIH0NCiANCiBpbnQNCg==

---559023410-632592458-1067007038=:823--
