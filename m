Return-Path: <cygwin-patches-return-4044-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18032 invoked by alias); 7 Aug 2003 22:50:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18019 invoked from network); 7 Aug 2003 22:50:11 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Thu, 07 Aug 2003 22:50:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [PATCH] Checking integrity of installed packages in cygcheck
Message-ID: <Pine.GSO.4.44.0308071843550.5132-200000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-341603450-1060296610=:5132"
X-SW-Source: 2003-q3/txt/msg00060.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-341603450-1060296610=:5132
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1401

Hi,

This patch adds most of the capability of the script from
<http://cygwin.com/ml/cygwin-apps/2003-08/msg00106.html> to cygcheck.
It is triggered by the "-c" flag to cygcheck.  "Integrity" is a rather
strong word, actually, as all this checks for is the existence of files
and directories, but this could be further built upon (for example, tar
has a diff option that could be useful).  The patch is against cvs HEAD
with my previous micropatch
(<http://cygwin.com/ml/cygwin-patches/2003-q3/msg00058.html>) applied.
Comments and suggestions welcome.
	Igor
==============================================================================
ChangeLog:
2003-08-07  Igor Pechtchanski  <pechtcha@cs.nyu.edu>

	* dump_setup.cc (version_len): New static variable.
	(could_not_access,directory_exists,file_exists)
	(check_package_files): New static functions.
	(dump_setup): Check the contents of each package
	if check_files is true and output the result in the
	"Status" column.  Flush output after each package.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton

---559023410-341603450-1060296610=:5132
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cygcheck-verify-packages.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0308071850100.5132@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename="cygcheck-verify-packages.patch"
Content-length: 6023

SW5kZXg6IHdpbnN1cC91dGlscy9kdW1wX3NldHVwLmNjDQo9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC91
dGlscy9kdW1wX3NldHVwLmNjLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS42
DQpkaWZmIC11IC1wIC1yMS42IGR1bXBfc2V0dXAuY2MNCi0tLSB3aW5zdXAv
dXRpbHMvZHVtcF9zZXR1cC5jYwk3IEZlYiAyMDAzIDIxOjM0OjM0IC0wMDAw
CTEuNg0KKysrIHdpbnN1cC91dGlscy9kdW1wX3NldHVwLmNjCTcgQXVnIDIw
MDMgMjI6MzQ6MTYgLTAwMDANCkBAIC0xNSw5ICsxNSwxMiBAQCBkZXRhaWxz
LiAqLw0KICNpbmNsdWRlIDxzdGRsaWIuaD4NCiAjaW5jbHVkZSA8c3RyaW5n
Lmg+DQogI2luY2x1ZGUgPGlvLmg+DQorI2luY2x1ZGUgPHN5cy9zdGF0Lmg+
DQorI2luY2x1ZGUgPGVycm5vLmg+DQogI2luY2x1ZGUgInBhdGguaCINCiAN
CiBzdGF0aWMgaW50IHBhY2thZ2VfbGVuID0gMjA7DQorc3RhdGljIHVuc2ln
bmVkIGludCB2ZXJzaW9uX2xlbiA9IDEwOw0KIA0KIA0KIHR5cGVkZWYgc3Ry
dWN0DQpAQCAtMTczLDggKzE3NiwxMDAgQEAgbWF0Y2hfYXJndiAoY2hhciAq
KmFyZ3YsIGNvbnN0IGNoYXIgKm5hbQ0KICAgcmV0dXJuIGZhbHNlOw0KIH0N
CiANCitzdGF0aWMgYm9vbA0KK2NvdWxkX25vdF9hY2Nlc3MgKGludCB2ZXJi
b3NlLCBjaGFyICpmaWxlbmFtZSwgY2hhciAqcGFja2FnZSwgY29uc3QgY2hh
ciAqdHlwZSkNCit7DQorICBzd2l0Y2ggKGVycm5vKQ0KKyAgICB7DQorICAg
ICAgY2FzZSBFTk9URElSOg0KKyAgICAgICAgYnJlYWs7DQorICAgICAgY2Fz
ZSBFTk9FTlQ6DQorICAgICAgICBpZiAodmVyYm9zZSkNCisgICAgICAgICAg
cHJpbnRmICgiTWlzc2luZyAlczogLyVzIGZyb20gcGFja2FnZSAlc1xuIiwN
CisgICAgICAgICAgICAgICAgICB0eXBlLCBmaWxlbmFtZSwgcGFja2FnZSk7
DQorICAgICAgICByZXR1cm4gdHJ1ZTsNCisgICAgICBjYXNlIEVBQ0NFUzoN
CisgICAgICAgIGlmICh2ZXJib3NlKQ0KKyAgICAgICAgICBwcmludGYgKCJV
bmFibGUgdG8gYWNjZXNzICVzIC8lcyBmcm9tIHBhY2thZ2UgJXNcbiIsDQor
ICAgICAgICAgICAgICAgICAgdHlwZSwgZmlsZW5hbWUsIHBhY2thZ2UpOw0K
KyAgICAgICAgcmV0dXJuIHRydWU7DQorICAgIH0NCisgIHJldHVybiBmYWxz
ZTsNCit9DQorDQorc3RhdGljIGJvb2wNCitkaXJlY3RvcnlfZXhpc3RzIChp
bnQgdmVyYm9zZSwgY2hhciAqZmlsZW5hbWUsIGNoYXIgKnBhY2thZ2UpDQor
ew0KKyAgc3RydWN0IHN0YXQgc3RhdHVzOw0KKyAgaWYgKHN0YXQoY3lncGF0
aCgiLyIsIGZpbGVuYW1lLCAiLiIsIE5VTEwpLCAmc3RhdHVzKSkNCisgICAg
ew0KKyAgICAgIGlmIChjb3VsZF9ub3RfYWNjZXNzICh2ZXJib3NlLCBmaWxl
bmFtZSwgcGFja2FnZSwgImRpcmVjdG9yeSIpKQ0KKyAgICAgICAgcmV0dXJu
IGZhbHNlOw0KKyAgICB9DQorICBlbHNlIGlmICghU19JU0RJUihzdGF0dXMu
c3RfbW9kZSkpDQorICAgIHsNCisgICAgICBpZiAodmVyYm9zZSkNCisgICAg
ICAgIHByaW50ZiAoIkRpcmVjdG9yeS9maWxlIG1pc21hdGNoOiAvJXMgZnJv
bSBwYWNrYWdlICVzXG4iLCBmaWxlbmFtZSwgcGFja2FnZSk7DQorICAgICAg
cmV0dXJuIGZhbHNlOw0KKyAgICB9DQorICByZXR1cm4gdHJ1ZTsNCit9DQor
DQorc3RhdGljIGJvb2wNCitmaWxlX2V4aXN0cyAoaW50IHZlcmJvc2UsIGNo
YXIgKmZpbGVuYW1lLCBjb25zdCBjaGFyICphbHQsIGNoYXIgKnBhY2thZ2Up
DQorew0KKyAgc3RydWN0IHN0YXQgc3RhdHVzOw0KKyAgaWYgKHN0YXQoY3ln
cGF0aCgiLyIsIGZpbGVuYW1lLCBOVUxMKSwgJnN0YXR1cykgJiYNCisgICAg
ICAoIWFsdCB8fCBzdGF0KGN5Z3BhdGgoIi8iLCBmaWxlbmFtZSwgYWx0LCBO
VUxMKSwgJnN0YXR1cykpKQ0KKyAgICB7DQorICAgICAgaWYgKGNvdWxkX25v
dF9hY2Nlc3MgKHZlcmJvc2UsIGZpbGVuYW1lLCBwYWNrYWdlLCAiZmlsZSIp
KQ0KKyAgICAgICAgcmV0dXJuIGZhbHNlOw0KKyAgICB9DQorICBlbHNlIGlm
ICghU19JU1JFRyhzdGF0dXMuc3RfbW9kZSkpDQorICAgIHsNCisgICAgICBp
ZiAodmVyYm9zZSkNCisgICAgICAgIHByaW50ZiAoIkZpbGUgdHlwZSBtaXNt
YXRjaDogLyVzIGZyb20gcGFja2FnZSAlc1xuIiwgZmlsZW5hbWUsIHBhY2th
Z2UpOw0KKyAgICAgIHJldHVybiBmYWxzZTsNCisgICAgfQ0KKyAgcmV0dXJu
IHRydWU7DQorfQ0KKw0KK3N0YXRpYyBib29sDQorY2hlY2tfcGFja2FnZV9m
aWxlcyAoaW50IHZlcmJvc2UsIGNoYXIgKnBhY2thZ2UpDQorew0KKyAgYm9v
bCByZXN1bHQgPSB0cnVlOw0KKyAgY2hhciBmaWxlbGlzdFs0MDk2XSA9ICIg
LWRjIC9ldGMvc2V0dXAvIjsNCisgIHN0cmNhdChzdHJjYXQoZmlsZWxpc3Qs
IHBhY2thZ2UpLCAiLmxzdC5neiIpOw0KKyAgY2hhciAqemNhdCA9IGN5Z3Bh
dGgoIi9iaW4vZ3ppcC5leGUiLCBOVUxMKTsNCisgIGNoYXIgY29tbWFuZFs0
MDk2XTsNCisgIHN0cmNhdChzdHJjcHkoY29tbWFuZCwgemNhdCksIGZpbGVs
aXN0KTsNCisgIEZJTEUgKmZwID0gcG9wZW4gKGNvbW1hbmQsICJydCIpOw0K
KyAgY2hhciBidWZbNDA5Nl07DQorICB3aGlsZSAoZmdldHMgKGJ1ZiwgNDA5
NiwgZnApKQ0KKyAgICB7DQorICAgICAgY2hhciAqZmlsZW5hbWUgPSBzdHJ0
b2soYnVmLCAiXG4iKTsNCisgICAgICBpZiAoZmlsZW5hbWVbc3RybGVuKGZp
bGVuYW1lKS0xXSA9PSAnLycpDQorICAgICAgICB7DQorICAgICAgICAgIGlm
ICghZGlyZWN0b3J5X2V4aXN0cyh2ZXJib3NlLCBmaWxlbmFtZSwgcGFja2Fn
ZSkpDQorICAgICAgICAgICAgcmVzdWx0ID0gZmFsc2U7DQorICAgICAgICB9
DQorICAgICAgZWxzZSBpZiAoIXN0cm5jbXAoZmlsZW5hbWUsICJldGMvcG9z
dGluc3RhbGwvIiwgMTYpKQ0KKyAgICAgICAgew0KKyAgICAgICAgICBpZiAo
IWZpbGVfZXhpc3RzKHZlcmJvc2UsIGZpbGVuYW1lLCAiLmRvbmUiLCBwYWNr
YWdlKSkNCisgICAgICAgICAgICByZXN1bHQgPSBmYWxzZTsNCisgICAgICAg
IH0NCisgICAgICBlbHNlDQorICAgICAgICB7DQorICAgICAgICAgIGlmICgh
ZmlsZV9leGlzdHModmVyYm9zZSwgZmlsZW5hbWUsICIubG5rIiwgcGFja2Fn
ZSkpDQorICAgICAgICAgICAgcmVzdWx0ID0gZmFsc2U7DQorICAgICAgICB9
DQorICAgIH0NCisgIGZjbG9zZShmcCk7DQorICByZXR1cm4gcmVzdWx0Ow0K
K30NCisNCiB2b2lkDQotZHVtcF9zZXR1cCAoaW50IHZlcmJvc2UsIGNoYXIg
Kiphcmd2LCBib29sIC8qY2hlY2tfZmlsZXMqLykNCitkdW1wX3NldHVwIChp
bnQgdmVyYm9zZSwgY2hhciAqKmFyZ3YsIGJvb2wgY2hlY2tfZmlsZXMpDQog
ew0KICAgY2hhciAqc2V0dXAgPSBjeWdwYXRoICgiL2V0Yy9zZXR1cC9pbnN0
YWxsZWQuZGIiLCBOVUxMKTsNCiAgIEZJTEUgKmZwID0gZm9wZW4gKHNldHVw
LCAicnQiKTsNCkBAIC0yMjMsNiArMzE4LDggQEAgZHVtcF9zZXR1cCAoaW50
IHZlcmJvc2UsIGNoYXIgKiphcmd2LCBibw0KIAkgIGlmIChmLndoYXRbMF0p
DQogCSAgICBzdHJjYXQgKHN0cmNhdCAocGFja2FnZXNbbl0ubmFtZSwgIi0i
KSwgZi53aGF0KTsNCiAJICBwYWNrYWdlc1tuXS52ZXIgPSBzdHJkdXAgKGYu
dmVyKTsNCisJICBpZiAoc3RybGVuKGYudmVyKSA+IHZlcnNpb25fbGVuKQ0K
KwkgICAgdmVyc2lvbl9sZW4gPSBzdHJsZW4oZi52ZXIpOw0KIAkgIG4rKzsN
CiAJICBpZiAoc3RydG9rIChOVUxMLCAiICIpID09IE5VTEwpDQogCSAgICBi
cmVhazsNCkBAIC0yMzEsOSArMzI4LDEyIEBAIGR1bXBfc2V0dXAgKGludCB2
ZXJib3NlLCBjaGFyICoqYXJndiwgYm8NCiANCiAgIHFzb3J0IChwYWNrYWdl
cywgbiwgc2l6ZW9mIChwYWNrYWdlc1swXSksIGNvbXBhcik7DQogDQotICBw
cmludGYgKCIlLSpzICVzXG4iLCBwYWNrYWdlX2xlbiwgIlBhY2thZ2UiLCAi
VmVyc2lvbiIpOw0KKyAgcHJpbnRmICgiJS0qcyAlLSpzICAgICAlc1xuIiwg
cGFja2FnZV9sZW4sICJQYWNrYWdlIiwgdmVyc2lvbl9sZW4sICJWZXJzaW9u
IiwgY2hlY2tfZmlsZXM/IlN0YXR1cyI6IiIpOw0KICAgZm9yIChpbnQgaSA9
IDA7IGkgPCBuOyBpKyspDQotICAgIHByaW50ZiAoIiUtKnMgJXNcbiIsIHBh
Y2thZ2VfbGVuLCBwYWNrYWdlc1tpXS5uYW1lLCBwYWNrYWdlc1tpXS52ZXIp
Ow0KKyAgICB7DQorICAgICAgcHJpbnRmICgiJS0qcyAlLSpzICAgICAlc1xu
IiwgcGFja2FnZV9sZW4sIHBhY2thZ2VzW2ldLm5hbWUsIHZlcnNpb25fbGVu
LCBwYWNrYWdlc1tpXS52ZXIsIGNoZWNrX2ZpbGVzPyhjaGVja19wYWNrYWdl
X2ZpbGVzKHZlcmJvc2UsIHBhY2thZ2VzW2ldLm5hbWUpPyJPSyI6IkluY29t
cGxldGUiKToiIik7DQorICAgICAgZmZsdXNoKHN0ZG91dCk7DQorICAgIH0N
CiAgIGZjbG9zZSAoZnApOw0KIA0KICAgcmV0dXJuOw0K

---559023410-341603450-1060296610=:5132--
