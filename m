Return-Path: <mara.smetana@gmail.com>
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by sourceware.org (Postfix) with ESMTPS id D91AC386197F
 for <cygwin-patches@cygwin.com>; Fri, 29 Jan 2021 22:06:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D91AC386197F
Received: by mail-ej1-x634.google.com with SMTP id g3so15118484ejb.6
 for <cygwin-patches@cygwin.com>; Fri, 29 Jan 2021 14:06:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:references:from:to:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=WbmkHLwMAAPRJDstWFWHMV3xqtDx4B+1x2zg8THYWxA=;
 b=CKpl3RX4Fw8PEiG2wU6ZMSTnmsDxKBL4ZeQ1+XxB4+8Iyr2Enw1Unfwk7cRCGpHvUc
 2TcacLwwRB2vLx/UC7FZsFWTgU9MiFFrnfAjo5bohEBLJ+sqEhQjqqVEbHDDv8jZD4lH
 fJ2z1jGgoM8So9LLTRosgRySlERe3IB6KKFgCtf/jHsqsVL8GYs4Utq5YhAll/KgUxwx
 WRt9wOUtqH+LtoFCJB5YciVjn0WwJcpBGI1T8CyAmxVyTvOKHUzE09Y72KD2Cgji7RJr
 dUQ4EQeEJAcWF/UyWP9hLERoBusAvF/Qi7TyH/+z9DGzE2ka28p56iwAiAk9Be/ukIaA
 VvqQ==
X-Gm-Message-State: AOAM5314I9k0fiJcA34LlGEtR75Qq4WOigQAIB/vyfgsvh6Jf+BrW9cV
 6BVXMOChKGcqhVZHdJA+0ezpI9WObik+Bg==
X-Google-Smtp-Source: ABdhPJz+b2YcNb+FVVY3p/6K0TBuaYV9KjRA2jplYaMFGYexrMuTQloOgGIFlpY9G0du6sLw3VEaPA==
X-Received: by 2002:a17:907:1050:: with SMTP id
 oy16mr6456584ejb.424.1611957993026; 
 Fri, 29 Jan 2021 14:06:33 -0800 (PST)
Received: from [192.168.2.166] ([188.120.201.247])
 by smtp.gmail.com with ESMTPSA id gj9sm4384281ejb.107.2021.01.29.14.06.31
 for <cygwin-patches@cygwin.com>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Jan 2021 14:06:32 -0800 (PST)
Subject: fhandler_serial.cc: MARK and SPACE parity for serial port
References: <CAGEXLhUUtV-kKxO-jQo4427R=N=Uo1aT_LrHGpc1r55umbb92w@mail.gmail.com>
 <20210128100802.GW4393@calimero.vinschen.de>
 <20210128101429.GX4393@calimero.vinschen.de>
From: Marek Smetana <mara.smetana@gmail.com>
To: cygwin-patches@cygwin.com
Message-ID: <4d88d636-8274-5dea-67f8-f224a63b49a9@gmail.com>
Date: Fri, 29 Jan 2021 23:06:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210128101429.GX4393@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------787BBEA552C764FCD6D4510A"
Content-Language: cs
X-Spam-Status: No, score=-13.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_FROM, GIT_PATCH_0,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
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
X-List-Received-Date: Fri, 29 Jan 2021 22:06:35 -0000

This is a multi-part message in MIME format.
--------------787BBEA552C764FCD6D4510A
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I have modified the patch as recommended and am sending it as an attachment.

The CMSPAR value is the same as in "asm / termbits.h" on Linux.

Patches  sent by me are licensed under the 2-clause BSD license.

Best regards

Marek



--------------787BBEA552C764FCD6D4510A
Content-Type: text/plain; charset=UTF-8;
 name="serial_parity.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="serial_parity.patch"

 winsup/cygwin/fhandler_serial.cc    | 11 ++++++++++-
 winsup/cygwin/include/sys/termios.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git c/winsup/cygwin/fhandler_serial.cc w/winsup/cygwin/fhandler_serial.cc
index fd5b45899..e0257302c 100644
--- c/winsup/cygwin/fhandler_serial.cc
+++ w/winsup/cygwin/fhandler_serial.cc
@@ -727,7 +727,12 @@ fhandler_serial::tcsetattr (int action, const struct termios *t)
   /* -------------- Set parity ------------------ */
 
   if (t->c_cflag & PARENB)
-    state.Parity = (t->c_cflag & PARODD) ? ODDPARITY : EVENPARITY;
+    {
+      if(t->c_cflag & CMSPAR)
+        state.Parity = (t->c_cflag & PARODD) ? MARKPARITY : SPACEPARITY;
+      else
+        state.Parity = (t->c_cflag & PARODD) ? ODDPARITY : EVENPARITY;
+    }
   else
     state.Parity = NOPARITY;
 
@@ -1068,6 +1073,10 @@ fhandler_serial::tcgetattr (struct termios *t)
     t->c_cflag |= (PARENB | PARODD);
   if (state.Parity == EVENPARITY)
     t->c_cflag |= PARENB;
+  if (state.Parity == MARKPARITY)
+    t->c_cflag |= (PARENB | PARODD | CMSPAR);
+  if (state.Parity == SPACEPARITY)
+    t->c_cflag |= (PARENB | CMSPAR);
 
   /* -------------- Parity errors ------------------ */
 
diff --git c/winsup/cygwin/include/sys/termios.h w/winsup/cygwin/include/sys/termios.h
index 17e8d83a3..e4465fca3 100644
--- c/winsup/cygwin/include/sys/termios.h
+++ w/winsup/cygwin/include/sys/termios.h
@@ -206,6 +206,7 @@ POSIX commands */
 
 #define CRTSXOFF 0x04000
 #define CRTSCTS	 0x08000
+#define CMSPAR	 0x40000000 /* Mark or space (stick) parity.  */
 
 /* lflag bits */
 #define ISIG	0x0001

--------------787BBEA552C764FCD6D4510A--
