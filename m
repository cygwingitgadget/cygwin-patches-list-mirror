Return-Path: <cygwin-patches-return-7192-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1718 invoked by alias); 10 Feb 2011 16:11:28 -0000
Received: (qmail 1667 invoked by uid 22791); 10 Feb 2011 16:11:24 -0000
X-SWARE-Spam-Status: No, hits=-1.1 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_EG,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-pv0-f171.google.com (HELO mail-pv0-f171.google.com) (74.125.83.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 10 Feb 2011 16:11:18 +0000
Received: by pvg2 with SMTP id 2so338972pvg.2        for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2011 08:11:17 -0800 (PST)
Received: by 10.142.213.18 with SMTP id l18mr20026133wfg.192.1297354276735;        Thu, 10 Feb 2011 08:11:16 -0800 (PST)
Received: from [192.168.1.2] ([183.106.96.22])        by mx.google.com with ESMTPS id c3sm206339wfa.2.2011.02.10.08.11.14        (version=SSLv3 cipher=OTHER);        Thu, 10 Feb 2011 08:11:15 -0800 (PST)
Message-ID: <4D540ED9.2020907@gmail.com>
Date: Thu, 10 Feb 2011 16:11:00 -0000
From: jojelino <jojelino@gmail.com>
User-Agent: Mozilla/5.0 (Windows NT 5.2; rv:2.0b12pre) Gecko/20110209 Thunderbird/3.3a3pre
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] for SIGSEGV, compilation error in gcc 4.6
References: <AANLkTinBrYcRrRBztY5eKWzon02GtB4t3S5BcLVoA_+D@mail.gmail.com> <20110210100236.GD2305@calimero.vinschen.de> <4D53DE66.2080805@gmail.com> <20110210141515.GB25992@calimero.vinschen.de> <20110210142933.GA29161@calimero.vinschen.de> <4D53FCB4.30404@gmail.com> <20110210153253.GC26842@ednor.casa.cgf.cx>
In-Reply-To: <20110210153253.GC26842@ednor.casa.cgf.cx>
Content-Type: multipart/mixed; boundary="------------040506040403010709050209"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00047.txt.bz2

This is a multi-part message in MIME format.
--------------040506040403010709050209
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 498

On 2011-02-11 AM 12:32, Christopher Faylor wrote:

