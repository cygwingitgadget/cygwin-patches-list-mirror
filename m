Return-Path: <cygwin-patches-return-5304-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1735 invoked by alias); 14 Jan 2005 19:39:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1394 invoked from network); 14 Jan 2005 19:38:55 -0000
Received: from unknown (HELO exgate.steeleye.com) (209.192.50.48)
  by sourceware.org with SMTP; 14 Jan 2005 19:38:55 -0000
Received: from steelpo.steeleye.com ([172.17.4.222]) by exgate.steeleye.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 14 Jan 2005 14:38:54 -0500
Content-class: urn:content-classes:message
Subject: Control auto-uppercasing of environment variables
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4FA70.AE2BC593"
Date: Fri, 14 Jan 2005 19:39:00 -0000
Message-ID: <76CBF6B36306884D835E33553572BE52059ECB@steelpo>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
From: "Ernie Coskrey" <Ernie.Coskrey@steeleye.com>
To: <cygwin-patches@cygwin.com>
X-OriginalArrivalTime: 14 Jan 2005 19:38:54.0804 (UTC) FILETIME=[AEBBC940:01C4FA70]
X-SW-Source: 2005-q1/txt/msg00007.txt.bz2

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4FA70.AE2BC593
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-length: 2720

Cygwin automatically converts all Windows environment variable names to upp=
ercase.  The attached patch allows users to control this behavior by specif=
ying an option in the CYGWIN environment variable: (no)uppercase_env.  The =
default for this option will be "SET", so that Cygwin's default behavior is=
 the same as always.  Adding "nouppercase_env" to the CYGWIN environment va=
riable will cause Cygwin to leave environment variable names in the same st=
ate as they are defined in the Windows environment (except for PATH, which =
will be uppercased as before).

My company has a product which includes a number of shell scripts.  We've b=
undled our product with a commercial product which provided the shell funct=
ionality, and this product did not uppercase environment variables.  We'd l=
ike to rebase our product on Cygwin, and the ability to turn off the auto-u=
ppercase behavior would make this a much easier prospect.  While it would b=
e possible to port the scripts and change variable names, there are issues =
that make this more complicated than it first seems.  For instance, we remo=
tely execute scripts on other systems running our product, so during an upg=
rade it's possible that the shell would be running in the old environment. =
 Referring to uppercase variable names would break in this case.  Again, we=
 could do something to check the environmnent and use the correct version o=
f the variable name, but making Cygwin understand our existing scripts is a=
 more desirable solution.

I have briefly discussed this with Christopher Faylor, who has some reserva=
tions about this functionality.  His comments were:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I should point out that a few people have submitted similar patches over
the years and they have been rejected.  There are other ways to do what
you want to do which do not involve adding an option and slowing down
cygwin's startup.  We tend to be pretty stingy when it comes to adding
new options to the CYGWIN environment variable.

But, if you want to discuss this, then cygwin-patches would be the place
to do so.  You can quote this email there, if you want.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

I can understand the reluctance to add more and more options to the CYGWIN =
environment variable.  I hope that the Cygwin community sees enough value i=
n the ability to control this aspect of Cygwin that this modification is ac=
cepted.  I don't believe that there is any real performance impact with thi=
s change - at most the code costs a few extra machine cycles, but certainly=
 nothing noticeable.

Thanks for considering this modification.

-----
Ernie Coskrey       SteelEye Technology, Inc.    803-461-3875

------_=_NextPart_001_01C4FA70.AE2BC593
Content-Type: application/octet-stream;
	name="uppercase_env.patch"
Content-Transfer-Encoding: base64
Content-Description: uppercase_env.patch
Content-Disposition: attachment;
	filename="uppercase_env.patch"
Content-length: 4982

