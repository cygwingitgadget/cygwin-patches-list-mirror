Return-Path: <cygwin-patches-return-8272-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 96722 invoked by alias); 20 Nov 2015 21:24:38 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 96708 invoked by uid 89); 20 Nov 2015 21:24:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail.electricalscience.com
Received: from rhino.electricalscience.com (HELO mail.electricalscience.com) (66.228.46.148) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Fri, 20 Nov 2015 21:24:36 +0000
Received: from [192.168.89.101] (ool-ae2c5ae8.dyn.optonline.net [174.44.90.232])	(authenticated bits=0)	by mail.electricalscience.com (8.14.4/8.14.4) with ESMTP id tAKLOYe9009141	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)	for <cygwin-patches@cygwin.com>; Fri, 20 Nov 2015 16:24:34 -0500
From: Andy Stevens <stevens@electricalscience.com>
Subject: patch to cron
To: cygwin-patches@cygwin.com
Message-ID: <564F8F88.30905@electricalscience.com>
Date: Fri, 20 Nov 2015 21:24:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101 Thunderbird/38.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2015-q4/txt/msg00025.txt.bz2

Hello Cygwin patchers, this is my first submission, hope I do OK.

I have discovered a bug in Vixie's cron in the bash script
/usr/bin/cron-config. The bug only appears on Windows 10 which has
an NT version of "10.0". This breaks the version checking in the
bash script. (Bash only supports integer compare or ASCII compare,
but not float compare.)

Below is my proposed patch.  Thanks to
http://stackoverflow.com/questions/8654051 for this bash magic.


--- /usr/bin/cron-config        2015-01-21 23:34:21.000000000 -0500
+++ cron-config 2015-11-20 16:08:24.574218000 -0500
@@ -126,7 +126,10 @@
      nt2003=""
      nt=$(uname -s | sed -ne 's/^CYGWIN_NT-\([^ ]*\)/\1/p')
      [ -z "$nt" ] && echo "Unknown system name" && return 1
-    [ "$nt" \> 5.1 ] && nt2003=yes
+    minver=5.1
+    if [ ${nt%.*} -eq ${minver%.*} ] && [ ${nt#*.} \> ${minver#*.} ] || [ ${nt%.*} -gt ${minver%.*} ]; then
+       nt2003=yes
+    fi
      return 0
  } # === End of get_NT() === #



Best,

--Andy Stevens
Electrical Science, Inc.
114 Pearl St., Suite 2B
Port Chester, NY 10573 USA
Office: +1-914-939-7396
Mobile: +1-646-552-0732
Email: stevens@electricalscience.com
Web: www.electricalscience.com

