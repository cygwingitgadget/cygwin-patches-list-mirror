From: "Michael A. Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH]Write Mount Commands - TNG
Date: Mon, 03 Sep 2001 17:54:00 -0000
Message-id: <004901c134db$743a6230$200a0a0a@us.oracle.com>
X-SW-Source: 2001-q3/msg00097.html
Content-type: multipart/mixed; boundary="----------=_1583532848-65438-95"

This is a multi-part message in MIME format...

------------=_1583532848-65438-95
Content-length: 929

----- Original Message -----
From: "Christopher Faylor" <cgf@redhat.com>
To: <cygwin-patches@cygwin.com>
Sent: Monday, September 03, 2001 15:03
Subject: Re: [PATCH]Write Mount Commands

> I don't think you should be displaying mount commands for the default
drive
> stuff, i.e. mount -f -u -t "u:" "/cygdrive/u"

This corrects the problem that caused mount to list /cygdrive/u mounts
points along with the explicit ones.

> Also, I wonder if it would be nicer only to quote the path specs which
contain
> spaces?

I quoting everything is safer.  The only characters that doesn't protect are
(", $, and %) and anyone who uses those in a mount point path deserves the
grief they get.
--
Mac :})
Give a hobbit a fish and he eats fish for a day.
Give a hobbit a ring and he eats fish for an age.

Changelog:

2001-09-03  Michael A Chase <mchase@ix.netcom.com>

    * mount.cc (mount_commands): Don't write /cygdrive/u mount points.


------------=_1583532848-65438-95
Content-Type: text/x-diff; charset=us-ascii; name="mount.cc-patch-2"
Content-Disposition: inline; filename="mount.cc-patch-2"
Content-Transfer-Encoding: base64
Content-Length: 1830

LS0tIG1vdW50LmNjLm9yaWcyCU1vbiBTZXAgIDMgMDk6NTU6MDkgMjAwMQor
KysgbW91bnQuY2MJTW9uIFNlcCAgMyAxNzoyNTo1NSAyMDAxCkBAIC0yNjUs
MjAgKzI2NSwyMyBAQCBtb3VudF9jb21tYW5kcyAodm9pZCkKIAogICAvLyB3
cml0ZSBtb3VudCBjb21tYW5kcyBmb3IgdXNlciBhbmQgc3lzdGVtIG1vdW50
IHBvaW50cwogICB3aGlsZSAoKHAgPSBnZXRtbnRlbnQgKG0pKSAhPSBOVUxM
KSB7Ci0gICAgc3RyY3B5KG9wdHMsICIgLWYiKTsKLSAgICBpZiAgICAgIChw
LT5tbnRfdHlwZVswXSA9PSAndScpCi0gICAgICBzdHJjYXQgKG9wdHMsICIg
LXUiKTsKLSAgICBlbHNlIGlmIChwLT5tbnRfdHlwZVswXSA9PSAncycpCi0g
ICAgICBzdHJjYXQgKG9wdHMsICIgLXMiKTsKLSAgICBpZiAgICAgIChwLT5t
bnRfb3B0c1swXSA9PSAnYicpCi0gICAgICBzdHJjYXQgKG9wdHMsICIgLWIi
KTsKLSAgICBlbHNlIGlmIChwLT5tbnRfb3B0c1swXSA9PSAndCcpCi0gICAg
ICBzdHJjYXQgKG9wdHMsICIgLXQiKTsKLSAgICBpZiAoc3Ryc3RyIChwLT5t
bnRfb3B0cywgIixleGVjIikpCi0gICAgICBzdHJjYXQgKG9wdHMsICIgLXgi
KTsKLSAgICB3aGlsZSAoKGMgPSBzdHJjaHIgKHAtPm1udF9mc25hbWUsICdc
XCcpKSAhPSBOVUxMKQotICAgICAgKmMgPSAnLyc7Ci0gICAgcHJpbnRmIChm
b3JtYXRfbW50LCBvcHRzLCBwLT5tbnRfZnNuYW1lLCBwLT5tbnRfZGlyKTsK
KyAgICAvLyBPbmx5IGxpc3Qgbm9uLWN5Z2RyaXZlcworICAgIGlmICghc3Ry
c3RyIChwLT5tbnRfb3B0cywgIixub3Vtb3VudCIpKSB7CisgICAgICBzdHJj
cHkob3B0cywgIiAtZiIpOworICAgICAgaWYgICAgICAocC0+bW50X3R5cGVb
MF0gPT0gJ3UnKQorICAgICAgICBzdHJjYXQgKG9wdHMsICIgLXUiKTsKKyAg
ICAgIGVsc2UgaWYgKHAtPm1udF90eXBlWzBdID09ICdzJykKKyAgICAgICAg
c3RyY2F0IChvcHRzLCAiIC1zIik7CisgICAgICBpZiAgICAgIChwLT5tbnRf
b3B0c1swXSA9PSAnYicpCisgICAgICAgIHN0cmNhdCAob3B0cywgIiAtYiIp
OworICAgICAgZWxzZSBpZiAocC0+bW50X29wdHNbMF0gPT0gJ3QnKQorICAg
ICAgICBzdHJjYXQgKG9wdHMsICIgLXQiKTsKKyAgICAgIGlmIChzdHJzdHIg
KHAtPm1udF9vcHRzLCAiLGV4ZWMiKSkKKyAgICAgICAgc3RyY2F0IChvcHRz
LCAiIC14Iik7CisgICAgICB3aGlsZSAoKGMgPSBzdHJjaHIgKHAtPm1udF9m
c25hbWUsICdcXCcpKSAhPSBOVUxMKQorICAgICAgICAqYyA9ICcvJzsKKyAg
ICAgIHByaW50ZiAoZm9ybWF0X21udCwgb3B0cywgcC0+bW50X2ZzbmFtZSwg
cC0+bW50X2Rpcik7CisgICAgfQogICB9CiAgIGVuZG1udGVudCAobSk7CiAK

------------=_1583532848-65438-95--
