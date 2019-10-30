Return-Path: <cygwin-patches-return-9796-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9176 invoked by alias); 30 Oct 2019 15:48:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 9091 invoked by uid 89); 30 Oct 2019 15:48:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-15.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3 autolearn=ham version=3.3.1 spammy=cygwincom, cygwin.com
X-HELO: nihsmtpxway.hub.nih.gov
Received: from nihsmtpxway.hub.nih.gov (HELO nihsmtpxway.hub.nih.gov) (128.231.90.103) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 30 Oct 2019 15:47:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;  d=nih.gov; i=@nih.gov; q=dns/txt; s=NIH; t=1572450478;  x=1603986478;  h=from:to:cc:subject:date:message-id;  bh=ti49Bu9gKHpr9XTK+psjfIT6qGqER0kBjq9VUfoUVmA=;  b=Rr7oBTl8bH8+jCyhHXHanE985mfQLBAE5gha5XlvHOqoZjtn0izZVwtJ   1nO4sgFMcucn9VMA8RUYL9G08i0mFBclKOPhqdBRCaBxKU71Vkijw2gip   SpPJ50U4q5q/TXijwEZmOCTAtP8JvxWmS7RcmUZfb8W0PNFGmfVkgADur   18CyFzHg8hSVp5aupGh443YIMmb54BKOMdgI1cPAplLQSLCzr6R2qyvUo   pASvWiFSbnTWg9hYF1llc0n+KddAY9+jxRekh62Wbjt2meZ97vK9HIRGT   b6hBVFDGqFdDNgpp0pvW46sQMkmEG8Z6aPYPFAhHvgdOCf5CpzPoWl1rz   A==;
IronPort-SDR: TAalYmFtj7GZ90K5U1mzKp/haXxbvxsx9B5X8xlQjgdA7qh/TmW6Ra4x7zK4pKtDmzH+raJlKC UTqH0lMwY9tS+0RDIbnCsXugJQ+9erQ6j0k4A8NU5dEW95FVNzOGQUnPxfiMHRGbzNi+unMqds VH2lbo4NWwV/NUZlPGUhACsKtBF85Yv+XaGZZsISDolj7Sk2HST4bssELkbLUzZyZJA7adiebJ HVE6k17vVoGFA2xsr+i7DMBfiV2/KVBxeL7CrfBIPE8Hd/e0GykwM1RjvIsE7UMalkkWyBEa0H gRA=
Received: from msg-b12-ltm1_v9.hub.nih.gov (HELO mail2.ncbi.nlm.nih.gov) ([128.231.90.73])  by nihsmtpxway.hub.nih.gov with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 11:47:33 -0400
Received: from coredev2.be-md.ncbi.nlm.nih.gov (coredev2.be-md.ncbi.nlm.nih.gov [130.14.24.61])	by mail2.ncbi.nlm.nih.gov (Postfix) with ESMTP id 702A71A0002;	Wed, 30 Oct 2019 11:47:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ncbi.nlm.nih.gov;	s=ncbi-nlm; t=1572450452;	bh=pkozW09XU2rG3fJhg+2N/g60DnMXMoRnPFX0Q9eNLGg=;	h=From:To:Cc:Subject:Date;	b=mBzTsp8SS+aLvXUu326be437/32Fl6m3m7hHOW1+Oe5tazGFMXgB123iwH0L4eFqG	 A8hmGGxY5P33WS5xlc+YFjROVs5MZk6eEPDJZWKy+FAe1u7be3dUWpwX2mdt51Ostk	 LLBrj/ZwOpJr/U8vMeeZDHSnoRVNeVBAa+pWC+Ug=
Received: from coredev2.be-md.ncbi.nlm.nih.gov (localhost [127.0.0.1])	by coredev2.be-md.ncbi.nlm.nih.gov (Postfix) with ESMTP id 211A11DBD5;	Wed, 30 Oct 2019 11:47:32 -0400 (EDT)
From: "Anton Lavrentiev via cygwin-patches" <cygwin-patches@cygwin.com>
Reply-To: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
To: cygwin-patches@cygwin.com
Cc: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
Subject: [PATCH] Cygwin: getpriority() consistent with process priority
Date: Wed, 30 Oct 2019 15:48:00 -0000
Message-Id: <20191030154725.4720-1-lavr@ncbi.nlm.nih.gov>
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00067.txt.bz2

https://cygwin.com/ml/cygwin/2019-08/msg00122.html
---
 winsup/cygwin/syscalls.cc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index a914ae8..20126ce 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -3977,7 +3977,12 @@ getpriority (int which, id_t who)
       if (!who)
 	who = myself->pid;
       if ((pid_t) who == myself->pid)
-	return myself->nice;
+        {
+          DWORD winprio = GetPriorityClass(GetCurrentProcess());
+          if (winprio != nice_to_winprio(myself->nice))
+            myself->nice = winprio_to_nice(winprio);
+          return myself->nice;
+        }
       break;
     case PRIO_PGRP:
       if (!who)
-- 
2.8.3
