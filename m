Return-Path: <cygwin-patches-return-6034-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21757 invoked by alias); 8 Mar 2007 23:06:39 -0000
Received: (qmail 21746 invoked by uid 22791); 8 Mar 2007 23:06:38 -0000
X-Spam-Check-By: sourceware.org
Received: from SMT02001.global-sp.net (HELO SMT02001.global-sp.net) (193.168.50.54)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 08 Mar 2007 23:06:33 +0000
Received: from [192.168.100.1] (mna75-8-82-234-66-240.fbx.proxad.net [82.234.66.240]) 	by SMT02001.global-sp.net (Postfix) with ESMTP id 8C976376842 	for <cygwin-patches@cygwin.com>; Fri,  9 Mar 2007 00:05:47 +0100 (CET)
Date: Thu, 08 Mar 2007 23:06:00 -0000
From: Christophe GRENIER <grenier@cgsecurity.org>
To: cygwin-patches@cygwin.com
Subject: Bug in pread/pwrite ?
Message-ID: <Pine.LNX.4.64.0703082349050.17686@adsl.cgsecurity.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-110925216-1173395147=:17686"
X-global-asp-net-MailScanner: Found to be clean
X-global-asp-net-MailScanner-SpamCheck:
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00015.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-110925216-1173395147=:17686
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-length: 1377

Hi,

After upgrading my compiler from cygwin 1.5.17-1 to 1.5.24-2,
TestDisk & PhotoRec, my GPL data recovery programs, were
unable to read data!

I have written a little program (see attachment) to reproduce
the problem. As administrator, run "test_pread /dev/sda".

The program use lseek() to go the disk end, the function failed.
Now pread will now always failed, because it ends
(cf cygwin-1.5.24-2/newlib/libc/unix/pread.c) by
an lseek to the backuped location. The same problem also applies
to pwrite.

I don't know if the following patch is a good idea:

