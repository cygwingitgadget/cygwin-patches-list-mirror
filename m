Return-Path: <cygwin-patches-return-3117-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31731 invoked by alias); 5 Nov 2002 10:19:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31682 invoked from network); 5 Nov 2002 10:19:48 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Date: Tue, 05 Nov 2002 02:19:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] fhandler_socket::recvmsg [WAS: Anyone interested in checking
 out dgram socket problem (Conrad you still here?)]
In-Reply-To: <20021105050917.GA19118@redhat.com>
Message-ID: <Pine.WNT.4.44.0211051101530.322-200000@algeria.intern.net>
X-X-Sender: pfaff@antarctica.intern.net
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1083393-7599-1036491575=:322"
X-SW-Source: 2002-q4/txt/msg00068.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1083393-7599-1036491575=:322
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 659



On Tue, 5 Nov 2002, Christopher Faylor wrote:

> There is a thread in cygwin at cygwin entitled:
>
> "1.3.13-2 & 1.3.14-1 problem on read() from dgram socket"
>
> Is anyone willing to debug the problem and, if it is a cygwin problem,
> provide a fix?
>
> cgf
>
> http://cygwin.com/ml/cygwin/2002-10/msg01974.html
>

It seems that the fromlen in WSARecvFrom must be NULL if from is NULL and
not a pointer to 0.
Actually msg->msg_name is NULL and msg->msg_namelen is 0 which will result
in WSAEFAULT.

Thomas

2002-11-05  Thomas Pfaff  <tpfaff@gmx.net>

	* fhandler_socket.cc (fhandler_socket::recvmsg): If from == NULL
	call WSARecvFrom with fromlen = NULL.

--1083393-7599-1036491575=:322
Content-Type: TEXT/plain; name="fhandler_socket_recvmsg.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.WNT.4.44.0211051119350.322@algeria.intern.net>
Content-Description: 
Content-Disposition: attachment; filename="fhandler_socket_recvmsg.patch"
Content-length: 2148

LS0tIGZoYW5kbGVyX3NvY2tldC5jYy5vcmcJMjAwMi0xMC0yMSAwMzowMzoz
Mi4wMDAwMDAwMDAgKzAyMDAKKysrIGZoYW5kbGVyX3NvY2tldC5jYwkyMDAy
LTExLTA1IDEwOjU0OjQ5LjAwMDAwMDAwMCArMDEwMApAQCAtNzM0LDE0ICs3
MzQsMTYgQEAgZmhhbmRsZXJfc29ja2V0OjpyZWN2bXNnIChzdHJ1Y3QgbXNn
aGRyIAogICBzdHJ1Y3QgaW92ZWMgKmNvbnN0IGlvdiA9IG1zZy0+bXNnX2lv
djsKICAgY29uc3QgaW50IGlvdmNudCA9IG1zZy0+bXNnX2lvdmxlbjsKIAor
ICBzdHJ1Y3Qgc29ja2FkZHIgKmZyb20gPSAoc3RydWN0IHNvY2thZGRyICop
IG1zZy0+bXNnX25hbWU7CisgIGludCAqZnJvbWxlbiA9IGZyb20gPyAmbXNn
LT5tc2dfbmFtZWxlbiA6IE5VTEw7CisKICAgaW50IHJlczsKIAogICBpZiAo
IXdpbnNvY2syX2FjdGl2ZSkKICAgICB7CiAgICAgICBpZiAoaW92Y250ID09
IDEpCiAJcmVzID0gcmVjdmZyb20gKGlvdi0+aW92X2Jhc2UsIGlvdi0+aW92
X2xlbiwgZmxhZ3MsCi0JCQkoc3RydWN0IHNvY2thZGRyICopIG1zZy0+bXNn
X25hbWUsCi0JCQkmbXNnLT5tc2dfbmFtZWxlbik7CisJCQlmcm9tLCBmcm9t
bGVuKTsKICAgICAgIGVsc2UKIAl7CiAJICBpZiAodG90ID09IC0xKQkvLyBp
LmUuIGlmIG5vdCBwcmUtY2FsY3VsYXRlZCBieSB0aGUgY2FsbGVyLgpAQCAt
NzY2LDggKzc2OCw3IEBAIGZoYW5kbGVyX3NvY2tldDo6cmVjdm1zZyAoc3Ry
dWN0IG1zZ2hkciAKIAkgIGVsc2UKIAkgICAgewogCSAgICAgIHJlcyA9IHJl
Y3Zmcm9tIChidWYsIHRvdCwgZmxhZ3MsCi0JCQkgICAgICAoc3RydWN0IHNv
Y2thZGRyICopIG1zZy0+bXNnX25hbWUsCi0JCQkgICAgICAmbXNnLT5tc2df
bmFtZWxlbik7CisJCQkgICAgICBmcm9tLCBmcm9tbGVuKTsKIAogCSAgICAg
IGNvbnN0IHN0cnVjdCBpb3ZlYyAqaW92cHRyID0gaW92OwogCSAgICAgIGlu
dCBuYnl0ZXMgPSByZXM7CkBAIC04MDUsMTYgKzgwNiwxNCBAQCBmaGFuZGxl
cl9zb2NrZXQ6OnJlY3Ztc2cgKHN0cnVjdCBtc2doZHIgCiAgICAgICBpZiAo
aXNfbm9uYmxvY2tpbmcgKCkpCiAJcmVzID0gV1NBUmVjdkZyb20gKGdldF9z
b2NrZXQgKCksCiAJCQkgICB3c2FidWYsIGlvdmNudCwgJnJldCwgKERXT1JE
ICopICZmbGFncywKLQkJCSAgIChzdHJ1Y3Qgc29ja2FkZHIgKikgbXNnLT5t
c2dfbmFtZSwKLQkJCSAgICZtc2ctPm1zZ19uYW1lbGVuLAorCQkJICAgZnJv
bSwgZnJvbWxlbiwKIAkJCSAgIE5VTEwsIE5VTEwpOwogICAgICAgZWxzZQog
CXsKIAkgIHdzb2NrX2V2ZW50IHdzb2NrX2V2dDsKIAkgIHJlcyA9IFdTQVJl
Y3ZGcm9tIChnZXRfc29ja2V0ICgpLAogCQkJICAgICB3c2FidWYsIGlvdmNu
dCwgJnJldCwgKERXT1JEICopICZmbGFncywKLQkJCSAgICAgKHN0cnVjdCBz
b2NrYWRkciAqKSBtc2ctPm1zZ19uYW1lLAotCQkJICAgICAmbXNnLT5tc2df
bmFtZWxlbiwKKwkJCSAgICAgZnJvbSwgZnJvbWxlbiwKIAkJCSAgICAgd3Nv
Y2tfZXZ0LnByZXBhcmUgKCksIE5VTEwpOwogCiAJICBpZiAocmVzID09IFNP
Q0tFVF9FUlJPUiAmJiBXU0FHZXRMYXN0RXJyb3IgKCkgPT0gV1NBX0lPX1BF
TkRJTkcpCg==

--1083393-7599-1036491575=:322--
