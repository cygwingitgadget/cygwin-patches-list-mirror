Return-Path: <cygwin-patches-return-5292-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28431 invoked by alias); 26 Dec 2004 07:30:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28398 invoked from network); 26 Dec 2004 07:30:16 -0000
Received: from unknown (HELO rproxy.gmail.com) (64.233.170.197)
  by sourceware.org with SMTP; 26 Dec 2004 07:30:16 -0000
Received: by rproxy.gmail.com with SMTP id i8so224850rne
        for <cygwin-patches@cygwin.com>; Sat, 25 Dec 2004 23:30:13 -0800 (PST)
Received: by 10.39.2.55 with SMTP id e55mr417805rni;
        Sat, 25 Dec 2004 23:30:13 -0800 (PST)
Received: by 10.38.89.80 with HTTP; Sat, 25 Dec 2004 23:30:13 -0800 (PST)
Message-ID: <fd80972e04122523307f0a1922@mail.gmail.com>
Date: Sun, 26 Dec 2004 07:30:00 -0000
From: Jeremy Lin <jeremy.lin@gmail.com>
Reply-To: Jeremy Lin <jeremy.lin@gmail.com>
To: cygwin-patches@cygwin.com
Subject: pipe chmod patch
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_249_2754456.1104046213548"
X-SW-Source: 2004-q4/txt/msg00293.txt.bz2

------=_Part_249_2754456.1104046213548
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-length: 268

This trivial patch allows chmod to work on FIFOs. Actually, it doesn't
seem to allow changing mode for group or other, but it's good enough
for my purposes (i.e., to make 'screen' be able to detach/attach). Let
me know if anything needs to be changed.

Thanks,
Jeremy

------=_Part_249_2754456.1104046213548
Content-Type: application/octet-stream; name="fifo.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="fifo.patch"
Content-length: 1184

LS0tIGZoYW5kbGVyLmgub3JpZwkyMDA0LTEyLTI1IDIyOjIwOjIwLjU3Mzc2
ODAwMCAtMDgwMAorKysgZmhhbmRsZXIuaAkyMDA0LTEyLTI1IDIyOjIwOjI4
LjI5NDg3MDQwMCAtMDgwMApAQCAtNDM0LDYgKzQzNCw3IEBACiAgIHNlbGVj
dF9yZWNvcmQgKnNlbGVjdF9leGNlcHQgKHNlbGVjdF9yZWNvcmQgKnMpOwog
ICB2b2lkIHNldF9jbG9zZV9vbl9leGVjIChib29sIHZhbCk7CiAgIHZvaWQg
X19zdGRjYWxsIHJlYWQgKHZvaWQgKnB0ciwgc2l6ZV90JiBsZW4pIF9fYXR0
cmlidXRlX18gKChyZWdwYXJtICgzKSkpOworICBpbnQgX19zdGRjYWxsIGZj
aG1vZCAobW9kZV90IG1vZGUpIF9fYXR0cmlidXRlX18gKChyZWdwYXJtICgx
KSkpOwogICBpbnQgY2xvc2UgKCk7CiAgIHZvaWQgY3JlYXRlX2d1YXJkIChT
RUNVUklUWV9BVFRSSUJVVEVTICpzYSkge2d1YXJkID0gQ3JlYXRlTXV0ZXgg
KHNhLCBGQUxTRSwgTlVMTCk7fQogICBpbnQgZHVwIChmaGFuZGxlcl9iYXNl
ICpjaGlsZCk7Ci0tLSBwaXBlLmNjLm9yaWcJMjAwNC0xMi0yNSAyMjoxOTo0
OS40NjkwNDE2MDAgLTA4MDAKKysrIHBpcGUuY2MJMjAwNC0xMi0yNSAyMzow
MToyNi42MTk3NjgwMDAgLTA4MDAKQEAgLTUzLDYgKzUzLDEzIEBACiAgICAg
c2V0X25vX2luaGVyaXRhbmNlICh3cml0ZXBpcGVfZXhpc3RzLCB2YWwpOwog
fQogCitpbnQgX19zdGRjYWxsCitmaGFuZGxlcl9waXBlOjpmY2htb2QgKG1v
ZGVfdCBtb2RlKQoreworICBleHRlcm4gaW50IGNobW9kX2RldmljZSAocGF0
aF9jb252JiBwYywgbW9kZV90IG1vZGUpOworICByZXR1cm4gY2htb2RfZGV2
aWNlIChwYywgbW9kZSk7Cit9CisKIHN0cnVjdCBwaXBlYXJncwogewogICBm
aGFuZGxlcl9iYXNlICpmaDsK

------=_Part_249_2754456.1104046213548--
