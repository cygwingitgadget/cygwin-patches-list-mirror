Return-Path: <cygwin-patches-return-3917-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8353 invoked by alias); 27 May 2003 08:20:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8259 invoked from network); 27 May 2003 08:20:17 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Tue, 27 May 2003 08:20:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: [corinna-cygwin@cygwin.com: Re: ENOTSOCK errors with
 cygwin dll 1.3.21 and 1.3.22]
In-Reply-To: <20030527080142.GB19957@cygbert.vinschen.de>
Message-ID: <Pine.WNT.4.44.0305271006230.1364-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="827897-14097-1054023593=:1364"
X-SW-Source: 2003-q2/txt/msg00144.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--827897-14097-1054023593=:1364
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1433



On Tue, 27 May 2003, Corinna Vinschen wrote:

> Hi Thomas,
>
> On Tue, May 27, 2003 at 09:15:10AM +0200, Thomas Pfaff wrote:
> > 	* fhandler_socket.cc (sock_event::~sock_event): New method.
> > 	(sock_event::load): Change to void. Check if winsock2 is available.
> > 	(socke_event::wait): Return 0 if interruptible mode is not available.
> > 	(fhandler_socket::connect): Remove checks for winsock2 availability.
> > 	(fhandler_socket::accept): Ditto.
>
> that looks pretty good, just...
>
> > --- fhandler_socket.cc.org	2003-05-26 16:08:16.000000000 +0200
> > +++ fhandler_socket.cc	2003-05-27 09:05:38.000000000 +0200
> > @@ -131,31 +131,44 @@ public:
> >        ev[0] = WSA_INVALID_EVENT;
> >        ev[1] = signal_arrived;
> >      }
> > -  bool load (SOCKET sock, int type_bit)
> > +  ~sock_event ()
> >      {
> > -      if ((ev[0] = WSACreateEvent ()) == WSA_INVALID_EVENT)
> > -	return false;
> > +      if (ev[0] != WSA_INVALID_EVENT)
> > +        CloseHandle (ev[0]);
>            ^^^^^^^^^^^
> 	   ...shouldn't that be a WSACloseEvent?
>
> > +    }
>

Of course you are right. I have fixed this.

In reality this shouldn't make any difference since WSACreateEvent will use
CreateEvent and the handles are therefore compatible.
In another project i have used CreateEvent to create an event that was used with
WSAEventSelect because i had to create it in a constructor before WSAStartup
and it worked the same way.

Thomas

--827897-14097-1054023593=:1364
Content-Type: TEXT/plain; name="fhandler_socket.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0305271019530.1364@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="fhandler_socket.patch"
Content-length: 3770

