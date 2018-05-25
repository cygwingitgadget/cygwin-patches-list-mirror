Return-Path: <cygwin-patches-return-9059-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 63430 invoked by alias); 25 May 2018 16:43:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 63415 invoked by uid 89); 25 May 2018 16:43:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.9 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=H*r:sk:b130-v6, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail-oi0-f42.google.com
Received: from mail-oi0-f42.google.com (HELO mail-oi0-f42.google.com) (209.85.218.42) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 25 May 2018 16:43:42 +0000
Received: by mail-oi0-f42.google.com with SMTP id b130-v6so5085355oif.12        for <cygwin-patches@cygwin.com>; Fri, 25 May 2018 09:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20161025;        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;        bh=5Vmlcg7gtWdgN6ZA/bOErEzOc8BKn5hc6nNg99++Gmo=;        b=Ffjxri893PhLRTCCv6kuJQrs7wbNi5d1QdIfEGdZ9KgalXTkjRjEgIJ1bt8HRZ30tk         qFKzaQKKG4KM3v9mowhPM/eSjIkoaPPbnTnq755y3Ri3ZUYWitLEViA3uz/MGn8uiwdn         +5R2bPOcY0H7EiSZqb1UnN5jj2mKJ+f7dJdZuDwzlzIhmzIY2IwJp3iJg0kX0RrY6vhO         9jAOTKo76CPBHE8+5nmq52u1e15SjGDersItcx5UlScySec5rUDacZau0lKF5W8EToQ6         mun+LhgrJojcNaEJukypM/rpH9f6OxAQp3hlE9G3cYCRDgJc4cBmjuMObJOfvw7J7XcQ         nLTg==
X-Gm-Message-State: ALKqPweNhUolKxsiOt9jcYC1WNOgGIGd72Y/Eg+nl0TNUI6X4OVJyuTn	WhK1rEnLdEZ2Y6PGpKvgPQXmBK2NYyg+azg/fgiy/A==
X-Google-Smtp-Source: ADUXVKKJ8Z3i/SySF6QaH8smovP+a00AmsLVK7ghMuDKaLjKAphp9hBDBVbjqdHugxYqrv9dOrp1K+5tGOR/AT9acCs=
X-Received: by 2002:aca:281a:: with SMTP id 26-v6mr1653909oix.37.1527266620519; Fri, 25 May 2018 09:43:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:110d:0:0:0:0:0 with HTTP; Fri, 25 May 2018 09:43:40 -0700 (PDT)
From: Sergejs Lukanihins <slukanihin@gmail.com>
Date: Fri, 25 May 2018 16:43:00 -0000
Message-ID: <CAA9Bwxb2bzBMha_QYRQkVx0pSpY989P7DNM8hikPFeezpn796Q@mail.gmail.com>
Subject: [PATCH] Cygwin: Fixing the math behind rounding down ch.stacklimit to page size
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary="00000000000064e202056d0a78f6"
X-IsSubscribed: yes
X-SW-Source: 2018-q2/txt/msg00016.txt.bz2


--00000000000064e202056d0a78f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-length: 1112

Hello,

Looks like ch.stacklimit wasn't being page-aligned correctly in
fork.cc; you need to subtract 1 from page_size to do it correctly (see
the attached patch).

As a result, this was causing stack-overflow exceptions whenever the
stack needed to grow beyond the stacklimit value. When the stack grows
beyond stacklimit value, Windows uses ntdll!_chkstk() function to
check the stack and map in additional stack pages. However, it expects
stacklimit to be page aligned, and the function does not work
correctly if it is not (it triggers STATUS_STACK_OVERFLOW, even if
there is enough stack space).

Normally, this was not causing any issues, as the stack never really
needs to grow, but it was causing issues when AV software was being
injected into the process (specifically, HitmanPro.Alert being
injected into git=E2=80=99s sh.exe process). Due to function hooks, it lead=
 to
a bigger callstack, and more stack space being required. Making the
change specified in the patch actually resolves the issue.

I am providing my patches to the Cygwin sources under the 2-clause BSD lice=
nse.

Regards,

Sergejs

--00000000000064e202056d0a78f6
Content-Type: application/octet-stream; 
	name="0001-Cygwin-Fixing-the-math-behind-rounding-down-ch.stack.patch"
Content-Disposition: attachment; 
	filename="0001-Cygwin-Fixing-the-math-behind-rounding-down-ch.stack.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jhm73h4j0
Content-length: 1416

RnJvbSBkMTJjYTMwYWIzMzBiNzk3NGM1YTZlMzY3MjY5ZDJmYzM3MWIxYzk1
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBTZXJnZWpzIEx1a2Fu
aWhpbnMgPHNsdWthbmloaW5AZ21haWwuY29tPgpEYXRlOiBGcmksIDI1IE1h
eSAyMDE4IDE3OjI3OjIxICswMTAwClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2lu
OiBGaXhpbmcgdGhlIG1hdGggYmVoaW5kIHJvdW5kaW5nIGRvd24gY2guc3Rh
Y2tsaW1pdCB0bwogcGFnZSBzaXplLgoKLS0tCiB3aW5zdXAvY3lnd2luL2Zv
cmsuY2MgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2Zv
cmsuY2MgYi93aW5zdXAvY3lnd2luL2ZvcmsuY2MKaW5kZXggYmNiZWYxMmQ4
Li5jNmZlZjY3NTUgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vZm9yay5j
YworKysgYi93aW5zdXAvY3lnd2luL2ZvcmsuY2MKQEAgLTMxNiw3ICszMTYs
NyBAQCBmcm9rOjpwYXJlbnQgKHZvbGF0aWxlIGNoYXIgKiB2b2xhdGlsZSBz
dGFja19oZXJlKQogCSBvbiB3aGV0aGVyIHdlJ3JlIHJ1bm5pbmcgb24gYSBw
dGhyZWFkIG9yIG5vdC4gIElmIHB0aHJlYWQsIHdlIGZldGNoCiAJIHRoZSBn
dWFyZHBhZ2Ugc2l6ZSBmcm9tIHRoZSBwdGhyZWFkIGF0dHJpYnMsIG90aGVy
d2lzZSB3ZSB1c2UgdGhlCiAJIHN5c3RlbSBkZWZhdWx0LiAqLwotICAgICAg
Y2guc3RhY2tsaW1pdCA9ICh2b2lkICopICgodWludHB0cl90KSBzdGFja19o
ZXJlICYgfndpbmNhcC5wYWdlX3NpemUgKCkpOworICAgICAgY2guc3RhY2ts
aW1pdCA9ICh2b2lkICopICgodWludHB0cl90KSBzdGFja19oZXJlICYgfih3
aW5jYXAucGFnZV9zaXplICgpIC0gMSkpOwogICAgICAgY2guZ3VhcmRzaXpl
ID0gKCZfbXlfdGxzICE9IF9tYWluX3RscyAmJiBfbXlfdGxzLnRpZCkKIAkJ
ICAgICA/IF9teV90bHMudGlkLT5hdHRyLmd1YXJkc2l6ZQogCQkgICAgIDog
d2luY2FwLmRlZl9ndWFyZF9wYWdlX3NpemUgKCk7Ci0tIAoyLjE3LjAud2lu
ZG93cy4xCgo=

--00000000000064e202056d0a78f6--
