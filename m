Return-Path: <david.macek.0@gmail.com>
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by sourceware.org (Postfix) with ESMTPS id 04ACD3858D31
 for <cygwin-patches@cygwin.com>; Mon, 20 Apr 2020 16:29:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 04ACD3858D31
Received: by mail-wr1-x430.google.com with SMTP id i10so12941302wrv.10
 for <cygwin-patches@cygwin.com>; Mon, 20 Apr 2020 09:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-transfer-encoding;
 bh=es5hk36d6vVtm5hM3Ys2niwEDk8VdCdiYzKi/LFgXHk=;
 b=dIsRFf4sJoZPpS+rQPPSju4xNGcz7cmYW80mAPgsFu0CDFaEzG/qwWJm+xyRqSytDY
 tueAf9Dc6WjErWxH7o7Ec6BBiNozIYBVnmdQcg4QE9c1J8j5IWhmZxNWaHjR7sb/lpOk
 nl66EuZu7xYUs7OMMR1lEENVjAaqJ9JPrkEuwlN1dH8ftpO1GnGVG+7Qa6KSW5aiTxBx
 mfXzyvM3Eq9vZHDbNifsIXH+8FDwzBNe1qrA6Ak4plLPi+IvV/6CTGK2NU1Pr9NXI8Mq
 6zcP2VKk0eAKWZAPZ8Oqs94TIyqqRUXra0u6g3t5/XhHCl5cyfl5m4BDwukvHSF1KEdw
 rF0Q==
X-Gm-Message-State: AGi0PuYXC6+2pqO7jGPBQ2SmeYay8WgsCn8szl45+MnUpXLz+tb5LwJF
 jvrGhVON22HFZxr9RNX6EVTRxMAdvEk=
X-Google-Smtp-Source: APiQypK+cq89WeLYI1RwfboNkXbUTwFQWC0Iqy/wAT6hkFd4ez62sJtPp1GJhTn4LPHfirFvcsbvfA==
X-Received: by 2002:adf:eecc:: with SMTP id a12mr19187906wrp.112.1587400185776; 
 Mon, 20 Apr 2020 09:29:45 -0700 (PDT)
Received: from localhost ([193.165.97.202])
 by smtp.gmail.com with ESMTPSA id h2sm45077wro.9.2020.04.20.09.29.44
 for <cygwin-patches@cygwin.com>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 20 Apr 2020 09:29:45 -0700 (PDT)
Date: Mon, 20 Apr 2020 18:29:41 +0200
From: David Macek <david.macek.0@gmail.com>
To: cygwin-patches@cygwin.com
Subject: License declaration
Message-ID: <20200420182936.000023a4@gmail.com>
X-Mailer: Claws Mail 3.15.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_ENVFROM_END_DIGIT,
 FREEMAIL_FROM, RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 20 Apr 2020 16:29:49 -0000

Patches to the Cygwin sources sent by me are licensed under the
2-clause BSD license.  This applies to all past patches as well.

I'll try to add a Signed-off-by to each patch.

-- 
David Macek
