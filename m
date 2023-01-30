Return-Path: <SRS0=4YYM=53=shaw.ca=brian.inglis@sourceware.org>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id F0A323858D35
	for <cygwin-patches@cygwin.com>; Mon, 30 Jan 2023 05:57:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F0A323858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
	by cmsmtp with ESMTP
	id M5GfpfFr7l2xSMNA9p4Xv5; Mon, 30 Jan 2023 05:57:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1675058225; bh=IPkHRnVTHNqMACteLoWpcfrgWrXEDNis02QQBHwD0ps=;
	h=Date:Reply-To:To:From:Subject;
	b=KhLcNadYr2qHY+OB8YWFuP3PhaPWL6u6iD1EIGLQountjyysOv0oJFQXEDjMrF1ja
	 wnAkDj2xCJuws/K76jdMWOHRDihWprE56DW9JbxM+29P48v7g0pQUcPwpjdUomI2YT
	 cCOEk08IFps48DlYPaPCHGTx8CAUT7fuOyJLKmht3VTiNTXVDiD4SvhGuYpiPwlE3D
	 HLBdAbdpo2BTjbItDTUEwxSU5rzeU32zzVK2mZludihaJdmnXqBdodwn+1G/z2sVdK
	 FPHW20/epQrhWWxpanSWzHhxgEJV34u/SCxNPaoK0p6sEzMzn3J3CrRc+XsiKDTgSK
	 WH6x5QdeSh3MQ==
Received: from [10.0.0.5] ([184.64.124.72])
	by cmsmtp with ESMTP
	id MNA8pmRmaHFsOMNA8pnhDD; Mon, 30 Jan 2023 05:57:05 +0000
X-Authority-Analysis: v=2.4 cv=XZqaca15 c=1 sm=1 tr=0 ts=63d75c31
 a=oHm12aVswOWz6TMtn9zYKg==:117 a=oHm12aVswOWz6TMtn9zYKg==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=lXNhGfK3mzJf4n3Ng9MA:9 a=QEXdDO2ut3YA:10
 a=sRI3_1zDfAgwuvI8zelB:22
Message-ID: <3a9a7529-a8ee-6681-8838-37025e3fd809@Shaw.ca>
Date: Sun, 29 Jan 2023 22:57:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Content-Language: en-CA
To: Cygwin Patches <cygwin-patches@cygwin.com>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
Subject: winsup/cygwin/sys/termios.h bit rates extension
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCJq2LVp9ZhSauHGUO6g8ua1vcIZRUaFsO+7XWFnoMid7/NrOjW5j7QcS2tp7cDjZycXATkqrJVKIuOyCtdnLTZwZcoWjD/LmKmEyvxCxWEYO6fPZpoq
 jxjLiRnwScjsFaAAfouENbG0yuImSdPzh0PlI9P0PybNWFTC6FioXneLFlhdcKEWC5n9ZBld9q3iUQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

FreeBSD, NetBSD, and Linux all bumped their serial bit rates to support 
500k(+500k)4000k, extending the rates to 3500k and 4000k, dropping 128k and 
256k, renumbering the extended baud rate indices under Linux, effectively 
changing the ABI for any previously compiled serial application.

See:
https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/cygwin/include/sys/termios.h;hb=HEAD#l189

Patch would be like:
diff a/winsup/cygwin/include/sys/termios.h b/winsup/cygwin/include/sys/termios.h
--- a/winsup/cygwin/include/sys/termios.h
+++ b/winsup/cygwin/include/sys/termios.h
@@ -190,19 +190,19
  #define CBAUDEX  0x0100f
  #define B57600	  0x01001
  #define B115200  0x01002
-#define B128000  0x01003
-#define B230400  0x01004
+#define B230400  0x01003
-#define B256000  0x01005
-#define B460800  0x01006
+#define B460800  0x01004
-#define B500000  0x01007
+#define B500000  0x01005
-#define B576000  0x01008
+#define B576000  0x01006
-#define B921600  0x01009
+#define B921600  0x01007
-#define B1000000 0x0100a
+#define B1000000 0x01008
-#define B1152000 0x0100b
+#define B1152000 0x01009
-#define B1500000 0x0100c
+#define B1500000 0x0100a
-#define B2000000 0x0100d
+#define B2000000 0x0100b
-#define B2500000 0x0100e
+#define B2500000 0x0100c
-#define B3000000 0x0100f
+#define B3000000 0x0100d
+#define B3500000 0x0100e
+#define B4000000 0x0100f

  #define CRTSXOFF 0x04000
  #define CRTSCTS  0x08000

Is this acceptable, not really any issue for Cygwin, or an issue, and some 
compatibility code would be required to do an internal upgrade, and return an 
error for unsupported speeds, or should we add another bit to extend 
CBAUD/CBAUDEX to 0x0101f, and use higher indices 0x01010/0x01011?

-- 
Take care. Thanks, Brian Inglis			Calgary, Alberta, Canada

La perfection est atteinte			Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter	not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer	but when there is no more to cut
			-- Antoine de Saint-Exupéry