LS0tIGZoYW5kbGVyX3NvY2tldC5jYy5vcmcJMjAwMy0wNS0yNiAxNjowODox
Ni4wMDAwMDAwMDAgKzAyMDAKKysrIGZoYW5kbGVyX3NvY2tldC5jYwkyMDAz
LTA1LTI3IDEwOjA2OjUyLjAwMDAwMDAwMCArMDIwMApAQCAtMTMxLDMxICsx
MzEsNDQgQEAgcHVibGljOgogICAgICAgZXZbMF0gPSBXU0FfSU5WQUxJRF9F
VkVOVDsKICAgICAgIGV2WzFdID0gc2lnbmFsX2Fycml2ZWQ7CiAgICAgfQot
ICBib29sIGxvYWQgKFNPQ0tFVCBzb2NrLCBpbnQgdHlwZV9iaXQpCisgIH5z
b2NrX2V2ZW50ICgpCiAgICAgewotICAgICAgaWYgKChldlswXSA9IFdTQUNy
ZWF0ZUV2ZW50ICgpKSA9PSBXU0FfSU5WQUxJRF9FVkVOVCkKLQlyZXR1cm4g
ZmFsc2U7CisgICAgICBpZiAoZXZbMF0gIT0gV1NBX0lOVkFMSURfRVZFTlQp
CisgICAgICAgIFdTQUNsb3NlRXZlbnQgKGV2WzBdKTsKKyAgICB9CisgIHZv
aWQgbG9hZCAoU09DS0VUIHNvY2ssIGludCB0eXBlX2JpdCkKKyAgICB7Cisg
ICAgICBpZiAoIXdpbnNvY2syX2FjdGl2ZSkKKyAgICAgICAgLyogQ2FuIG5v
dCB3YWl0IGZvciBzaWduYWwgaWYgd2luc29jazIgaXMgbm90IGFjdGl2ZSAq
LworICAgICAgICByZXR1cm47CisKKyAgICAgIGlmIChldlswXSA9PSBXU0Ff
SU5WQUxJRF9FVkVOVCkKKyAgICAgICAgaWYgKChldlswXSA9IFdTQUNyZWF0
ZUV2ZW50ICgpKSA9PSBXU0FfSU5WQUxJRF9FVkVOVCkKKyAgICAgICAgICBy
ZXR1cm47CisKICAgICAgIGV2dF9zb2NrID0gc29jazsKICAgICAgIGV2dF90
eXBlX2JpdCA9IHR5cGVfYml0OwogICAgICAgaWYgKFdTQUV2ZW50U2VsZWN0
IChldnRfc29jaywgZXZbMF0sIDEgPDwgZXZ0X3R5cGVfYml0KSkKIAl7CiAJ
ICBXU0FDbG9zZUV2ZW50IChldlswXSk7CiAJICBldlswXSA9IFdTQV9JTlZB
TElEX0VWRU5UOwotCSAgcmV0dXJuIGZhbHNlOwogCX0KLSAgICAgIHJldHVy
biB0cnVlOwogICAgIH0KICAgaW50IHdhaXQgKCkKICAgICB7CiAgICAgICBX
U0FORVRXT1JLRVZFTlRTIHNvY2tfZXZlbnQ7Ci0gICAgICBpbnQgd2FpdF9y
ZXN1bHQgPSBXU0FXYWl0Rm9yTXVsdGlwbGVFdmVudHMgKDIsIGV2LCBGQUxT
RSwgV1NBX0lORklOSVRFLAorICAgICAgaW50IHdhaXRfcmVzdWx0OworCisg
ICAgICBpZiAoZXZbMF0gPT0gV1NBX0lOVkFMSURfRVZFTlQpCisgICAgICAg
IHJldHVybiAwOworCisgICAgICB3YWl0X3Jlc3VsdCA9IFdTQVdhaXRGb3JN
dWx0aXBsZUV2ZW50cyAoMiwgZXYsIEZBTFNFLCBXU0FfSU5GSU5JVEUsCiAJ
CQkJCQkgIEZBTFNFKTsKICAgICAgIGlmICh3YWl0X3Jlc3VsdCA9PSBXU0Ff
V0FJVF9FVkVOVF8wKQogCVdTQUVudW1OZXR3b3JrRXZlbnRzIChldnRfc29j
aywgZXZbMF0sICZzb2NrX2V2ZW50KTsKIAogICAgICAgLyogQ2xlYW51cCwg
IFJldmVydCB0byBibG9ja2luZy4gKi8KICAgICAgIFdTQUV2ZW50U2VsZWN0
IChldnRfc29jaywgZXZbMF0sIDApOwotICAgICAgV1NBQ2xvc2VFdmVudCAo
ZXZbMF0pOwogICAgICAgdW5zaWduZWQgbG9uZyBub25ibG9ja2luZyA9IDA7
CiAgICAgICBpb2N0bHNvY2tldCAoZXZ0X3NvY2ssIEZJT05CSU8sICZub25i
bG9ja2luZyk7CiAKQEAgLTU2NCwxNiArNTc3LDEyIEBAIGZoYW5kbGVyX3Nv
Y2tldDo6Y29ubmVjdCAoY29uc3Qgc3RydWN0IHMKICAgaWYgKCFnZXRfaW5l
dF9hZGRyIChuYW1lLCBuYW1lbGVuLCAmc2luLCAmbmFtZWxlbiwgc2VjcmV0
KSkKICAgICByZXR1cm4gLTE7CiAKLSAgaWYgKHdpbnNvY2syX2FjdGl2ZSAm
JiAhaXNfbm9uYmxvY2tpbmcgKCkgJiYgIWlzX2Nvbm5lY3RfcGVuZGluZyAo
KSkKLSAgICBpZiAoIWV2dC5sb2FkIChnZXRfc29ja2V0ICgpLCBGRF9DT05O
RUNUX0JJVCkpCi0gICAgICB7Ci0Jc2V0X3dpbnNvY2tfZXJybm8gKCk7Ci0J
cmV0dXJuIC0xOwotICAgICAgfQorICBpZiAoIWlzX25vbmJsb2NraW5nICgp
ICYmICFpc19jb25uZWN0X3BlbmRpbmcgKCkpCisgICAgZXZ0LmxvYWQgKGdl
dF9zb2NrZXQgKCksIEZEX0NPTk5FQ1RfQklUKTsKIAogICByZXMgPSA6OmNv
bm5lY3QgKGdldF9zb2NrZXQgKCksIChzb2NrYWRkciAqKSAmc2luLCBuYW1l
bGVuKTsKIAotICBpZiAod2luc29jazJfYWN0aXZlICYmIHJlcyAmJiAhaXNf
bm9uYmxvY2tpbmcgKCkgJiYgIWlzX2Nvbm5lY3RfcGVuZGluZyAoKSAmJgor
ICBpZiAocmVzICYmICFpc19ub25ibG9ja2luZyAoKSAmJiAhaXNfY29ubmVj
dF9wZW5kaW5nICgpICYmCiAgICAgICBXU0FHZXRMYXN0RXJyb3IgKCkgPT0g
V1NBRVdPVUxEQkxPQ0spCiAgICAgc3dpdGNoIChldnQud2FpdCAoKSkKICAg
ICAgIHsKQEAgLTY4NCwxNCArNjkzLDEwIEBAIGZoYW5kbGVyX3NvY2tldDo6
YWNjZXB0IChzdHJ1Y3Qgc29ja2FkZHIKICAgaWYgKGxlbiAmJiAoKHVuc2ln
bmVkKSAqbGVuIDwgc2l6ZW9mIChzdHJ1Y3Qgc29ja2FkZHJfaW4pKSkKICAg
ICAqbGVuID0gc2l6ZW9mIChzdHJ1Y3Qgc29ja2FkZHJfaW4pOwogCi0gIGlm
ICh3aW5zb2NrMl9hY3RpdmUgJiYgIWlzX25vbmJsb2NraW5nICgpKQorICBp
ZiAoIWlzX25vbmJsb2NraW5nICgpKQogICAgIHsKICAgICAgIHNvY2tfZXZl
bnQgZXZ0OwotICAgICAgaWYgKCFldnQubG9hZCAoZ2V0X3NvY2tldCAoKSwg
RkRfQUNDRVBUX0JJVCkpCi0JewotCSAgc2V0X3dpbnNvY2tfZXJybm8gKCk7
Ci0JICByZXR1cm4gLTE7Ci0JfQorICAgICAgZXZ0LmxvYWQgKGdldF9zb2Nr
ZXQgKCksIEZEX0FDQ0VQVF9CSVQpOwogICAgICAgc3dpdGNoIChldnQud2Fp
dCAoKSkKIAl7CiAJICBjYXNlIDE6IC8qIFNpZ25hbCAqLwo=

--827897-14097-1054023593=:1364--