SW5kZXg6IHdpbnN1cC9jeWd3aW4vZW52aXJvbi5jYwo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dp
bi9lbnZpcm9uLmNjLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjEwOApkaWZm
IC1jIC1yMS4xMDggZW52aXJvbi5jYwoqKiogd2luc3VwL2N5Z3dpbi9lbnZp
cm9uLmNjCTEyIEphbiAyMDA1IDIyOjQwOjQ1IC0wMDAwCTEuMTA4Ci0tLSB3
aW5zdXAvY3lnd2luL2Vudmlyb24uY2MJMTQgSmFuIDIwMDUgMTk6MTg6MzEg
LTAwMDAKKioqKioqKioqKioqKioqCioqKiAzOSw0NCAqKioqCi0tLSAzOSw0
NSAtLS0tCiAgI2lmZGVmIFVTRV9TRVJWRVIKICBleHRlcm4gYm9vbCBhbGxv
d19zZXJ2ZXI7CiAgI2VuZGlmCisgYm9vbCB1cHBlcmNhc2VfZW52ID0gdHJ1
ZTsKICAKICBzdGF0aWMgY2hhciAqKmxhc3RlbnZpcm9uOwogIAoqKioqKioq
KioqKioqKioKKioqIDU0Miw1NDcgKioqKgotLS0gNTQzLDU0OSAtLS0tCiAg
ICB7InN1YmF1dGhfaWQiLCB7ZnVuYzogJnN1YmF1dGhfaWRfaW5pdH0sIGlz
ZnVuYywgTlVMTCwge3swfSwgezB9fX0sCiAgICB7InRpdGxlIiwgeyZkaXNw
bGF5X3RpdGxlfSwganVzdHNldCwgTlVMTCwge3tmYWxzZX0sIHt0cnVlfX19
LAogICAgeyJ0dHkiLCB7TlVMTH0sIHNldF9wcm9jZXNzX3N0YXRlLCBOVUxM
LCB7ezB9LCB7UElEX1VTRVRUWX19fSwKKyAgIHsidXBwZXJjYXNlX2VudiIs
IHsmdXBwZXJjYXNlX2Vudn0sIGp1c3RzZXQsIE5VTEwsIHt7ZmFsc2V9LCB7
dHJ1ZX19fSwKICAgIHsid2luc3ltbGlua3MiLCB7JmFsbG93X3dpbnN5bWxp
bmtzfSwganVzdHNldCwgTlVMTCwge3tmYWxzZX0sIHt0cnVlfX19LAogICAg
e05VTEwsIHswfSwganVzdHNldCwgMCwge3swfSwgezB9fX0KICB9OwoqKioq
KioqKioqKioqKioKKioqIDcyMSw3MjYgKioqKgotLS0gNzIzLDczOSAtLS0t
CiAgICBsYXN0ZW52aXJvbiA9IGVudnAgPSAoY2hhciAqKikgbWFsbG9jICgo
NCArIChlbnZjID0gMTAwKSkgKiBzaXplb2YgKGNoYXIgKikpOwogICAgcmF3
ZW52ID0gR2V0RW52aXJvbm1lbnRTdHJpbmdzICgpOwogIAorICAgLyogQmVm
b3JlIHByb2Nlc3NpbmcgZW52LiB2YXJpYWJsZXMsIGZpbmQgdGhlIENZR1dJ
TiB2YXJpYWJsZSBhbmQgcGFyc2UgaXQsCisgICAgICBpbiBjYXNlIHVwcGVy
Y2FzZV9lbnYgaGFzIGJlZW4gdW5zZXQgYnkgdGhlIHVzZXIuICovCisgICBm
b3IgKHAgPSByYXdlbnY7ICpwICE9ICdcMCc7IHAgPSBzdHJjaHIgKHAsICdc
MCcpICsgMSkKKyAgICAgeworICAgICAgIGlmKCFzdHJuaWNtcChwLCAiQ1lH
V0lOPSIsIHN0cmxlbigiQ1lHV0lOPSIpKSkgeworIAljaGFyICplcSA9IHN0
cmVjaHIgKHAsICc9Jyk7CisgCXBhcnNlX29wdGlvbnMoZXErMSk7CisgCWJy
ZWFrOworICAgICAgIH0KKyAgICAgfQorIAogICAgLyogQ3VycmVudCBkaXJl
Y3RvcnkgaW5mb3JtYXRpb24gaXMgcmVjb3JkZWQgYXMgdmFyaWFibGVzIG9m
IHRoZQogICAgICAgZm9ybSAiPVg6PVg6XGZvb1xiYXI7IHRoZXNlIG11c3Qg
YmUgY2hhbmdlZCBpbnRvIHNvbWV0aGluZyBsZWdhbAogICAgICAgKHdlIGNv
dWxkIGp1c3QgaWdub3JlIHRoZW0gYnV0IG1heWJlIGFuIGFwcGxpY2F0aW9u
IHdpbGwKKioqKioqKioqKioqKioqCioqKiA3MzQsNzQ1ICoqKioKICAgICAg
ICBpZiAoKm5ld3AgPT0gJz0nKQogIAkqbmV3cCA9ICchJzsKICAgICAgICBj
aGFyICplcSA9IHN0cmVjaHIgKG5ld3AsICc9Jyk7CiEgICAgICAgaWYgKCFj
aGlsZF9wcm9jX2luZm8pCiAgCXVjZW52IChuZXdwLCBlcSk7CiAgICAgICAg
aWYgKCpuZXdwID09ICdUJyAmJiBzdHJuY21wIChuZXdwLCAiVEVSTT0iLCA1
KSA9PSAwKQogIAlzYXdURVJNID0gMTsKLSAgICAgICBpZiAoKm5ld3AgPT0g
J0MnICYmIHN0cm5jbXAgKG5ld3AsICJDWUdXSU49Iiwgc2l6ZW9mICgiQ1lH
V0lOPSIpIC0gMSkgPT0gMCkKLSAJcGFyc2Vfb3B0aW9ucyAobmV3cCArIHNp
emVvZiAoIkNZR1dJTj0iKSAtIDEpOwogICAgICAgIGlmICgqZXEgJiYgY29u
dl9zdGFydF9jaGFyc1sodW5zaWduZWQgY2hhcillbnZwW2ldWzBdXSkKICAJ
cG9zaWZ5IChlbnZwICsgaSwgKisrZXEgPyBlcSA6IC0tZXEpOwogICAgICAg
IGRlYnVnX3ByaW50ZiAoIiVwOiAlcyIsIGVudnBbaV0sIGVudnBbaV0pOwot
LS0gNzQ3LDc1NiAtLS0tCiAgICAgICAgaWYgKCpuZXdwID09ICc9JykKICAJ
Km5ld3AgPSAnISc7CiAgICAgICAgY2hhciAqZXEgPSBzdHJlY2hyIChuZXdw
LCAnPScpOwohICAgICAgIGlmICghY2hpbGRfcHJvY19pbmZvICYmICh1cHBl
cmNhc2VfZW52IHx8ICghc3RybmljbXAobmV3cCwgIlBBVEg9IiwgNSkpKSkK
ICAJdWNlbnYgKG5ld3AsIGVxKTsKICAgICAgICBpZiAoKm5ld3AgPT0gJ1Qn
ICYmIHN0cm5jbXAgKG5ld3AsICJURVJNPSIsIDUpID09IDApCiAgCXNhd1RF
Uk0gPSAxOwogICAgICAgIGlmICgqZXEgJiYgY29udl9zdGFydF9jaGFyc1so
dW5zaWduZWQgY2hhcillbnZwW2ldWzBdXSkKICAJcG9zaWZ5IChlbnZwICsg
aSwgKisrZXEgPyBlcSA6IC0tZXEpOwogICAgICAgIGRlYnVnX3ByaW50ZiAo
IiVwOiAlcyIsIGVudnBbaV0sIGVudnBbaV0pOwpJbmRleDogd2luc3VwL2Rv
Yy9jeWd3aW5lbnYuc2dtbAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBm
aWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2RvYy9jeWd3aW5lbnYuc2dtbCx2
CnJldHJpZXZpbmcgcmV2aXNpb24gMS4xNgpkaWZmIC1jIC1yMS4xNiBjeWd3
aW5lbnYuc2dtbAoqKiogd2luc3VwL2RvYy9jeWd3aW5lbnYuc2dtbAkyNCBE
ZWMgMjAwNCAyMTo1ODozOCAtMDAwMAkxLjE2Ci0tLSB3aW5zdXAvZG9jL2N5
Z3dpbmVudi5zZ21sCTE0IEphbiAyMDA1IDE5OjE4OjMzIC0wMDAwCioqKioq
KioqKioqKioqKgoqKiogMTY5LDE3NCAqKioqCi0tLSAxNjksMTgxIC0tLS0K
ICBhbmQgaXQgY2Fubm90IGJlIGNoYW5nZWQgaW4gdGhlIHNoZWxsLjwvcGFy
YT4KICA8L2xpc3RpdGVtPgogIDxsaXN0aXRlbT4KKyA8cGFyYT48ZW52YXI+
KG5vKXVwcGVyY2FzZV9lbnY8L2VudmFyPiAtIGlmIHNldCwgQ3lnd2luIGF1
dG9tYXRpY2FsbHkgY29udmVydHMKKyBhbGwgV2luZG93cyBlbnZpcm9ubWVu
dCB2YXJpYWJsZXMgdG8gdXBwZXItY2FzZS4gIElmIG5vdCBzZXQsIG9ubHkg
dGhlIFBBVEgKKyBlbnZpcm9ubWVudCB2YXJpYWJsZSB3aWxsIGJlIGF1dG9t
YXRpY2FsbHkgY29udmVydGVkIHRvIHVwcGVyLWNhc2U7IHRoZSByZXN0IAor
IHdpbGwgYmUgbGVmdCBpbiB0aGUgc2FtZSBzdGF0ZSBhcyB0aGV5IGFyZSBp
biB0aGUgV2luZG93cyBlbnZpcm9ubWVudC4gIERlZmF1bHRzCisgdG8gc2V0
LjwvcGFyYT4KKyA8L2xpc3RpdGVtPgorIDxsaXN0aXRlbT4KICA8cGFyYT48
ZW52YXI+KG5vKXdpbnN5bWxpbmtzPC9lbnZhcj4gLSBpZiBzZXQsIEN5Z3dp
biBjcmVhdGVzCiAgc3ltbGlua3MgYXMgV2luZG93cyBzaG9ydGN1dHMgd2l0
aCBhIHNwZWNpYWwgaGVhZGVyIGFuZCB0aGUgUi9PIGF0dHJpYnV0ZQogIHNl
dC4gSWYgbm90IHNldCwgQ3lnd2luIGNyZWF0ZXMgc3ltbGlua3MgYXMgcGxh
aW4gZmlsZXMgd2l0aCBhIG1hZ2ljIG51bWJlciwK

------_=_NextPart_001_01C4FA70.AE2BC593--
