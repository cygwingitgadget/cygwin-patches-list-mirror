Return-Path: <cygwin-patches-return-2054-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 9099 invoked by alias); 12 Apr 2002 10:53:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9060 invoked from network); 12 Apr 2002 10:52:58 -0000
Date: Fri, 12 Apr 2002 03:53:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <532464283.20020412145055@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: Disable security checks for connectionless sockets.
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------5D822A21FE2A23"
X-SW-Source: 2002-q2/txt/msg00038.txt.bz2

------------5D822A21FE2A23
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 412

Hi!

  Attached is the patch to address the issue reported in
http://sources.redhat.com/ml/cygwin/2002-04/msg00076.html

I haven't found any way to fix it except disabling security checks for
connectionless sockets.

I'm going to vacation now, so could somebody commit it after reviewing
(of course if there're no problems with the patch)

egor.            mailto:deo@logos-m.ru icq 5165414 fidonet 2:5020/496.19
------------5D822A21FE2A23
Content-Type: application/octet-stream; name="af-unix-dgram-socket-secret-cookie-disable.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="af-unix-dgram-socket-secret-cookie-disable.diff"
Content-length: 2831

SW5kZXg6IGZoYW5kbGVyLmgKPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1Mg
ZmlsZTogL2N2cy91YmVyYmF1bS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyLmgs
dgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTExCmRpZmYgLXUgLXAgLTIgLXIx
LjExMSBmaGFuZGxlci5oCi0tLSBmaGFuZGxlci5oCTE5IE1hciAyMDAyIDA0
OjM5OjAxIC0wMDAwCTEuMTExCisrKyBmaGFuZGxlci5oCTEwIEFwciAyMDAy
IDE1OjE2OjE2IC0wMDAwCkBAIC0zNTgsNCArMzU4LDUgQEAgY2xhc3MgZmhh
bmRsZXJfc29ja2V0OiBwdWJsaWMgZmhhbmRsZXJfYgogIHByaXZhdGU6CiAg
IGludCBhZGRyX2ZhbWlseTsKKyAgaW50IHR5cGU7CiAgIGludCBjb25uZWN0
X3NlY3JldCBbNF07CiAgIEhBTkRMRSBzZWNyZXRfZXZlbnQ7CkBAIC0zOTgs
NCArMzk5LDYgQEAgY2xhc3MgZmhhbmRsZXJfc29ja2V0OiBwdWJsaWMgZmhh
bmRsZXJfYgogICB2b2lkIHNldF9hZGRyX2ZhbWlseSAoaW50IGFmKSB7YWRk
cl9mYW1pbHkgPSBhZjt9CiAgIGludCBnZXRfYWRkcl9mYW1pbHkgKCkge3Jl
dHVybiBhZGRyX2ZhbWlseTt9CisgIHZvaWQgc2V0X3NvY2tldF90eXBlIChp
bnQgc3QpIHsgdHlwZSA9IHN0O30KKyAgaW50IGdldF9zb2NrZXRfdHlwZSAo
KSB7cmV0dXJuIHR5cGU7fQogICB2b2lkIHNldF9zdW5fcGF0aCAoY29uc3Qg
Y2hhciAqcGF0aCk7CiAgIGNoYXIgKmdldF9zdW5fcGF0aCAoKSB7cmV0dXJu
IHN1bl9wYXRoO30KSW5kZXg6IG5ldC5jYwo9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09ClJDUyBmaWxlOiAvY3ZzL3ViZXJiYXVtL3dpbnN1cC9jeWd3aW4vbmV0
LmNjLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjEwNQpkaWZmIC11IC1wIC0y
IC1yMS4xMDUgbmV0LmNjCi0tLSBuZXQuY2MJMTUgTWFyIDIwMDIgMjE6NDk6
MTAgLTAwMDAJMS4xMDUKKysrIG5ldC5jYwkxMCBBcHIgMjAwMiAxNToxNjox
NiAtMDAwMApAQCAtNTE5LDQgKzUxOSw1IEBAIGN5Z3dpbl9zb2NrZXQgKGlu
dCBhZiwgaW50IHR5cGUsIGludCBwcm8KICAgaW50IHJlcyA9IC0xOwogICBT
T0NLRVQgc29jID0gMDsKKyAgZmhhbmRsZXJfc29ja2V0KiBmaCA9IE5VTEw7
CiAKICAgY3lnaGVhcF9mZG5ldyBmZDsKQEAgLTU0MCw1ICs1NDEsMTAgQEAg
Y3lnd2luX3NvY2tldCAoaW50IGFmLCBpbnQgdHlwZSwgaW50IHBybwogCW5h
bWUgPSAodHlwZSA9PSBTT0NLX1NUUkVBTSA/ICIvZGV2L3N0cmVhbXNvY2tl
dCIgOiAiL2Rldi9kZ3NvY2tldCIpOwogCi0gICAgICBmZHNvY2sgKGZkLCBu
YW1lLCBzb2MpLT5zZXRfYWRkcl9mYW1pbHkgKGFmKTsKKyAgICAgIGZoID0g
ZmRzb2NrIChmZCwgbmFtZSwgc29jKTsKKyAgICAgIGlmIChmaCkKKwl7CisJ
ICBmaC0+c2V0X2FkZHJfZmFtaWx5IChhZik7CisgICAgICAgICAgZmgtPnNl
dF9zb2NrZXRfdHlwZSAodHlwZSk7CisJfQogICAgICAgcmVzID0gZmQ7CiAg
ICAgfQpAQCAtODgyLDUgKzg4OCw2IEBAIGN5Z3dpbl9jb25uZWN0IChpbnQg
ZmQsCiAJICBzZXRfd2luc29ja19lcnJubyAoKTsKIAl9Ci0gICAgICBpZiAo
c29jay0+Z2V0X2FkZHJfZmFtaWx5ICgpID09IEFGX0xPQ0FMKQorICAgICAg
aWYgKHNvY2stPmdldF9hZGRyX2ZhbWlseSAoKSA9PSBBRl9MT0NBTCAmJgor
CSAgc29jay0+Z2V0X3NvY2tldF90eXBlICgpID09IFNPQ0tfU1RSRUFNKQog
CXsKIAkgIGlmICghcmVzIHx8IGluX3Byb2dyZXNzKQpAQCAtMTIwMCw1ICsx
MjA3LDYgQEAgY3lnd2luX2FjY2VwdCAoaW50IGZkLCBzdHJ1Y3Qgc29ja2Fk
ZHIgKgogCWluX3Byb2dyZXNzID0gVFJVRTsKIAotICAgICAgaWYgKHNvY2st
PmdldF9hZGRyX2ZhbWlseSAoKSA9PSBBRl9MT0NBTCkKKyAgICAgIGlmIChz
b2NrLT5nZXRfYWRkcl9mYW1pbHkgKCkgPT0gQUZfTE9DQUwgJiYKKwkgIHNv
Y2stPmdldF9zb2NrZXRfdHlwZSAoKSA9PSBTT0NLX1NUUkVBTSkKIAl7CiAJ
ICBpZiAoKFNPQ0tFVCkgcmVzICE9IChTT0NLRVQpIElOVkFMSURfU09DS0VU
IHx8IGluX3Byb2dyZXNzKQo=

------------5D822A21FE2A23
Content-Type: application/octet-stream; name="af-unix-dgram-socket-secret-cookie-disable.ChangeLog"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="af-unix-dgram-socket-secret-cookie-disable.ChangeLog"
Content-length: 472

MjAwMi0wNC0xMiAgRWdvciBEdWRhICA8ZGVvQGxvZ29zLW0ucnU+CgoJKiBm
aGFuZGxlci5oIChjbGFzcyBmaGFuZGxlcl9zb2NrZXQpOiBOZXcgbWVtYmVy
IHRvIHN0b3JlIHNvY2tldCB0eXBlLgoJKGZoYW5kbGVyX3NvY2tldDo6Z2V0
X3NvY2tldF90eXBlKTogQWNjZXNzIGl0LgoJKGZoYW5kbGVyX3NvY2tldDo6
c2V0X3NvY2tldF90eXBlKTogRGl0dG8uCgkqIG5ldC5jYyAoY3lnd2luX3Nv
Y2tldCk6IFN0b3JlIHNvY2tldCB0eXBlLgoJKGN5Z3dpbl9jb25uZWN0KTog
RGlzYWJsZSBzZWN1cml0eSBjaGVja3MgZm9yIGNvbm5lY3Rpb25sZXNzIHNv
Y2tldHMuCgkoY3lnd2luX2FjY2VwdCk6IERpdHRvLgo=

------------5D822A21FE2A23--