--- cygwin-1.5.24-2/newlib/libc/unix/pread.org.c  2002-05-06 22:29:28.000000000 +0200
+++ cygwin-1.5.24-2/newlib/libc/unix/pread.c      2007-03-08 23:37:34.000000000 +0100
@@ -70,8 +70,7 @@ _DEFUN (_pread_r, (rptr, fd, buf, n, off

    num_read = _read_r (rptr, fd, buf, n);

-  if (_lseek_r (rptr, fd, cur_pos, SEEK_SET) == (off_t)-1)
-    return -1;
+  _lseek_r (rptr, fd, cur_pos, SEEK_SET);

    return (ssize_t)num_read;
  }

Regards,

 	Christophe

-- 
    ,-~~-.___.     ._.
   / |  '     \    | |"""""""""|   Christophe GRENIER
  (  )         0   | |         | grenier@cgsecurity.org
   \_/-, ,----'    | |         |
      ====         !_!--v---v--"
      /  \-'~;      |""""""""|   TestDisk & PhotoRec
     /  __/~| ._-""||        |   Data Recovery
   =(  _____|_|____||________|   http://www.cgsecurity.org
--8323328-110925216-1173395147=:17686
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=test_pread.c
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0703090005470.17686@adsl.cgsecurity.org>
Content-Description: 
Content-Disposition: attachment; filename=test_pread.c
Content-length: 2009

I2luY2x1ZGUgPHN5cy90eXBlcy5oPg0KI2luY2x1ZGUgPHVuaXN0ZC5oPg0K
I2luY2x1ZGUgPHN5cy90eXBlcy5oPg0KI2luY2x1ZGUgPHN5cy9zdGF0Lmg+
DQojaW5jbHVkZSA8ZmNudGwuaD4NCiNpbmNsdWRlIDxzdGRpby5oPg0KDQpp
bnQgbWFpbihpbnQgYXJnYywgY2hhcioqYXJndikNCnsNCiAgdW5zaWduZWQg
Y2hhciBidWZmZXJbNTEyXTsNCiAgaW50IGZpbGRlczsNCiAgLyogVXNlIGEg
YmlnZ2VyIHZhbHVlIGlmIHlvdXIgSEQgaXMgYmlnZ2VyIHRoYW4gMSBUQiAq
Lw0KICBvZmZfdCB0b29fZmFyPShvZmZfdCkxMDI0KjEwMjQqMTAyNCoxMDI0
Ow0KICBpZihhcmdjPT0xKQ0KICB7DQogICAgcHJpbnRmKCIlcyBkZXZpY2Vf
dG9fcmVhZFxuIiwgYXJndlsxXSk7DQogICAgcHJpbnRmKCJpZTogJXMgL2Rl
di9zZGFcbiIsIGFyZ3ZbMV0pOw0KICAgIHJldHVybiAxOw0KICB9DQogIGZp
bGRlcz1vcGVuKGFyZ3ZbMV0sIE9fUkRPTkxZfE9fQklOQVJZKTsNCiAgaWYo
ZmlsZGVzPT0tMSkNCiAgew0KICAgIHByaW50ZigiQ2FuJ3QgcmVhZCAlc1xu
IiwgYXJndlsxXSk7DQogIH0NCiAgew0KICAgIC8qIFRlc3QgMSovDQogICAg
cHJpbnRmKCJsc2VlayAwIChzaG91bGQgYmUgT0spOiAiKTsNCiAgICBpZihs
c2VlayhmaWxkZXMsIDAsIFNFRUtfU0VUKT09KG9mZl90KSgtMSkpDQogICAg
ew0KICAgICAgcHJpbnRmKCJGYWlsZWRcbiIpOw0KICAgICAgcmV0dXJuIDE7
DQogICAgfQ0KICAgIGVsc2UNCiAgICAgIHByaW50ZigiT0tcbiIpOw0KICAg
IC8qIFRlc3QgMiovDQogICAgcHJpbnRmKCJwcmVhZCAwIChzaG91bGQgYmUg
T0spOiAiKTsNCiAgICBpZihwcmVhZChmaWxkZXMsIGJ1ZmZlciwgNTEyLCAw
KT09KC0xKSkNCiAgICB7DQogICAgICBwcmludGYoIkZhaWxlZFxuIik7DQog
ICAgICByZXR1cm4gMTsNCiAgICB9DQogICAgZWxzZQ0KICAgICAgcHJpbnRm
KCJPS1xuIik7DQogICAgLyogVGVzdCAzOiBHbyBhdCB0aGUgZW5kIG9mIHRo
ZSBkaXNrICovDQogICAgcHJpbnRmKCJsc2VlayBhZnRlciB0aGUgZW5kIG9m
IHRoZSBkaXNrIChzaG91bGQgYmUgRmFpbGVkKTogIik7DQogICAgaWYobHNl
ZWsoZmlsZGVzLCB0b29fZmFyLCBTRUVLX1NFVCk9PShvZmZfdCkoLTEpKQ0K
ICAgICAgcHJpbnRmKCJGYWlsZWRcbiIpOw0KICAgIGVsc2UNCiAgICB7DQog
ICAgICBwcmludGYoIk9LXG4iKTsNCiAgICAgIHByaW50ZigiWW91IG11c3Qg
dXNlIGEgZGV2aWNlLCBub3QgYSBmaWxlXG4iKTsNCiAgICAgIHJldHVybiAx
Ow0KICAgIH0NCiAgICAvKiBUZXN0IDQqLw0KICAgIHByaW50ZigicHJlYWQg
MCAoc2hvdWxkIGJlIE9LKTogIik7DQogICAgaWYocHJlYWQoZmlsZGVzLCBi
dWZmZXIsIDUxMiwgMCk9PSgtMSkpDQogICAgICBwcmludGYoIkZhaWxlZCA8
PSBCVUdcbiIpOw0KICAgIGVsc2UNCiAgICAgIHByaW50ZigiT0tcbiIpOw0K
ICAgIGNsb3NlKGZpbGRlcyk7DQogIH0NCiAgcmV0dXJuIDA7DQp9DQo=

--8323328-110925216-1173395147=:17686--
