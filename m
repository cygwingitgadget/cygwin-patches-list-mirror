Return-Path: <cygwin-patches-return-3552-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19191 invoked by alias); 12 Feb 2003 14:55:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19180 invoked from network); 12 Feb 2003 14:54:59 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Wed, 12 Feb 2003 14:55:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Using cygpath to ensure path format
Message-ID: <Pine.GSO.4.44.0302120942280.14791-200000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="-559023410-851401618-1045012082=:14791"
Content-ID: <Pine.GSO.4.44.0302120942281.14791@slinky.cs.nyu.edu>
X-SW-Source: 2003-q1/txt/msg00201.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-1045012082=:14791
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.44.0302120942282.14791@slinky.cs.nyu.edu>
Content-length: 1967

Hi,

This patch got sent to <cygwin at cygwin dot com>, but this is a more
proper list for it, so I'm resending it here with a better subject.
	Igor

On Tue, 11 Feb 2003, Max Bowsher wrote:

> Igor Pechtchanski wrote:
> > It makes an assumption that the format is Windows.  Otherwise,
> > there'd be no need to convert to Unix format...
>
> Of course, if you simply wanted to *ensure* that the path was in unix
> format... you're stuck.

Yes.  I tracked the change to the following cvs commit:
<http://cygwin.com/ml/cygwin-cvs/2002-q4/msg00080.html>, particularly the
"(doit): Do various things to make path output work predictably." part.

> >> Is there another utility that can be used to identify the format of a
> >> classpath?  This will be needed to account for the changed behaviour
> >> in modifying scripts.
> >
> > Umm, 'grep'?  In particular, grep for a ";" or a "\" for a
> > windows-format path...
>
> Which is presumably vaguely what cygpath used to do.
>
> Doug: have you considered making a patch to cygpath to make it behave more
> to your liking (conditional on a command line option if need be), and
> submitting that?
>
> Max.

Umm, since I've opened my mouth on the issue, I'll submit the patch...
        Igor
==========================================================================
ChangeLog:
2003-02-11  Igor Pechtchanski <pechtcha@cs.nyu.edu>

	* cygpath.cc (doit): Add code to simply ensure the path is
	in the right format.
	(ensure_flag): New static variable.
	(options,long_options): Add 'e' flag.
	(main): Set ensure_flag.

