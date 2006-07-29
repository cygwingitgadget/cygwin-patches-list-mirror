Return-Path: <cygwin-patches-return-5948-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17658 invoked by alias); 29 Jul 2006 09:29:35 -0000
Received: (qmail 17642 invoked by uid 22791); 29 Jul 2006 09:29:32 -0000
X-Spam-Check-By: sourceware.org
Received: from jerry.kiev.farlep.net (HELO jerry.kiev.farlep.net) (213.130.24.8)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 29 Jul 2006 09:29:26 +0000
Received: from ilya.kiev.farlep.net ([62.221.47.37]) 	by jerry.kiev.farlep.net with esmtps (TLSv1:AES256-SHA:256) 	(Exim 4.62 (FreeBSD)) 	(envelope-from <ilya@po4ta.com>) 	id 1G6l8M-000Bn7-6T 	for cygwin-patches@cygwin.com; Sat, 29 Jul 2006 12:29:22 +0300
Message-ID: <44CB2A70.9020807@po4ta.com>
Date: Sat, 29 Jul 2006 09:29:00 -0000
From: Ilya <ilya@po4ta.com>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Bug fix and enchantment in cygpath.cc
Content-Type: multipart/mixed;  boundary="------------050609080305060704090300"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00043.txt.bz2

This is a multi-part message in MIME format.
--------------050609080305060704090300
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 339

This patch is against cygpath.cc 1.42.
In 1.43 addressed bug was already fixed, but I believe my fix is a bit 
better.

Current fix just returns filename, in case filename is for a nonexistent 
file.  I think that internal short to long file name conversion routine 
could be used in this case, because it deals ok with nonexistent files.

--------------050609080305060704090300
Content-Type: text/plain;
 name="cygpath.cc.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="cygpath.cc.patch"
Content-length: 1290

LS0tIGN5Z3BhdGguY2Mub3JpZwkyMDA2LTA3LTI3IDEzOjE5OjI5Ljc2NTYy
NTAwMCArMDMwMAorKysgY3lncGF0aC5jYwkyMDA2LTA3LTI3IDE0OjA0OjIw
LjYwOTM3NTAwMCArMDMwMApAQCAtMjM5LDExICsyMzksMjYgQEAgZ2V0X2xv
bmdfbmFtZSAoY29uc3QgY2hhciAqZmlsZW5hbWUsIERXTwogICAgIEdldExv
bmdQYXRoTmFtZSA9IGdldF9sb25nX3BhdGhfbmFtZV93MzJpbXBsOwogCiAg
IGxlbiA9IEdldExvbmdQYXRoTmFtZSAoZmlsZW5hbWUsIGJ1ZiwgTUFYX1BB
VEgpOwotICBpZiAobGVuID09IDAgJiYgR2V0TGFzdEVycm9yICgpID09IEVS
Uk9SX0lOVkFMSURfUEFSQU1FVEVSKQorICBpZiAobGVuID09IDApCiAgICAg
ewotICAgICAgZnByaW50ZiAoc3RkZXJyLCAiJXM6IGNhbm5vdCBjcmVhdGUg
bG9uZyBuYW1lIG9mICVzXG4iLCBwcm9nX25hbWUsCi0JICAgICAgIGZpbGVu
YW1lKTsKLSAgICAgIGV4aXQgKDIpOworICAgICAgRFdPUkQgZXJyID0gR2V0
TGFzdEVycm9yICgpOworCisgICAgICBpZiAoZXJyID09IEVSUk9SX0lOVkFM
SURfUEFSQU1FVEVSKQorCXsKKwkgIGZwcmludGYgKHN0ZGVyciwgIiVzOiBj
YW5ub3QgY3JlYXRlIGxvbmcgbmFtZSBvZiAlc1xuIiwgcHJvZ19uYW1lLAor
CSAgICAgICAJICAgZmlsZW5hbWUpOworCSAgZXhpdCAoMik7CisJfQorICAg
ICAgZWxzZSBpZiAoZXJyID09IEVSUk9SX0ZJTEVfTk9UX0ZPVU5EKQorCXsK
KwkgIGxlbiA9IGdldF9sb25nX3BhdGhfbmFtZV93MzJpbXBsIChmaWxlbmFt
ZSwgYnVmLCBNQVhfUEFUSCk7CisJfQorICAgICAgZWxzZQorCXsKKwkgIGJ1
ZlswXSA9IDA7CisJICBzdHJuY2F0IChidWYsIGZpbGVuYW1lLCBNQVhfUEFU
SCAtIDEpOworCSAgbGVuID0gc3RybGVuIChidWYpOworCX0KICAgICB9CiAg
IHNidWYgPSAoY2hhciAqKSBtYWxsb2MgKGxlbiArIDEpOwogICBpZiAoIXNi
dWYpCg==

--------------050609080305060704090300
Content-Type: text/plain;
 name="ChangeLog"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="ChangeLog"
Content-length: 208

MjAwNi0wNy0wMyAgSWx5YSBCb2JpciAgPGlseWFAcG80dGEuY29tPg0KDQoJ
KiBjeWdwYXRoLmNjIChnZXRfbG9uZ19uYW1lKTogRmFsbGJhY2sgdG8gZ2V0
X2xvbmdfcGF0aF9uYW1lX3czMmltcGwuDQoJUHJvcGVybHkgbnVsbC10ZXJt
aW5hdGUgJ2J1ZicuDQoNCg==

--------------050609080305060704090300--
