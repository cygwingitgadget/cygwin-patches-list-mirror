Return-Path: <david.macek.0@gmail.com>
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by sourceware.org (Postfix) with ESMTPS id 5B2E33858D31
 for <cygwin-patches@cygwin.com>; Mon, 20 Apr 2020 17:21:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5B2E33858D31
Received: by mail-wm1-x341.google.com with SMTP id u127so439478wmg.1
 for <cygwin-patches@cygwin.com>; Mon, 20 Apr 2020 10:21:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-transfer-encoding;
 bh=7XP//2LWil/YEd01zWwD/6Y0oBf3xTDUe9e3HP4zMO0=;
 b=k+MtTik1CnFKbLv/muDALt+y73+7GiDV+ZtFsmBnTNVM2QhvuF0jWD5OjW4wNTJUgx
 NcEg8ybhfK9YbM31K/4U09qwY0c6Yd1EnMpJmgg6FFrdE0bIZrWhEOqBIJGXP+mykSn0
 4OCg7iSSBe0zq3oPd/tRr/MYu/6GvKfPuLEbSi9sUczq0m8ng6hUaRm4xO/2ZDCxvur0
 6Atbq7Y9bvcHSqzohoTFrSaWoANrGJ3OVzWOaTZqC3j12zVGfZKDTHu7LOmiz0sw9ePE
 TPcosSMh5DvpxD13mTPxeW731dZhK2MZ+08m9djzRNpwW4Oi3h8CdnuEZb4zBkwMmA13
 Yiaw==
X-Gm-Message-State: AGi0PuYyxpCRj5Sr3TM3Cu7Ip+f+72JG5zA41uhgQFajX3KYn/ws+r0g
 mOD+vyiBAAFIVNMgJA4tHDKz3JUYLso=
X-Google-Smtp-Source: APiQypI5qMUDkW0dYi97gNH9Ph5uNJeFrimDDAv9WTN8vmuooLkIPiwGGsLpLkVANuzNnZaYOiKepQ==
X-Received: by 2002:a1c:678a:: with SMTP id b132mr365460wmc.107.1587403279251; 
 Mon, 20 Apr 2020 10:21:19 -0700 (PDT)
Received: from localhost ([193.165.97.202])
 by smtp.gmail.com with ESMTPSA id r2sm136471wmg.2.2020.04.20.10.21.18
 for <cygwin-patches@cygwin.com>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 20 Apr 2020 10:21:18 -0700 (PDT)
Date: Mon, 20 Apr 2020 19:21:15 +0200
From: David Macek <david.macek.0@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/3] Cygwin: accounts: Report unrecognized db_*
 nsswitch.conf keywords
Message-ID: <20200420192113.00000a16@gmail.com>
X-Mailer: Claws Mail 3.15.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-20.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_ENVFROM_END_DIGIT,
 FREEMAIL_FROM, GIT_PATCH_0, GIT_PATCH_1, GIT_PATCH_2, GIT_PATCH_3,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 20 Apr 2020 17:21:21 -0000

Signed-off-by: David Macek <david.macek.0@gmail.com>
---
 winsup/cygwin/uinfo.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index b733a6ee87..e105248c20 100644
--- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -828,6 +828,8 @@ cygheap_pwdgrp::nss_init_line (const char *line)
 		  c += strspn (c, " \t");
 		}
 	    }
+	  else
+	      debug_printf ("Invalid nsswitch.conf content: %s", line);
 	}
       break;
     case '\0':
-- 
2.26.1.windows.1

