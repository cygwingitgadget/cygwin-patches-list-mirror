Return-Path: <cygwin-patches-return-5495-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9685 invoked by alias); 30 May 2005 23:39:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9643 invoked by uid 22791); 30 May 2005 23:39:06 -0000
Received: from pop.gmx.de (HELO mail.gmx.net) (213.165.64.20)
    by sourceware.org (qpsmtpd/0.30-dev) with SMTP; Mon, 30 May 2005 23:39:06 +0000
Received: (qmail 23898 invoked by uid 0); 30 May 2005 23:39:03 -0000
Received: from 84.178.52.37 by www52.gmx.net with HTTP;
	Tue, 31 May 2005 01:39:04 +0200 (MEST)
Date: Mon, 30 May 2005 23:39:00 -0000
From: "Martin Koeppe" <mkoeppe@gmx.de>
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary87681117496344"
Subject: link(2) fails on mounted network shares
X-Authenticated: #449785
Message-ID: <8768.1117496344@www52.gmx.net>
X-Flags: 0001
X-SW-Source: 2005-q2/txt/msg00091.txt.bz2

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary87681117496344
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-length: 799

Hello,

I recently found out that you cannot create hardlinks
on mounted network shares with cygwin
(error: No such file or directory),
but you can do it with the ln.exe from Interix.

So I looked at it and found that the Windows API
function CreateHardLink() causes the trouble, it apparently
only works for local drives.

There is another API function, however, which creates hardlinks
correctly on local and network drives (tested on Win2003 shares
and Samba shares):

MoveFileEx() with parameter:
#define MOVEFILE_CREATE_HARDLINK 16

I have attached a very simple ln program to demonstrate it.
It can be compiled with the MS compiler from
http://msdn.microsoft.com/visualc/vctoolkit2003/

You might consider changing fhandler_disk_file.cc to use
MoveFileEx() instead of CreateHardLink().

Martin
--========GMXBoundary87681117496344
Content-Type: application/octet-stream; name="ln.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ln.c"
Content-length: 1440

CiNpbmNsdWRlIDxzdGRpby5oPgoKCi8vIHdpbm50LmgKI2lmIChkZWZpbmVk
KF9NX01SWDAwMCkgfHwgZGVmaW5lZChfTV9JWDg2KSB8fCBkZWZpbmVkKF9N
X0FMUEhBKSB8fCBkZWZpbmVkKF9NX1BQQykgfHwgZGVmaW5lZChfTV9JQTY0
KSkgJiYgIWRlZmluZWQoTUlETF9QQVNTKQojZGVmaW5lIERFQ0xTUEVDX0lN
UE9SVCBfX2RlY2xzcGVjKGRsbGltcG9ydCkKI2Vsc2UKI2RlZmluZSBERUNM
U1BFQ19JTVBPUlQKI2VuZGlmCgovLyB3aW5iYXNlLmgKI2lmICFkZWZpbmVk
KF9LRVJORUwzMl8pCiNkZWZpbmUgV0lOQkFTRUFQSSBERUNMU1BFQ19JTVBP
UlQKI2Vsc2UKI2RlZmluZSBXSU5CQVNFQVBJCiNlbmRpZgoKI2RlZmluZSBX
SU5BUEkgX19zdGRjYWxsCgp0eXBlZGVmIGludCAgICAgICAgICAgICBCT09M
Owp0eXBlZGVmIHVuc2lnbmVkIGxvbmcgICBEV09SRDsKdHlwZWRlZiBjb25z
dCB3Y2hhcl90KiAgTFBDV1NUUjsKCgpXSU5CQVNFQVBJCkJPT0wKV0lOQVBJ
Ck1vdmVGaWxlRXhXKAogICAgTFBDV1NUUiBscEV4aXN0aW5nRmlsZU5hbWUs
CiAgICBMUENXU1RSIGxwTmV3RmlsZU5hbWUsCiAgICBEV09SRCBkd0ZsYWdz
Cik7CgkJCQpXSU5CQVNFQVBJCkRXT1JECldJTkFQSQpHZXRMYXN0RXJyb3Io
dm9pZCk7CgojZGVmaW5lIE1PVkVGSUxFX0NSRUFURV9IQVJETElOSyAgICAg
ICAgMHgwMDAwMDAxMAoKaW50IHdtYWluKGludCBhcmdjLCB3Y2hhcl90KiBh
cmd2W10pCnsKICAgIEJPT0wgcmVzOwogICAgRFdPUkQgZXJyOwoKICAgIGlm
IChhcmdjICE9IDMpIHsKCXdwcmludGYoTCJVc2FnZTogbG4gZXhpdGluZ19m
aWxlIG5ld19maWxlXG4iKTsKCXJldHVybiAyOwogICAgfQoKICAgIHJlcyA9
IE1vdmVGaWxlRXhXKGFyZ3ZbMV0sIGFyZ3ZbMl0sIE1PVkVGSUxFX0NSRUFU
RV9IQVJETElOSyk7ICAgIAogICAgZXJyID0gR2V0TGFzdEVycm9yKCk7CiAg
ICB3cHJpbnRmKEwiTW92ZUZpbGVFeFcoKSA9ICVkLCBHZXRMYXN0RXJyb3Io
KSA9ICVsdVxuIiwgcmVzLCBlcnIpOwogICAgCiAgICBpZiAoISByZXMpIHJl
dHVybiAxOwoKICAgIHJldHVybiAwOwp9Cg==

--========GMXBoundary87681117496344--
