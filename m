Return-Path: <mara.smetana@gmail.com>
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by sourceware.org (Postfix) with ESMTPS id 99CC0389682A
 for <cygwin-patches@cygwin.com>; Wed, 27 Jan 2021 20:30:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 99CC0389682A
Received: by mail-oi1-x233.google.com with SMTP id w8so3621814oie.2
 for <cygwin-patches@cygwin.com>; Wed, 27 Jan 2021 12:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=80QbWQmLj6hOn+vuqj+zJEFtMN12l82ZR/podfSh8mY=;
 b=efAg6YoaOQJZ0hJNq1EaPsbAnvKQlF5LHNBHR2PBiPunnnlQ8UT+AyyJUwo9XXWRDh
 gpF8IblndgDKFzDjmr0RtUVzVQNGvyqP2dymyEKHZpItb6hwpsHQTUNZ2Mey+Yd5YW4x
 tOlBP4TqJ3hwisriKltllSMhbJ43NUR/9OfYYCMl+pTRIP0GYM3KYLaxkl4NyKdL2i74
 E2NukS154lwfSbrIsTQjmZ29UR2WuA2d1+LyId4oSqOJA/aWNoL8Dfh13GPDNVfkTuBa
 Y4xn08u8Rm+oxDxY68IfObX12HnTQUTMW2LhFwKH/QlM7QfxMEXhvczy0aKl6TvIdFsz
 CAfw==
X-Gm-Message-State: AOAM5314LwjTHz3aPxXzWhZW99M+aUhvfBUJDsdPXjMEFVquoldVqUsj
 r/1Mmhm00Ga4leInJDDRuZKrRJzPF1FodiuZXJGWRzFnhw+IGA==
X-Google-Smtp-Source: ABdhPJznL5pPxzYgXUBLDLpqZ2Zk2YfYr1NEH3HeELqtocNRLruQyWxBSbgH72NXHaF6OvcgW/cRC6tn3x3b6dINDUM=
X-Received: by 2002:a05:6808:20f:: with SMTP id
 l15mr4443032oie.53.1611779422001; 
 Wed, 27 Jan 2021 12:30:22 -0800 (PST)
MIME-Version: 1.0
From: Marek Smetana <mara.smetana@gmail.com>
Date: Wed, 27 Jan 2021 21:30:11 +0100
Message-ID: <CAGEXLhUUtV-kKxO-jQo4427R=N=Uo1aT_LrHGpc1r55umbb92w@mail.gmail.com>
Subject: fhandler_serial.cc: MARK and SPACE parity for serial port
To: cygwin-patches@cygwin.com
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_FROM, GIT_PATCH_0,
 HTML_MESSAGE, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 27 Jan 2021 20:30:25 -0000

Hi,

This patch add MARK and SPACE parity support to serial port

---
 winsup/cygwin/fhandler_serial.cc    | 9 ++++++++-
 winsup/cygwin/include/sys/termios.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_serial.cc
b/winsup/cygwin/fhandler_serial.cc
index fd5b45899..23d69eca5 100644
--- a/winsup/cygwin/fhandler_serial.cc
+++ b/winsup/cygwin/fhandler_serial.cc
@@ -727,7 +727,10 @@ fhandler_serial::tcsetattr (int action, const struct
termios *t)
   /* -------------- Set parity ------------------ */

   if (t->c_cflag & PARENB)
-    state.Parity = (t->c_cflag & PARODD) ? ODDPARITY : EVENPARITY;
+    if(t->c_cflag & CMSPAR)
+      state.Parity = (t->c_cflag & PARODD) ? MARKPARITY : SPACEPARITY;
+    else
+      state.Parity = (t->c_cflag & PARODD) ? ODDPARITY : EVENPARITY;
   else
     state.Parity = NOPARITY;

@@ -1068,6 +1071,10 @@ fhandler_serial::tcgetattr (struct termios *t)
     t->c_cflag |= (PARENB | PARODD);
   if (state.Parity == EVENPARITY)
     t->c_cflag |= PARENB;
+  if (state.Parity == MARKPARITY)
+    t->c_cflag |= (PARENB | PARODD | CMSPAR);
+  if (state.Parity == SPACEPARITY)
+    t->c_cflag |= (PARENB | CMSPAR);

   /* -------------- Parity errors ------------------ */

diff --git a/winsup/cygwin/include/sys/termios.h
b/winsup/cygwin/include/sys/termios.h
index 17e8d83a3..933851c21 100644
--- a/winsup/cygwin/include/sys/termios.h
+++ b/winsup/cygwin/include/sys/termios.h
@@ -185,6 +185,7 @@ POSIX commands */
 #define PARODD 0x00200
 #define HUPCL 0x00400
 #define CLOCAL 0x00800
+#define CMSPAR  0x40000000 /* Mark or space (stick) parity.  */

 /* Extended baud rates above 37K. */
 #define CBAUDEX 0x0100f

---
