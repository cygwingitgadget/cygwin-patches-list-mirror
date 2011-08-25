Return-Path: <cygwin-patches-return-7492-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12558 invoked by alias); 25 Aug 2011 19:06:24 -0000
Received: (qmail 12544 invoked by uid 22791); 25 Aug 2011 19:06:23 -0000
X-SWARE-Spam-Status: Yes, hits=5.7 required=5.0	tests=AWL,BAYES_05,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_YG,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-ww0-f45.google.com (HELO mail-ww0-f45.google.com) (74.125.82.45)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 25 Aug 2011 19:06:09 +0000
Received: by wwg9 with SMTP id 9so2216764wwg.2        for <cygwin-patches@cygwin.com>; Thu, 25 Aug 2011 12:06:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.227.157.81 with SMTP id a17mr87663wbx.75.1314299168430; Thu, 25 Aug 2011 12:06:08 -0700 (PDT)
Received: by 10.227.36.7 with HTTP; Thu, 25 Aug 2011 12:06:08 -0700 (PDT)
Date: Thu, 25 Aug 2011 19:06:00 -0000
Message-ID: <CALqHt2Da1+232daBQOVzsg8emudkpgJL+5tPF5rL4ZSSMT9qsg@mail.gmail.com>
Subject: Overflow cygthreads (those which use simplestub) don't set notify_detached event which may cause timer_delete to hung
From: Rafal Zwierz <rzwierz@googlemail.com>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=0016e65a0700101ab204ab591f0e
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
X-SW-Source: 2011-q3/txt/msg00068.txt.bz2


--0016e65a0700101ab204ab591f0e
Content-Type: text/plain; charset=ISO-8859-1
Content-length: 1215

Hi,

I think that this is a problem in cygthreads, but since I have been
looking at cygwin for less than two weeks I might as well be quite
mistaken.

The problem can be reproduced with Cygwin 1.7.9-1 and also with
today's checkout of the code.

To repro run this program form the attachment (compiled using: g++ main.cc)

One should observe the program hanging when deleting timer. On my
computer it usually is timer 31, but depending on race conditions you
might get a different one. If you don't get the problem then try
increasing TIMERS.

After spending long hours looking at cygwinthread.cc code I have come
up with the following patch to fix the problem. I believe that the
solution should be bullet-proof also if someone terminates the thread
(thread_terminate()) or calls detach(), but since it was the first
time I looked at the cygwin code I might as well be wrong.


* cygthread.cc (cygthread::simplestub): Notify that the thread has
detached also in freerange thread case.


Any comments are most welcome,

Best wishes,
Rafal
P.S. Please note that another (completely separate) problem with
freerange threads leaking memory in auto_release case exists. I will
create another post with info about that.

--0016e65a0700101ab204ab591f0e
Content-Type: text/plain; charset=US-ASCII; name="patch.txt"
Content-Disposition: attachment; filename="patch.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_grs3rfab0
Content-length: 846

SW5kZXg6IHNyYy93aW5zdXAvY3lnd2luL2N5Z3RocmVhZC5jYwo9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3Vw
L2N5Z3dpbi9jeWd0aHJlYWQuY2MsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEu
ODUKZGlmZiAtdSAtcCAtcjEuODUgY3lndGhyZWFkLmNjCi0tLSBzcmMvd2lu
c3VwL2N5Z3dpbi9jeWd0aHJlYWQuY2MJMzAgSnVsIDIwMTEgMjA6NTA6MjMg
LTAwMDAJMS44NQorKysgc3JjL3dpbnN1cC9jeWd3aW4vY3lndGhyZWFkLmNj
CTI1IEF1ZyAyMDExIDE4OjQ0OjMyIC0wMDAwCkBAIC0xMzYsNyArMTM2LDEx
IEBAIGN5Z3RocmVhZDo6c2ltcGxlc3R1YiAoVk9JRCAqYXJnKQogICBjeWd0
aHJlYWQgKmluZm8gPSAoY3lndGhyZWFkICopIGFyZzsKICAgX215X3Rscy5f
Y3RpbmZvID0gaW5mbzsKICAgaW5mby0+c3RhY2tfcHRyID0gJmFyZzsKKyAg
SEFORExFIG5vdGlmeSA9IGluZm8tPm5vdGlmeV9kZXRhY2hlZDsKICAgaW5m
by0+Y2FsbGZ1bmMgKHRydWUpOworICBpZiAobm90aWZ5KSAKKyAgICAgU2V0
RXZlbnQobm90aWZ5KTsKKyAgICAKICAgcmV0dXJuIDA7CiB9CiAK

