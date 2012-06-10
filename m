Return-Path: <cygwin-patches-return-7675-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26083 invoked by alias); 10 Jun 2012 18:19:33 -0000
Received: (qmail 26073 invoked by uid 22791); 10 Jun 2012 18:19:32 -0000
X-SWARE-Spam-Status: No, hits=-5.2 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-vb0-f43.google.com (HELO mail-vb0-f43.google.com) (209.85.212.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 10 Jun 2012 18:19:05 +0000
Received: by vbbfq11 with SMTP id fq11so1946571vbb.2        for <cygwin-patches@cygwin.com>; Sun, 10 Jun 2012 11:19:05 -0700 (PDT)
Received: by 10.220.9.10 with SMTP id j10mr11126363vcj.7.1339352344903;        Sun, 10 Jun 2012 11:19:04 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id c17sm17536319vdj.11.2012.06.10.11.19.03        (version=TLSv1/SSLv3 cipher=OTHER);        Sun, 10 Jun 2012 11:19:04 -0700 (PDT)
Message-ID: <4FD4E519.7000508@users.sourceforge.net>
Date: Sun, 10 Jun 2012 18:19:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: elf.h incomplete
References: <4FA281E3.4020008@samsung.com> <CA+sc5mnHw0CuSzaPiAV4ALQVEKs6_Nc20JrEvu-r121nZU3REg@mail.gmail.com> <4FA2870D.1030604@samsung.com> <4FA28961.2010407@cs.utoronto.ca> <4FA28F35.6060000@samsung.com> <4FA29070.1060300@gmail.com> <20120503152458.GB22355@ednor.casa.cgf.cx> <4FA300AB.3080306@users.sourceforge.net> <4FCED256.7030305@users.sourceforge.net> <20120606035249.GA22752@ednor.casa.cgf.cx>
In-Reply-To: <20120606035249.GA22752@ednor.casa.cgf.cx>
Content-Type: multipart/mixed; boundary="------------040809010501080005070800"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q2/txt/msg00044.txt.bz2

This is a multi-part message in MIME format.
--------------040809010501080005070800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 428

On 2012-06-05 22:52, Christopher Faylor wrote:
> Sounds like it is good enough to check in.  We can tweak it as needed.

That didn't take long. :-)  I had been testing with 3.3.7; the attached 
additional defines are needed for building the 3.4.y kernels.  These 
defines are from LLVM (llvm/Support/ELF.h), which is under NCSA (variant 
of 3-clause BSD).  (Many more defines are available there as well, if 
needed.)


Yaakov


--------------040809010501080005070800
Content-Type: application/x-itunes-itlp;
 name="elf-h-linux34.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="elf-h-linux34.patch"
Content-length: 1444

MjAxMi0wNi0xMCAgWWFha292IFNlbGtvd2l0eiAgPHlzZWxrb3dpdHpALi4u
PgoKCSogaW5jbHVkZS9zeXMvZWxmX2NvbW1vbi5oIChSXzM4Nl8xNik6IERl
ZmluZS4KCShSXzM4Nl9QQzE2KTogRGVmaW5lLgoJKFJfMzg2XzgpOiBEZWZp
bmUuCgkoUl8zODZfUEM4KTogRGVmaW5lLgoKSW5kZXg6IGluY2x1ZGUvc3lz
L2VsZl9jb21tb24uaAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09ClJDUyBmaWxl
OiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL3N5cy9lbGZf
Y29tbW9uLmgsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMwpkaWZmIC11IC1w
IC1yMS4zIGVsZl9jb21tb24uaAotLS0gaW5jbHVkZS9zeXMvZWxmX2NvbW1v
bi5oCTYgSnVuIDIwMTIgMDQ6NDU6NDggLTAwMDAJMS4zCisrKyBpbmNsdWRl
L3N5cy9lbGZfY29tbW9uLmgJMTAgSnVuIDIwMTIgMTg6MTA6NTAgLTAwMDAK
QEAgLTYwMyw2ICs2MDMsMTAgQEAgdHlwZWRlZiBzdHJ1Y3QgewogI2RlZmlu
ZQlSXzM4Nl9UTFNfTEUJCTE3CS8qIE5lZ2F0aXZlIG9mZnNldCByZWxhdGl2
ZSB0byBzdGF0aWMgVExTICovCiAjZGVmaW5lCVJfMzg2X1RMU19HRAkJMTgJ
LyogMzIgYml0IG9mZnNldCB0byBHT1QgKGluZGV4LG9mZikgcGFpciAqLwog
I2RlZmluZQlSXzM4Nl9UTFNfTERNCQkxOQkvKiAzMiBiaXQgb2Zmc2V0IHRv
IEdPVCAoaW5kZXgsemVybykgcGFpciAqLworI2RlZmluZQlSXzM4Nl8xNgkJ
MjAKKyNkZWZpbmUJUl8zODZfUEMxNgkJMjEKKyNkZWZpbmUJUl8zODZfOAkJ
CTIyCisjZGVmaW5lCVJfMzg2X1BDOAkJMjMKICNkZWZpbmUJUl8zODZfVExT
X0dEXzMyCQkyNAkvKiAzMiBiaXQgb2Zmc2V0IHRvIEdPVCAoaW5kZXgsb2Zm
KSBwYWlyICovCiAjZGVmaW5lCVJfMzg2X1RMU19HRF9QVVNICTI1CS8qIHB1
c2hsIGluc3RydWN0aW9uIGZvciBTdW4gQUJJIEdEIHNlcXVlbmNlICovCiAj
ZGVmaW5lCVJfMzg2X1RMU19HRF9DQUxMCTI2CS8qIGNhbGwgaW5zdHJ1Y3Rp
b24gZm9yIFN1biBBQkkgR0Qgc2VxdWVuY2UgKi8K

--------------040809010501080005070800--
