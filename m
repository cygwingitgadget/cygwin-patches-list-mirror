Return-Path: <cygwin-patches-return-3925-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16632 invoked by alias); 6 Jun 2003 09:11:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16448 invoked from network); 6 Jun 2003 09:11:11 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Fri, 06 Jun 2003 09:11:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Return correct error code on subsequent nonblocking connect
Message-ID: <Pine.WNT.4.44.0306061046440.1372-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1463868-27525-1054890660=:1372"
X-SW-Source: 2003-q2/txt/msg00152.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1463868-27525-1054890660=:1372
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 799

Corinna,

after our long discussion about interruptible connects i did some checks
with nonblocking connects.

While the opengroup spec is quite clear (and this time Linux behaves the
same) that the first connect should return EINPROGRESS and following
connects EALREADY cygwin returns always EINPROGRESS. Attached patch fix
this to return EALREADY on the second and all following connects. As a
side effect this will change interrupted blocking connects to return
EALREADY too (and not block again) as we have discussed before.
I think that this more opengroup alike.

Thomas

2003-06-06  Thomas Pfaff  <tpfaff@gmx.net>

	* fhandler_socket.cc (fhandler_socket::connect): Change error
	handling for nonblocking connects to return EALREADY when
	connect is called more than once for the same socket.

--1463868-27525-1054890660=:1372
Content-Type: TEXT/plain; name="fhandler_socket.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0306061111000.1372@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="fhandler_socket.patch"
Content-length: 1591

LS0tIGZoYW5kbGVyX3NvY2tldC5jYy5vcmcJMjAwMy0wNi0wNiAxMDozNDoy
OS4wMDAwMDAwMDAgKzAyMDAKKysrIGZoYW5kbGVyX3NvY2tldC5jYwkyMDAz
LTA2LTA2IDEwOjQ1OjAwLjAwMDAwMDAwMCArMDIwMApAQCAtNTAyLDYgKzUw
Miw3IEBAIGZoYW5kbGVyX3NvY2tldDo6Y29ubmVjdCAoY29uc3Qgc3RydWN0
IHMKICAgQk9PTCBpbl9wcm9ncmVzcyA9IEZBTFNFOwogICBzb2NrYWRkcl9p
biBzaW47CiAgIGludCBzZWNyZXQgWzRdOworICBEV09SRCBlcnI7CiAKICAg
aWYgKCFnZXRfaW5ldF9hZGRyIChuYW1lLCBuYW1lbGVuLCAmc2luLCAmbmFt
ZWxlbiwgc2VjcmV0KSkKICAgICByZXR1cm4gLTE7CkBAIC01MTQsMTIgKzUx
NSwxMiBAQCBmaGFuZGxlcl9zb2NrZXQ6OmNvbm5lY3QgKGNvbnN0IHN0cnVj
dCBzCiAJIHdoZW4gY2FsbGVkIG9uIGEgbm9uLWJsb2NraW5nIHNvY2tldC4g
Ki8KICAgICAgIGlmIChpc19ub25ibG9ja2luZyAoKSB8fCBpc19jb25uZWN0
X3BlbmRpbmcgKCkpCiAJewotCSAgRFdPUkQgZXJyID0gV1NBR2V0TGFzdEVy
cm9yICgpOworCSAgZXJyID0gV1NBR2V0TGFzdEVycm9yICgpOwogCSAgaWYg
KGVyciA9PSBXU0FFV09VTERCTE9DSyB8fCBlcnIgPT0gV1NBRUFMUkVBRFkp
Ci0JICAgIHsKLQkgICAgICBXU0FTZXRMYXN0RXJyb3IgKFdTQUVJTlBST0dS
RVNTKTsKLQkgICAgICBpbl9wcm9ncmVzcyA9IFRSVUU7Ci0JICAgIH0KKwkg
ICAgaW5fcHJvZ3Jlc3MgPSBUUlVFOworCisJICBpZiAoZXJyID09IFdTQUVX
T1VMREJMT0NLKQorCSAgICBXU0FTZXRMYXN0RXJyb3IgKFdTQUVJTlBST0dS
RVNTKTsKIAkgIGVsc2UgaWYgKGVyciA9PSBXU0FFSU5WQUwpCiAJICAgIFdT
QVNldExhc3RFcnJvciAoV1NBRUlTQ09OTik7CiAJfQpAQCAtNTU2LDcgKzU1
Nyw4IEBAIGZoYW5kbGVyX3NvY2tldDo6Y29ubmVjdCAoY29uc3Qgc3RydWN0
IHMKIAl9CiAgICAgfQogCi0gIGlmIChXU0FHZXRMYXN0RXJyb3IgKCkgPT0g
V1NBRUlOUFJPR1JFU1MpCisgIGVyciA9IFdTQUdldExhc3RFcnJvciAoKTsK
KyAgaWYgKGVyciA9PSBXU0FFSU5QUk9HUkVTUyB8fCBlcnIgPT0gV1NBRUFM
UkVBRFkpCiAgICAgc2V0X2Nvbm5lY3Rfc3RhdGUgKENPTk5FQ1RfUEVORElO
Ryk7CiAgIGVsc2UKICAgICBzZXRfY29ubmVjdF9zdGF0ZSAoQ09OTkVDVEVE
KTsK

--1463868-27525-1054890660=:1372--
