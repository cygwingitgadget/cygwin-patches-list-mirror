Return-Path: <cygwin-patches-return-3914-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5497 invoked by alias); 27 May 2003 07:15:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5470 invoked from network); 27 May 2003 07:15:28 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Tue, 27 May 2003 07:15:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Re: [corinna-cygwin@cygwin.com: Re: ENOTSOCK errors with
 cygwin dll 1.3.21 and 1.3.22]
In-Reply-To: <F0E13277A26BD311944600500454CCD05217D2@antarctica.intern.net>
Message-ID: <Pine.WNT.4.44.0305261633550.288-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="450268-5568-1053960033=:288"
Content-ID: <Pine.WNT.4.44.0305270901020.1168@algeria.intern.net>
X-SW-Source: 2003-q2/txt/msg00141.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--450268-5568-1053960033=:288
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.WNT.4.44.0305270901021.1168@algeria.intern.net>
Content-length: 1048



On Mon, 26 May 2003, Corinna Vinschen wrote:

> Ouch!  That's the implementation of sock_event::load().  It uses a bunch
> of functions which are only available in WinSock2.
>
> I've checked in a patch to fhandler_socket::connect() and
> fhandler_socket::accept()).  Could you test it please?  Basically it's
> just checking for WinSock2 availability before calling sock_event::load()
> and sock_event::wait().
>

Corinna,

may i suggest the attached patch to solve this issue. Instead of checking
winsock2_active at 3 different locations i would move this into
sock_event::load. If winsock2 is not active or something with the event
select will fail continue in non interruptible mode.

Thomas

2003-05-27  Thomas Pfaff  <tpfaff@gmx.net>

	* fhandler_socket.cc (sock_event::~sock_event): New method.
	(sock_event::load): Change to void. Check if winsock2 is available.
	(socke_event::wait): Return 0 if interruptible mode is not available.
	(fhandler_socket::connect): Remove checks for winsock2 availability.
	(fhandler_socket::accept): Ditto.

--450268-5568-1053960033=:288
Content-Type: TEXT/plain; name="fhandler_socket.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0305270915100.1168@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="fhandler_socket.patch"
Content-length: 3766