--0016e65a0700101ab204ab591f0e
Content-Type: application/octet-stream; name="main.cc"
Content-Disposition: attachment; filename="main.cc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_grs3rqi61
Content-length: 1595

I2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1
ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8dGltZS5oPgoKI2RlZmluZSBUSU1F
UlMgNDAKCmludCBtYWluKCkKewogICBzaWdldmVudF90IGV2ZW50OwogICBt
ZW1zZXQoJmV2ZW50LCAwLCBzaXplb2YoZXZlbnQpKTsKCiAgIHRpbWVyX3Qg
dGltZXJpZFtUSU1FUlNdOwogICBtZW1zZXQodGltZXJpZCwgMCwgc2l6ZW9m
KHRpbWVyaWQpKTsKCiAgIHN0cnVjdCBpdGltZXJzcGVjIHZhbHVlOwogICBt
ZW1zZXQoJnZhbHVlLCAwLCBzaXplb2YodmFsdWUpKTsgCgogICBpbnQgaSA9
IDA7CgogICBmb3IgKGkgPSAwOyBpIDwgVElNRVJTOyBpKyspCiAgIHsKICAg
ICAgZXZlbnQuc2lnZXZfbm90aWZ5ID0gU0lHRVZfTk9ORTsKICAgICAgaW50
IHJjID0gdGltZXJfY3JlYXRlKENMT0NLX1JFQUxUSU1FLCAmZXZlbnQsICZ0
aW1lcmlkW2ldKTsKICAgICAgaWYgKDAgIT0gcmMpIAogICAgICB7CiAgICAg
ICAgIHByaW50ZigiQ291bGRuJ3QgY3JlYXRlIHRpbWVyICVkXG4iLCBpKTsK
ICAgICAgICAgcmV0dXJuIDE7CiAgICAgIH0KICAgfQoKICAgZm9yIChpID0g
MDsgaSA8IFRJTUVSUzsgaSsrKSAKICAgewogICAgICB2YWx1ZS5pdF92YWx1
ZS50dl9uc2VjID0gMzIwMDAwMDAwOyAvLyAzMjAgW21zXQogICAgICBpbnQg
cmMgPSB0aW1lcl9zZXR0aW1lKHRpbWVyaWRbaV0sIDAsICZ2YWx1ZSwgTlVM
TCk7CiAgICAgIGlmICgwICE9IHJjKSAKICAgICAgewogICAgICAgICBwcmlu
dGYoIkNvdWxkbid0IHNldCB0aW1lciAlZFxuIiwgaSk7CiAgICAgICAgIHJl
dHVybiAxOwogICAgICB9CiAgIH0KCiAgIHNsZWVwKDEpOyAvLyBnaXZlIGFs
bCB0aGUgdGltZXJzIGEgY2hhbmNlIHRvIGZpcmUKCiAgIGZvciAoaSA9IDA7
IGkgPCBUSU1FUlM7IGkrKykgCiAgIHsKICAgICAgcHJpbnRmKCJEZXN0cm95
aW5nIHRpbWVyICVkLi4uIiwgaSk7IGZmbHVzaChzdGRvdXQpOwogICAgICBp
bnQgcmMgPSB0aW1lcl9kZWxldGUodGltZXJpZFtpXSk7CiAgICAgIHByaW50
ZigiRG9uZVxuIik7CiAgICAgIGlmICgwICE9IHJjKSAKICAgICAgewogICAg
ICAgICBwcmludGYoIkNvdWxkbid0IGRlbGV0ZSB0aW1lciAlZFxuIiwgaSk7
CiAgICAgICAgIHJldHVybiAxOwogICAgICB9CiAgIH0KCiAgIHJldHVybiAw
Owp9CgoK

--0016e65a0700101ab204ab591f0e--
