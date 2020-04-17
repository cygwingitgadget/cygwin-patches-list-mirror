Return-Path: <david.macek.0@gmail.com>
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by sourceware.org (Postfix) with ESMTPS id 240E6385B835
 for <cygwin-patches@cygwin.com>; Fri, 17 Apr 2020 09:30:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 240E6385B835
Received: by mail-wr1-x444.google.com with SMTP id j2so2232810wrs.9
 for <cygwin-patches@cygwin.com>; Fri, 17 Apr 2020 02:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version
 :content-transfer-encoding;
 bh=D5VnBNm97DRButadGZlMCGPq0WJeREt5Chuze6c+JQM=;
 b=ZcuvCWPpEgVSjo67GVGoaCjKz8mXuZ6OxT4ry/jh0xvM4V3SDJ/u4YwLdhX5rHNnZt
 nv1GyJaMQRr2umJd4T4uWCCj7XC/gRSNeycgqP6BXnbO2sdt5tVMJfTEsE2YvEMy9bwL
 fiETpxIc5jzIodJgN1xmd+B7F14octjB76x+CxRutihghZXv4z3zlinAijwhdx9OeSJ7
 NPkWHyLr3c57kHv4aWZi1gZgkUkhBTGfyKImwaEw8almJrRvBje+rmKJMh0jHuSDh+G6
 U/0Z5di9kb4Ywu4UAL/0Gm1Ganu1BzPqF08JAWw1wsHJTXbL4VFVtnH5EAOTbfSKgSvX
 X2hw==
X-Gm-Message-State: AGi0PuZgxeLf1QPelMAq49vSP2TE6bIUjUY9nypTBkidchAoeonh8mmn
 LdMJz/bZm6nHQ2+L3NP9dypfI5kZm6Q=
X-Google-Smtp-Source: APiQypI8+by2VpnGvIpBN0KNeIgPDQRtOzv73vz+TOTKc6TLVNx+9NbSP4pndehTq8vqJOqTykSZ/A==
X-Received: by 2002:adf:e2c2:: with SMTP id d2mr3155976wrj.55.1587115855879;
 Fri, 17 Apr 2020 02:30:55 -0700 (PDT)
Received: from localhost ([193.165.97.202])
 by smtp.gmail.com with ESMTPSA id t20sm6533428wmi.2.2020.04.17.02.30.55
 for <cygwin-patches@cygwin.com>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 17 Apr 2020 02:30:55 -0700 (PDT)
Date: Fri, 17 Apr 2020 11:30:51 +0200
From: David Macek <david.macek.0@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH 1/2] cygheap_pwdgrp: Don't invent undocumented defaults in
 nsswitch.conf
Message-ID: <20200417113051.000020ef@gmail.com>
X-Mailer: Claws Mail 3.15.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-22.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 17 Apr 2020 09:30:58 -0000

---
 winsup/cygwin/uinfo.cc | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index 57d90189d3..227faa4248 100644
--- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -831,12 +831,6 @@ cygheap_pwdgrp::nss_init_line (const char *line)
 		  c += strspn (c, " \t");
 		  ++idx;
 		}
-	      /* If nothing has been set, revert to default. */
-	      if (scheme[0].method == NSS_SCHEME_FALLBACK)
-		{
-		  scheme[0].method = NSS_SCHEME_CYGWIN;
-		  scheme[1].method = NSS_SCHEME_DESC;
-		}
 	    }
 	}
       break;
-- 
2.26.1.windows.1

