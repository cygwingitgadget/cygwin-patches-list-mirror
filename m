Return-Path: <cygwin-patches-return-4420-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23208 invoked by alias); 18 Nov 2003 00:34:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23192 invoked from network); 18 Nov 2003 00:34:05 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Tue, 18 Nov 2003 00:34:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: Corinna Vinschen <cygwin-patches@cygwin.com>
cc: newlib@sources.redhat.com
Subject: Re: (fhandler_base::lseek): Include high order bits in return.
In-Reply-To: <Pine.GSO.4.56.0311171628330.922@eos>
Message-ID: <Pine.GSO.4.56.0311171831520.922@eos>
References: <Pine.GSO.4.56.0311171454590.922@eos> <Pine.GSO.4.56.0311171538130.922@eos>
 <20031117221509.GP18706@cygbert.vinschen.de> <Pine.GSO.4.56.0311171628330.922@eos>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-456208845-1069115644=:922"
X-SW-Source: 2003-q4/txt/msg00139.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-456208845-1069115644=:922
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1389

On Mon, 17 Nov 2003, Brian Ford wrote:

> On Mon, 17 Nov 2003, Corinna Vinschen wrote:
>
> > On Mon, Nov 17, 2003 at 03:40:46PM -0600, Brian Ford wrote:
> > > On Mon, 17 Nov 2003, Brian Ford wrote:
> > >
> > > > This bug fix got our app past its first problem with > 2 Gig files, but
> > > > then it tripped over ftello.  I'm still trying to figure that one out.
> > > >
> > > > It looks like it got a 32 bit sign extended value somewhere.  Any help would
> > > > be appreciated.  Thanks.
> > > >
> > > Well, that somewhere is ftello64.c line 111.  fp->_offset has a 32 bit
> > > sign extended value.  Anybody know how it got there?
> >
> > That can't be it.  fp is of type FILE which is actually mapped to
> > __sFILE64 in 64 bit case.  See newlib/libc/include/sys/reent.h.
> > _offset is of type _off64_t there.
> >
> I think you misunderstood.  fp->_offset is a 64 bit type, but at the
> ftello call in question, it contains a value that must have come from a 32
> bit sign extension.  That's why I asked for help, because I have to figure
> out what/who put it there.
>
I have attached a test case that shows the problem.  It is on line 58 of
lseekr.c.

I can't seem to find the actual problem tonight and I'm tired so I'm going
home.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
---559023410-456208845-1069115644=:922
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="x.c"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.56.0311171834040.922@eos>
Content-Description: 
Content-Disposition: attachment; filename="x.c"
Content-length: 757

I2luY2x1ZGUgPHN5cy90eXBlcy5oPg0KI2luY2x1ZGUgPHN5cy9zdGF0Lmg+
DQojaW5jbHVkZSA8ZmNudGwuaD4NCiNpbmNsdWRlIDxzdGRsaWIuaD4NCiNp
bmNsdWRlIDxzdGRpby5oPg0KI2luY2x1ZGUgPHVuaXN0ZC5oPg0KDQppbnQN
Cm1haW4odm9pZCkNCnsNCiAgICBGSUxFICpmcDsNCiAgICBvZmZfdCBwLCBx
Ow0KICAgIGNoYXIgYzsNCg0KICAgIGxvbmcgbG9uZyBzaXplID0gNTAwMDAw
MDAwMExMOw0KICAgIGludCBmZCA9IG9wZW4oImp1bmsiLCBPX1JEV1J8T19D
UkVBVCwgU19JUkVBRHxTX0lXUklURSk7DQogICAgbHNlZWsoZmQsIHNpemUs
IFNFRUtfU0VUKTsNCiAgICB3cml0ZShmZCwgIngiLCAxKTsNCiAgICBjbG9z
ZShmZCk7DQoNCiAgICBmcCA9IGZvcGVuKCJqdW5rIiwgInIiKTsNCg0KICAg
IHAgPSBmc2Vla28oZnAsIHNpemUsIFNFRUtfU0VUKTsNCiAgICBmcHJpbnRm
KHN0ZGVyciwgIiVjICIsIGZnZXRjKGZwKSk7DQogICAgcSA9IGZ0ZWxsbyhm
cCk7DQoNCiAgICBmcHJpbnRmKHN0ZGVyciwiJWxseCAlbGx4ICVsbHhcbiIs
c2l6ZSxwLCBxKTsNCn0NCg==

---559023410-456208845-1069115644=:922--
