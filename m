Return-Path: <cygwin-patches-return-4083-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10964 invoked by alias); 13 Aug 2003 18:33:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10938 invoked from network); 13 Aug 2003 18:33:57 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Wed, 13 Aug 2003 18:33:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Checking integrity of installed packages in cygcheck
In-Reply-To: <Pine.GSO.4.44.0308101528150.7386-200000@slinky.cs.nyu.edu>
Message-ID: <Pine.GSO.4.44.0308131432260.192-200000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1932422408-1060544066=:7386"
Content-ID: <Pine.GSO.4.44.0308131432261.192@slinky.cs.nyu.edu>
X-SW-Source: 2003-q3/txt/msg00099.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1932422408-1060544066=:7386
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.44.0308131432262.192@slinky.cs.nyu.edu>
Content-length: 2136

Ping!  This is pretty urgent, as the code that's currently in CVS won't
work and has a buffer overflow.
	Igor

On Sun, 10 Aug 2003, Igor Pechtchanski wrote:

> On Sat, 9 Aug 2003, Christopher Faylor wrote:
>
> > On Sat, Aug 09, 2003 at 03:52:55PM -0400, Igor Pechtchanski wrote:
> > >On Sat, 9 Aug 2003, Christopher Faylor wrote:
> > >>On checking this patch a little further, I see that it gives a
> > >>misleading "OK" when the package file is missing.  Could you detect
> > >>that case?
> > >
> > >Yes.  The attached patch (against the initial one applied) does just
> > >that.
> >
> > I've checked this in, too, with some changes.  The version of this file
> > in CVS had my fix to convert slashes to backslashes so your patch didn't
> > cleanly apply.  I also allocated a static buffer and only calculated the
> > DOS pathname for gzip.exe once.  Finally, I changed all of the
> > formatting to GNU-style.
>
> Ugh, yes, I forgot to do a CVS update...  Sorry about that.  As for the
> GNU-style formatting, that space between the function name and the paren
> always trips me up...
>
> Anyway, there were some bugs in the code that was checked in -- the
> attached patch fixes them.
>
> > Thanks for this increased functionality.  I used this to update my own
> > installation.  It looks like I had somehow damaged my installation a
> > while ago.  Some files were missing, some package lists were missing.
> > Who knew?
> >
> > cgf
>
> Glad it was useful.
> 	Igor
> ==============================================================================
> ChangeLog:
> 2003-08-10  Igor Pechtchanski  <pechtcha@cs.nyu.edu>
>
> 	* dump_setup.cc (check_package_files): Fix extra '/' in filename.
> 	Resize command buffer.  Fix buffer overflow bug.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton

---559023410-1932422408-1060544066=:7386
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="cygcheck-verify-packages-fix.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0308101534260.7386@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="cygcheck-verify-packages-fix.patch"
Content-length: 1989

SW5kZXg6IHdpbnN1cC91dGlscy9kdW1wX3NldHVwLmNjDQo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC91
dGlscy9kdW1wX3NldHVwLmNjLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS44
DQpkaWZmIC11IC1wIC1yMS44IGR1bXBfc2V0dXAuY2MNCi0tLSB3aW5zdXAv
dXRpbHMvZHVtcF9zZXR1cC5jYwkxMCBBdWcgMjAwMyAwMTowNzowNCAtMDAw
MAkxLjgNCisrKyB3aW5zdXAvdXRpbHMvZHVtcF9zZXR1cC5jYwkxMCBBdWcg
MjAwMyAxOToyNDozOCAtMDAwMA0KQEAgLTIzNyw3ICsyMzcsNyBAQCBmaWxl
X2V4aXN0cyAoaW50IHZlcmJvc2UsIGNoYXIgKmZpbGVuYW1lDQogc3RhdGlj
IGJvb2wNCiBjaGVja19wYWNrYWdlX2ZpbGVzIChpbnQgdmVyYm9zZSwgY2hh
ciAqcGFja2FnZSkNCiB7DQotICBjaGFyIGZpbGVsaXN0W01BWF9QQVRIICsg
MV0gPSAiL2V0Yy9zZXR1cC8iOw0KKyAgY2hhciBmaWxlbGlzdFtNQVhfUEFU
SCArIDFdID0gImV0Yy9zZXR1cC8iOw0KICAgc3RyY2F0IChzdHJjYXQgKGZp
bGVsaXN0LCBwYWNrYWdlKSwgIi5sc3QuZ3oiKTsNCiAgIGlmICghZmlsZV9l
eGlzdHMgKGZhbHNlLCBmaWxlbGlzdCwgTlVMTCwgTlVMTCkpDQogICAgIHsN
CkBAIC0yNTMsOCArMjUzLDggQEAgY2hlY2tfcGFja2FnZV9maWxlcyAoaW50
IHZlcmJvc2UsIGNoYXIgKg0KICAgICAgIHpjYXQgPSBjeWdwYXRoICgiL2Jp
bi9nemlwLmV4ZSIsIE5VTEwpOw0KICAgICAgIHdoaWxlIChjaGFyICpwID0g
c3RyY2hyICh6Y2F0LCAnLycpKQ0KIAkqcCA9ICdcXCc7DQotICAgICAgemNh
dCA9IChjaGFyICopIHJlYWxsb2MgKHpjYXQsIHN0cmxlbiAoemNhdCkgKyBz
aXplb2YgKCIgLWRjICIpICsgNDA5Nik7DQotICAgICAgemNhdF9lbmQgPSBz
dHJjaHIgKHN0cmNhdCAoemNhdCwgIiAtZGMgIiksICdcMCcpOw0KKyAgICAg
IHpjYXQgPSAoY2hhciAqKSByZWFsbG9jICh6Y2F0LCBzdHJsZW4gKHpjYXQp
ICsgc2l6ZW9mICgiIC1kYyAvIikgKyBNQVhfUEFUSCk7DQorICAgICAgemNh
dF9lbmQgPSBzdHJjaHIgKHN0cmNhdCAoemNhdCwgIiAtZGMgLyIpLCAnXDAn
KTsNCiAgICAgfQ0KIA0KICAgc3RyY3B5ICh6Y2F0X2VuZCwgZmlsZWxpc3Qp
Ow0KQEAgLTI2Miw3ICsyNjIsNyBAQCBjaGVja19wYWNrYWdlX2ZpbGVzIChp
bnQgdmVyYm9zZSwgY2hhciAqDQogDQogICBib29sIHJlc3VsdCA9IHRydWU7
DQogICBjaGFyIGJ1ZltNQVhfUEFUSCArIDFdOw0KLSAgd2hpbGUgKGZnZXRz
IChidWYsIDQwOTYsIGZwKSkNCisgIHdoaWxlIChmZ2V0cyAoYnVmLCBNQVhf
UEFUSCwgZnApKQ0KICAgICB7DQogICAgICAgY2hhciAqZmlsZW5hbWUgPSBz
dHJ0b2soYnVmLCAiXG4iKTsNCiAgICAgICBpZiAoZmlsZW5hbWVbc3RybGVu
IChmaWxlbmFtZSkgLSAxXSA9PSAnLycpDQo=

---559023410-1932422408-1060544066=:7386--
