Return-Path: <cygwin-patches-return-7290-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27827 invoked by alias); 4 May 2011 03:09:58 -0000
Received: (qmail 27813 invoked by uid 22791); 4 May 2011 03:09:58 -0000
X-SWARE-Spam-Status: No, hits=0.3 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 04 May 2011 03:09:45 +0000
Received: by iyi20 with SMTP id 20so869000iyi.2        for <cygwin-patches@cygwin.com>; Tue, 03 May 2011 20:09:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.42.99.133 with SMTP id w5mr964415icn.437.1304478584442; Tue, 03 May 2011 20:09:44 -0700 (PDT)
Received: by 10.231.19.200 with HTTP; Tue, 3 May 2011 20:09:44 -0700 (PDT)
Date: Wed, 04 May 2011 03:09:00 -0000
Message-ID: <BANLkTikUJ+opazYOga0URTKj6-6Nw_D+pw@mail.gmail.com>
Subject: initialize local variable wait_return
From: Chiheng Xu <chiheng.xu@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=20cf30223f47a48d7904a26a96a7
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
X-SW-Source: 2011-q2/txt/msg00056.txt.bz2


--20cf30223f47a48d7904a26a96a7
Content-Type: text/plain; charset=UTF-8
Content-length: 15

-- 
Chiheng Xu

--20cf30223f47a48d7904a26a96a7
Content-Type: application/octet-stream; name="1.patch"
Content-Disposition: attachment; filename="1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gn9ow2km0
Content-length: 810

SW5kZXg6IHdpbnN1cC9jeWd3aW4vZmhhbmRsZXIuY2MKPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3
aW4vZmhhbmRsZXIuY2MsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMzgyCmRp
ZmYgLXUgLXAgLXIxLjM4MiBmaGFuZGxlci5jYwotLS0gd2luc3VwL2N5Z3dp
bi9maGFuZGxlci5jYwkzIE1heSAyMDExIDEwOjExOjE5IC0wMDAwCTEuMzgy
CisrKyB3aW5zdXAvY3lnd2luL2ZoYW5kbGVyLmNjCTQgTWF5IDIwMTEgMDI6
NTQ6MjIgLTAwMDAKQEAgLTE3MzEsNyArMTczMSw3IEBAIGZoYW5kbGVyX2Jh
c2Vfb3ZlcmxhcHBlZDo6d2FpdF9vdmVybGFwcGUKICAgaWYgKCFnZXRfb3Zl
cmxhcHBlZCAoKSkKICAgICByZXR1cm4gaW5yZXMgPyBvdmVybGFwcGVkX3N1
Y2Nlc3MgOiBvdmVybGFwcGVkX2Vycm9yOwogCi0gIHdhaXRfcmV0dXJuIHJl
czsKKyAgd2FpdF9yZXR1cm4gcmVzID0gb3ZlcmxhcHBlZF9lcnJvcjsKICAg
RFdPUkQgZXJyID0gR2V0TGFzdEVycm9yICgpOwogICBpZiAobm9uYmxvY2tp
bmcpCiAgICAgewo=

--20cf30223f47a48d7904a26a96a7--