-- 
                                http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_                pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_            igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'           Igor Pechtchanski
    '---''(_/--'  `-'\_) fL     a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

Oh, boy, virtual memory! Now I'm gonna make myself a really *big* RAMdisk!
  -- /usr/games/fortune

---559023410-851401618-1045012082=:14791
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cygpath-ensure-flag.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0302120954590.14791@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename="cygpath-ensure-flag.patch"
Content-length: 4226

SW5kZXg6IHdpbnN1cC91dGlscy9jeWdwYXRoLmNjDQo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09DQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC91dGls
cy9jeWdwYXRoLmNjLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS4yNQ0KZGlm
ZiAtdSAtcCAtcjEuMjUgY3lncGF0aC5jYw0KLS0tIHdpbnN1cC91dGlscy9j
eWdwYXRoLmNjCTMxIE9jdCAyMDAyIDAyOjQwOjI2IC0wMDAwCTEuMjUNCisr
KyB3aW5zdXAvdXRpbHMvY3lncGF0aC5jYwkxMiBGZWIgMjAwMyAwMTowMDox
NiAtMDAwMA0KQEAgLTI5LDYgKzI5LDcgQEAgc3RhdGljIGludCBwYXRoX2Zs
YWcsIHVuaXhfZmxhZywgd2luZG93cw0KIHN0YXRpYyBpbnQgc2hvcnRuYW1l
X2ZsYWcsIGxvbmduYW1lX2ZsYWc7DQogc3RhdGljIGludCBpZ25vcmVfZmxh
ZywgYWxsdXNlcnNfZmxhZywgb3V0cHV0X2ZsYWc7DQogc3RhdGljIGludCBt
aXhlZF9mbGFnOw0KK3N0YXRpYyBpbnQgZW5zdXJlX2ZsYWc7DQogc3RhdGlj
IGNvbnN0IGNoYXIgKmZvcm1hdF90eXBlX2FyZzsNCiANCiBzdGF0aWMgc3Ry
dWN0IG9wdGlvbiBsb25nX29wdGlvbnNbXSA9IHsNCkBAIC01MywxMCArNTQs
MTEgQEAgc3RhdGljIHN0cnVjdCBvcHRpb24gbG9uZ19vcHRpb25zW10gPSB7
DQogICB7KGNoYXIgKikgInNtcHJvZ3JhbXMiLCBub19hcmd1bWVudCwgTlVM
TCwgJ1AnfSwNCiAgIHsoY2hhciAqKSAic3lzZGlyIiwgbm9fYXJndW1lbnQs
IE5VTEwsICdTJ30sDQogICB7KGNoYXIgKikgIndpbmRpciIsIG5vX2FyZ3Vt
ZW50LCBOVUxMLCAnVyd9LA0KKyAgeyhjaGFyICopICJlbnN1cmUiLCBub19h
cmd1bWVudCwgTlVMTCwgJ2UnfSwNCiAgIHswLCBub19hcmd1bWVudCwgMCwg
MH0NCiB9Ow0KIA0KLXN0YXRpYyBjaGFyIG9wdGlvbnNbXSA9ICJhYzpkZjpo
aWxtb3BzdDp1dndBREhQU1ciOw0KK3N0YXRpYyBjaGFyIG9wdGlvbnNbXSA9
ICJhYzpkZjpoaWxtb3BzdDp1dndBREhQU1dlIjsNCiANCiBzdGF0aWMgdm9p
ZA0KIHVzYWdlIChGSUxFICogc3RyZWFtLCBpbnQgc3RhdHVzKQ0KQEAgLTc2
LDYgKzc4LDcgQEAgUGF0aCBjb252ZXJzaW9uIG9wdGlvbnM6XG5cDQogICAt
bCwgLS1sb25nLW5hbWUJcHJpbnQgV2luZG93cyBsb25nIGZvcm0gb2YgTkFN
RSAod2l0aCAtdywgLW0gb25seSlcblwNCiAgIC1wLCAtLXBhdGgJICAgICAg
ICBOQU1FIGlzIGEgUEFUSCBsaXN0IChpLmUuLCAnL2JpbjovdXNyL2Jpbicp
XG5cDQogICAtcywgLS1zaG9ydC1uYW1lCXByaW50IERPUyAoc2hvcnQpIGZv
cm0gb2YgTkFNRSAod2l0aCAtdywgLW0gb25seSlcblwNCisgIC1lLCAtLWVu
c3VyZQkJZW5zdXJlIHRoZSBwYXRoIGlzIGluIHRoZSByaWdodCBmb3JtYXQg
KHdpdGggLXAgb25seSlcblwNCiBTeXN0ZW0gaW5mb3JtYXRpb246XG5cDQog
ICAtQSwgLS1hbGx1c2VycyAgICAgICAgdXNlIGBBbGwgVXNlcnMnIGluc3Rl
YWQgb2YgY3VycmVudCB1c2VyIGZvciAtRCwgLVBcblwNCiAgIC1ELCAtLWRl
c2t0b3AJCW91dHB1dCBgRGVza3RvcCcgZGlyZWN0b3J5IGFuZCBleGl0XG5c
DQpAQCAtNDExLDYgKzQxNCwyNyBAQCBkb2l0IChjaGFyICpmaWxlbmFtZSkN
CiAgIGludCByZXR2YWw7DQogICBpbnQgKCpjb252X2Z1bmMpIChjb25zdCBj
aGFyICosIGNoYXIgKik7DQogDQorICBpZiAoZW5zdXJlX2ZsYWcgJiYgcGF0
aF9mbGFnKQ0KKyAgICB7DQorICAgICAgaWYgKGN5Z3dpbl9wb3NpeF9wYXRo
X2xpc3RfcCAoZmlsZW5hbWUpID8gdW5peF9mbGFnIDogd2luZG93c19mbGFn
KQ0KKwl7DQorCSAgaWYgKHdpbmRvd3NfZmxhZykNCisJICAgIHsNCisJICAg
ICAgYnVmID0gZmlsZW5hbWU7DQorCSAgICAgIGlmIChzaG9ydG5hbWVfZmxh
ZykNCisJCWJ1ZiA9IGdldF9zaG9ydF9wYXRocyAoYnVmKTsNCisJICAgICAg
aWYgKGxvbmduYW1lX2ZsYWcpDQorCQlidWYgPSBnZXRfbG9uZ19wYXRocyAo
YnVmKTsNCisJICAgICAgaWYgKG1peGVkX2ZsYWcpDQorCQlidWYgPSBnZXRf
bWl4ZWRfbmFtZSAoYnVmKTsNCisJICAgICAgZmlsZW5hbWUgPSBidWY7DQor
CSAgICB9DQorCSAgLyogVGhlIHBhdGggaXMgYWxyZWFkeSBpbiB0aGUgcmln
aHQgZm9ybWF0LiAgKi8NCisJICBwdXRzIChmaWxlbmFtZSk7DQorCSAgZXhp
dCAoMCk7DQorCX0NCisgICAgfQ0KKw0KICAgaWYgKCFwYXRoX2ZsYWcpDQog
ICAgIHsNCiAgICAgICBsZW4gPSBzdHJsZW4gKGZpbGVuYW1lKTsNCkBAIC01
MTgsNiArNTQyLDcgQEAgbWFpbiAoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0K
ICAgZWxzZQ0KICAgICBwcm9nX25hbWUrKzsNCiANCisgIGVuc3VyZV9mbGFn
ID0gMDsNCiAgIHBhdGhfZmxhZyA9IDA7DQogICB1bml4X2ZsYWcgPSAxOw0K
ICAgd2luZG93c19mbGFnID0gMDsNCkBAIC01NjEsNiArNTg2LDEwIEBAIG1h
aW4gKGludCBhcmdjLCBjaGFyICoqYXJndikNCiAJICBwYXRoX2ZsYWcgPSAx
Ow0KIAkgIGJyZWFrOw0KIA0KKwljYXNlICdlJzoNCisJICBlbnN1cmVfZmxh
ZyA9IDE7DQorCSAgYnJlYWs7DQorDQogCWNhc2UgJ3UnOg0KIAkgIGlmICh3
aW5kb3dzX2ZsYWcgfHwgbWl4ZWRfZmxhZykNCiAJICAgIHVzYWdlIChzdGRl
cnIsIDEpOw0KQEAgLTY2NSw2ICs2OTQsOSBAQCBtYWluIChpbnQgYXJnYywg
Y2hhciAqKmFyZ3YpDQogICBpZiAoc2hvcnRuYW1lX2ZsYWcgJiYgIXdpbmRv
d3NfZmxhZykNCiAgICAgdXNhZ2UgKHN0ZGVyciwgMSk7DQogDQorICBpZiAo
ZW5zdXJlX2ZsYWcgJiYgIXBhdGhfZmxhZykNCisgICAgdXNhZ2UgKHN0ZGVy
ciwgMSk7DQorDQogICBpZiAoIXVuaXhfZmxhZyAmJiAhd2luZG93c19mbGFn
ICYmICFtaXhlZF9mbGFnICYmICFvcHRpb25zX2Zyb21fZmlsZV9mbGFnKQ0K
ICAgICB1c2FnZSAoc3RkZXJyLCAxKTsNCiANCkBAIC03NDEsNiArNzczLDkg
QEAgbWFpbiAoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KIAkJICAgIGJyZWFr
Ow0KIAkJICBjYXNlICdwJzoNCiAJCSAgICBwYXRoX2ZsYWcgPSAxOw0KKwkJ
ICAgIGJyZWFrOw0KKwkJICBjYXNlICdlJzoNCisJCSAgICBlbnN1cmVfZmxh
ZyA9IDE7DQogCQkgICAgYnJlYWs7DQogCQkgIGNhc2UgJ0QnOg0KIAkJICBj
YXNlICdIJzoNCg==

---559023410-851401618-1045012082=:14791--