>> -void __stdcall
>> +void __stdcall __attribute__ ((regparm (1), noreturn))
>> do_exit (int status)
>> {

no. it doesn't fix sigsegv, but for compilation error in 4.6.
to summerize, all changes of function definition fixes compilation error 
in gcc 4.6(trunk) and it doesn't fix sigsegv.
fixing sigsegv is done by adding __stdcall to *findenv_func type. and it 
doesn't fix compilation error in 4.6.
it was missing in changelog. so it was added

--------------040506040403010709050209
Content-Type: text/plain;
 name="ChangeLog"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ChangeLog"
Content-length: 3449

MjAxMS0wMi0xMCAgICA8P0A/PgoKCSogZW52aXJvbi5jYyAoZ2V0d2luZW52
LGdldHdpbmVudmVxLGJ1aWxkX2Vudik6QWRkIF9fYXR0cmlidXRlX18gKChy
ZWdwYXJtICh4KSkpIGluIGZ1bmN0aW9uIGRlZmluaXRpb24uCgkocGZuZW52
KTpEZWZpbmUuIG1ha2Ugc3VyZSBfX3N0ZGNhbGwgaXMgYWRkZWQuCgkoZmlu
ZGVudl9mdW5jKTogcmVwbGFjZSBmdW5jdGlvbiBwb2ludGVyIGRlY2xhcmF0
aW9uIHRvIGFib3ZlLgoJCXVzZSBpdCBmb3IgY2FzdGluZyBnZXRlYXJseS4g
Zml4ZXMgc2VnbWVudGF0aW9uIGZhdWx0IGluIGdjYyA0LjYKCShlbnZpcm9u
X2luaXQpOmRvIHRoZSBzYW1lIGFzIGFib3ZlIGZvciBteV9maW5kZW52LgoJ
CgkqIHN5c2NhbGxzLmNjIChzdGF0X3dvcmtlcik6QWRkIF9fYXR0cmlidXRl
X18gKChyZWdwYXJtICh4KSkpIGluIGZ1bmN0aW9uIGRlZmluaXRpb24uCgoJ
KiB3aW5kb3cuY2MgKHdpbmluZm86OnByb2Nlc3MscHJvY2Vzc193aW5kb3df
ZXZlbnRzLHdpbmluZm86OndpbnRocmVhZCk6RGl0dG8uCgkKCSogc3RyZnVu
Y3MuY2MgKHN5c19jcF93Y3N0b21icyxzeXNfd2NzdG9tYnMsc3lzX3djc3Rv
bWJzX2FsbG9jLHN5c19jcF9tYnN0b3djcyxzeXNfbWJzdG93Y3Msc3lzX21i
c3Rvd2NzX2FsbG9jKTpEaXR0by4KCgkqIHNwYXduLmNjIChmaW5kX2V4ZWMp
OkRpdHRvLgoKCSogc2lncHJvYy5jYyAocGlkX2V4aXN0cyxwcm9jX3N1YnBy
b2Msc2lnX2NsZWFyLHNpZ19zZW5kLGNoZWNrc3RhdGUpOkRpdHRvLgoKCSog
c2lnbmFsLmNjIChoYW5kbGVfc2lncHJvY21hc2ssX3BpbmZvOjpraWxsKTpE
aXR0by4KCgkqIHNlY19oZWxwZXIuY2MgKF9fc2VjX3VzZXIpOkRpdHRvLgoK
CSogcGlwZS5jYyAoZmhhbmRsZXJfcGlwZTo6ZnN0YXR2ZnMpOkRpdHRvLgoK
CSogcGluZm8uY2MgKF9waW5mbzo6ZXhpc3RzKTpEaXR0by4KCgkqIHBhdGgu
Y2MgKG1rcmVscGF0aCxub2ZpbmFsc2xhc2gsaGFzaF9wYXRoX25hbWUpOkRp
dHRvLgoKCSogbnRlYS5jYyAocmVhZF9lYSx3cml0ZV9lYSk6RGl0dG8uCgoJ
KiBtaXNjZnVuY3MuY2MgKGNoZWNrX2ludmFsaWRfdmlydHVhbF9hZGRyKTpE
aXR0by4KCgkqIGZoYW5kbGVyX3plcm8uY2MgKGZoYW5kbGVyX2Rldl96ZXJv
OjpyZWFkKTpEaXR0by4KCgkqIGZoYW5kbGVyX3dpbmRvd3MuY2MgKGZoYW5k
bGVyX3dpbmRvd3M6OnJlYWQpOkRpdHRvLgoKCSogZmhhbmRsZXJfdmlydHVh
bC5jYyAoZmhhbmRsZXJfdmlydHVhbDo6KHJlYWQsZnN0YXR2ZnMpKTpEaXR0
by4KCgkqIGZoYW5kbGVyX3R0eS5jYyAoZmhhbmRsZXJfdHR5X3NsYXZlOjoo
cmVhZCxmc3RhdCxmY2htb2QsZmNob3duKSxmaGFuZGxlcl9wdHlfbWFzdGVy
OjpyZWFkKTpEaXR0by4KCgkqIGZoYW5kbGVyX3NvY2tldC5jYyAoZmhhbmRs
ZXJfc29ja2V0OjooZnN0YXQsZnN0YXR2ZnMpKTpEaXR0by4KCgkqIGZoYW5k
bGVyX3Jhdy5jYyAoZmhhbmRsZXJfZGV2X3Jhdzo6ZnN0YXQpOkRpdHRvLgoK
CSogZmhhbmRsZXJfcmFuZG9tLmNjIChmaGFuZGxlcl9kZXZfcmFuZG9tOjpy
ZWFkKTpEaXR0by4KCgkqIGZoYW5kbGVyX3Byb2NzeXMuY2MgKGZoYW5kbGVy
X3Byb2NzeXM6OnJlYWQpOkRpdHRvLgoKCSogZmhhbmRsZXJfbWVtLmNjIChm
aGFuZGxlcl9kZXZfbWVtOjpyZWFkKTpEaXR0by4KCgkqIGZoYW5kbGVyX21h
aWxzbG90LmNjIChmaGFuZGxlcl9tYWlsc2xvdDo6ZnN0YXQpOkRpdHRvLgoK
CSogZmhhbmRsZXJfZmlmby5jYyAoZmhhbmRsZXJfZmlmbzo6ZnN0YXR2ZnMp
OkRpdHRvLgoKCSogZmhhbmRsZXJfZHNwLmNjIChmaGFuZGxlcl9kZXZfZHNw
OjpyZWFkKTpEaXR0by4KCgkqIGZoYW5kbGVyX2Rpc2tfZmlsZS5jYyAoZmhh
bmRsZXJfYmFzZTo6KGZzdGF0X2J5X25mc19lYSxmc3RhdF9ieV9oYW5kbGUs
ZnN0YXRfYnlfbmFtZSxmc3RhdF9mcyxmc3RhdF9oZWxwZXIpLGZoYW5kbGVy
X2Rpc2tfZmlsZTo6KGZzdGF0LGZzdGF0dmZzLGZjaG1vZCxmY2hvd24sZmFj
bCxwcmVhZCxwd3JpdGUpLHJlYWRkaXJfZ2V0X2lubyk6RGl0dG8uCgoJKiBm
aGFuZGxlcl9jb25zb2xlLmNjIChmaGFuZGxlcl9jb25zb2xlOjpyZWFkKTpE
aXR0by4KCgkqIGZoYW5kbGVyX2NsaXBib2FyZC5jYyAoZmhhbmRsZXJfZGV2
X2NsaXBib2FyZDo6cmVhZCk6RGl0dG8uCgoJKiBmaGFuZGxlci5jYyAoZmhh
bmRsZXJfYmFzZTo6KHJlYWQscHJlYWQscHdyaXRlLGZzdGF0LGZzdGF0dmZz
KSxmaGFuZGxlcl9iYXNlX292ZXJsYXBwZWQ6OnJlYWRfb3ZlcmxhcHBlZCk6
RGl0dG8uCgoJKiBleGNlcHRpb25zLmNjIChydGxfdW53aW5kLF9jeWd0bHM6
OmludGVycnVwdF9zZXR1cCxzaWdwYWNrZXQ6OnByb2Nlc3MpOkRpdHRvLgoK
CSogZXJybm8uY2MgKGdldGVycm5vX2Zyb21fd2luX2Vycm9yLHNldGVycm5v
X2Zyb21fd2luX2Vycm9yLHNldGVycm5vX2Zyb21fbnRfc3RhdHVzLHNldGVy
cm5vKTpEaXR0by4KCgkqIGRlYnVnLmNjIChtb2RpZnlfaGFuZGxlLGFkZF9o
YW5kbGUsY2xvc2VfaGFuZGxlKTpEaXR0by4KCQoJKiBkY3J0MC5jYyAoZG9f
ZXhpdCxjeWdiZW5jaCk6RGl0dG8uCgo=

--------------040506040403010709050209--