LS0tIGZoYW5kbGVyX3NvY2tldC5jYy5vcmcJMjAwMy0wNS0yNiAxNjowODox
Ni4wMDAwMDAwMDAgKzAyMDAKKysrIGZoYW5kbGVyX3NvY2tldC5jYwkyMDAz
LTA1LTI3IDA5OjA1OjM4LjAwMDAwMDAwMCArMDIwMApAQCAtMTMxLDMxICsx
MzEsNDQgQEAgcHVibGljOgogICAgICAgZXZbMF0gPSBXU0FfSU5WQUxJRF9F
VkVOVDsKICAgICAgIGV2WzFdID0gc2lnbmFsX2Fycml2ZWQ7CiAgICAgfQot
ICBib29sIGxvYWQgKFNPQ0tFVCBzb2NrLCBpbnQgdHlwZV9iaXQpCisgIH5z
b2NrX2V2ZW50ICgpCiAgICAgewotICAgICAgaWYgKChldlswXSA9IFdTQUNy
ZWF0ZUV2ZW50ICgpKSA9PSBXU0FfSU5WQUxJRF9FVkVOVCkKLQlyZXR1cm4g
ZmFsc2U7CisgICAgICBpZiAoZXZbMF0gIT0gV1NBX0lOVkFMSURfRVZFTlQp
CisgICAgICAgIENsb3NlSGFuZGxlIChldlswXSk7CisgICAgfQorICB2b2lk
IGxvYWQgKFNPQ0tFVCBzb2NrLCBpbnQgdHlwZV9iaXQpCisgICAgeworICAg
ICAgaWYgKCF3aW5zb2NrMl9hY3RpdmUpCisgICAgICAgIC8qIENhbiBub3Qg
d2FpdCBmb3Igc2lnbmFsIGlmIHdpbnNvY2syIGlzIG5vdCBhY3RpdmUgKi8K
KyAgICAgICAgcmV0dXJuOworCisgICAgICBpZiAoZXZbMF0gPT0gV1NBX0lO
VkFMSURfRVZFTlQpCisgICAgICAgIGlmICgoZXZbMF0gPSBXU0FDcmVhdGVF
dmVudCAoKSkgPT0gV1NBX0lOVkFMSURfRVZFTlQpCisgICAgICAgICAgcmV0
dXJuOworCiAgICAgICBldnRfc29jayA9IHNvY2s7CiAgICAgICBldnRfdHlw
ZV9iaXQgPSB0eXBlX2JpdDsKICAgICAgIGlmIChXU0FFdmVudFNlbGVjdCAo
ZXZ0X3NvY2ssIGV2WzBdLCAxIDw8IGV2dF90eXBlX2JpdCkpCiAJewogCSAg
V1NBQ2xvc2VFdmVudCAoZXZbMF0pOwogCSAgZXZbMF0gPSBXU0FfSU5WQUxJ
RF9FVkVOVDsKLQkgIHJldHVybiBmYWxzZTsKIAl9Ci0gICAgICByZXR1cm4g
dHJ1ZTsKICAgICB9CiAgIGludCB3YWl0ICgpCiAgICAgewogICAgICAgV1NB
TkVUV09SS0VWRU5UUyBzb2NrX2V2ZW50OwotICAgICAgaW50IHdhaXRfcmVz
dWx0ID0gV1NBV2FpdEZvck11bHRpcGxlRXZlbnRzICgyLCBldiwgRkFMU0Us
IFdTQV9JTkZJTklURSwKKyAgICAgIGludCB3YWl0X3Jlc3VsdDsKKworICAg
ICAgaWYgKGV2WzBdID09IFdTQV9JTlZBTElEX0VWRU5UKQorICAgICAgICBy
ZXR1cm4gMDsKKworICAgICAgd2FpdF9yZXN1bHQgPSBXU0FXYWl0Rm9yTXVs
dGlwbGVFdmVudHMgKDIsIGV2LCBGQUxTRSwgV1NBX0lORklOSVRFLAogCQkJ
CQkJICBGQUxTRSk7CiAgICAgICBpZiAod2FpdF9yZXN1bHQgPT0gV1NBX1dB
SVRfRVZFTlRfMCkKIAlXU0FFbnVtTmV0d29ya0V2ZW50cyAoZXZ0X3NvY2ss
IGV2WzBdLCAmc29ja19ldmVudCk7CiAKICAgICAgIC8qIENsZWFudXAsICBS
ZXZlcnQgdG8gYmxvY2tpbmcuICovCiAgICAgICBXU0FFdmVudFNlbGVjdCAo
ZXZ0X3NvY2ssIGV2WzBdLCAwKTsKLSAgICAgIFdTQUNsb3NlRXZlbnQgKGV2
WzBdKTsKICAgICAgIHVuc2lnbmVkIGxvbmcgbm9uYmxvY2tpbmcgPSAwOwog
ICAgICAgaW9jdGxzb2NrZXQgKGV2dF9zb2NrLCBGSU9OQklPLCAmbm9uYmxv
Y2tpbmcpOwogCkBAIC01NjQsMTYgKzU3NywxMiBAQCBmaGFuZGxlcl9zb2Nr
ZXQ6OmNvbm5lY3QgKGNvbnN0IHN0cnVjdCBzCiAgIGlmICghZ2V0X2luZXRf
YWRkciAobmFtZSwgbmFtZWxlbiwgJnNpbiwgJm5hbWVsZW4sIHNlY3JldCkp
CiAgICAgcmV0dXJuIC0xOwogCi0gIGlmICh3aW5zb2NrMl9hY3RpdmUgJiYg
IWlzX25vbmJsb2NraW5nICgpICYmICFpc19jb25uZWN0X3BlbmRpbmcgKCkp
Ci0gICAgaWYgKCFldnQubG9hZCAoZ2V0X3NvY2tldCAoKSwgRkRfQ09OTkVD
VF9CSVQpKQotICAgICAgewotCXNldF93aW5zb2NrX2Vycm5vICgpOwotCXJl
dHVybiAtMTsKLSAgICAgIH0KKyAgaWYgKCFpc19ub25ibG9ja2luZyAoKSAm
JiAhaXNfY29ubmVjdF9wZW5kaW5nICgpKQorICAgIGV2dC5sb2FkIChnZXRf
c29ja2V0ICgpLCBGRF9DT05ORUNUX0JJVCk7CiAKICAgcmVzID0gOjpjb25u
ZWN0IChnZXRfc29ja2V0ICgpLCAoc29ja2FkZHIgKikgJnNpbiwgbmFtZWxl
bik7CiAKLSAgaWYgKHdpbnNvY2syX2FjdGl2ZSAmJiByZXMgJiYgIWlzX25v
bmJsb2NraW5nICgpICYmICFpc19jb25uZWN0X3BlbmRpbmcgKCkgJiYKKyAg
aWYgKHJlcyAmJiAhaXNfbm9uYmxvY2tpbmcgKCkgJiYgIWlzX2Nvbm5lY3Rf
cGVuZGluZyAoKSAmJgogICAgICAgV1NBR2V0TGFzdEVycm9yICgpID09IFdT
QUVXT1VMREJMT0NLKQogICAgIHN3aXRjaCAoZXZ0LndhaXQgKCkpCiAgICAg
ICB7CkBAIC02ODQsMTQgKzY5MywxMCBAQCBmaGFuZGxlcl9zb2NrZXQ6OmFj
Y2VwdCAoc3RydWN0IHNvY2thZGRyCiAgIGlmIChsZW4gJiYgKCh1bnNpZ25l
ZCkgKmxlbiA8IHNpemVvZiAoc3RydWN0IHNvY2thZGRyX2luKSkpCiAgICAg
KmxlbiA9IHNpemVvZiAoc3RydWN0IHNvY2thZGRyX2luKTsKIAotICBpZiAo
d2luc29jazJfYWN0aXZlICYmICFpc19ub25ibG9ja2luZyAoKSkKKyAgaWYg
KCFpc19ub25ibG9ja2luZyAoKSkKICAgICB7CiAgICAgICBzb2NrX2V2ZW50
IGV2dDsKLSAgICAgIGlmICghZXZ0LmxvYWQgKGdldF9zb2NrZXQgKCksIEZE
X0FDQ0VQVF9CSVQpKQotCXsKLQkgIHNldF93aW5zb2NrX2Vycm5vICgpOwot
CSAgcmV0dXJuIC0xOwotCX0KKyAgICAgIGV2dC5sb2FkIChnZXRfc29ja2V0
ICgpLCBGRF9BQ0NFUFRfQklUKTsKICAgICAgIHN3aXRjaCAoZXZ0LndhaXQg
KCkpCiAJewogCSAgY2FzZSAxOiAvKiBTaWduYWwgKi8K

--450268-5568-1053960033=:288--
