Return-Path: <cygwin-patches-return-7125-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29381 invoked by alias); 18 Oct 2010 15:08:14 -0000
Received: (qmail 29358 invoked by uid 22791); 18 Oct 2010 15:08:13 -0000
X-SWARE-Spam-Status: No, hits=-1.3 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from nm6-vm0.bullet.mail.ukl.yahoo.com (HELO nm6-vm0.bullet.mail.ukl.yahoo.com) (217.146.183.234)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 18 Oct 2010 15:08:08 +0000
Received: from [217.146.183.214] by nm6.bullet.mail.ukl.yahoo.com with NNFMP; 18 Oct 2010 15:08:06 -0000
Received: from [217.146.183.41] by tm7.bullet.mail.ukl.yahoo.com with NNFMP; 18 Oct 2010 15:08:05 -0000
Received: from [127.0.0.1] by omp1026.mail.ukl.yahoo.com with NNFMP; 18 Oct 2010 15:08:05 -0000
Received: (qmail 36875 invoked by uid 60001); 18 Oct 2010 15:07:59 -0000
Message-ID: <282260.35125.qm@web25501.mail.ukl.yahoo.com>
Received: from [57.67.164.37] by web25501.mail.ukl.yahoo.com via HTTP; Mon, 18 Oct 2010 16:07:59 BST
Date: Mon, 18 Oct 2010 15:08:00 -0000
From: Marco Atzeri <marco_atzeri@yahoo.it>
Subject: missing math functions
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-506990818-1287414479=:35125"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q4/txt/msg00004.txt.bz2


--0-506990818-1287414479=:35125
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-length: 284

llround and llroundf are available in newlib but not
exported in cygwin.

http://www.cygwin.com/ml/cygwin/2010-10/msg00351.html

simple path attached to solve the problem.

changelog:

*       winsup/cygwin/cygwin.din : added llround and llroundf

Regards
Marco


=20=20=20=20=20=20=

--0-506990818-1287414479=:35125
Content-Type: text/x-diff; name="llround.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="llround.patch"
Content-length: 501

LS0tIHNyYy93aW5zdXAvY3lnd2luL2N5Z3dpbi5kaW4JMjAxMC0xMC0wOCAy
MDoyNTowMC44NzUwMDAwMDAgKzAyMDAKKysrIHNyY19uZXcvd2luc3VwL2N5
Z3dpbi9jeWd3aW4uZGluCTIwMTAtMTAtMTggMTQ6MzE6MzYuNDUzMTI1MDAw
ICswMjAwCkBAIC05NjAsNiArOTYwLDggQEAKIGxscmludCA9IF9mX2xscmlu
dCBOT1NJR0ZFCiBsbHJpbnRmID0gX2ZfbGxyaW50ZiBOT1NJR0ZFCiBsbHJp
bnRsID0gX2ZfbGxyaW50bCBOT1NJR0ZFCitsbHJvdW5kIE5PU0lHRkUKK2xs
cm91bmRmIE5PU0lHRkUKIF9fbG9jYWxlX21iX2N1cl9tYXggTk9TSUdGRQog
bG9jYWxlY29udiBOT1NJR0ZFCiBfbG9jYWxlY29udiA9IGxvY2FsZWNvbnYg
Tk9TSUdGRQo=

--0-506990818-1287414479=:35125--
