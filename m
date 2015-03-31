Return-Path: <cygwin-patches-return-8091-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 90669 invoked by alias); 31 Mar 2015 18:24:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 90649 invoked by uid 89); 31 Mar 2015 18:24:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: Yes, score=5.4 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,KAM_FROM_URIBL_PCCC,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=no version=3.3.2
X-HELO: mail-la0-f51.google.com
Received: from mail-la0-f51.google.com (HELO mail-la0-f51.google.com) (209.85.215.51) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Tue, 31 Mar 2015 18:24:03 +0000
Received: by lahf3 with SMTP id f3so18862412lah.2        for <cygwin-patches@cygwin.com>; Tue, 31 Mar 2015 11:23:59 -0700 (PDT)
X-Received: by 10.152.43.229 with SMTP id z5mr31656136lal.48.1427826239462; Tue, 31 Mar 2015 11:23:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.112.128.195 with HTTP; Tue, 31 Mar 2015 11:23:19 -0700 (PDT)
From: Renato Silva <br.renatosilva@gmail.com>
Date: Tue, 31 Mar 2015 18:24:00 -0000
Message-ID: <CANRwAThfiScOKXc2fOQKOcPLNnJYLSSzQoL5T0oP=eAAC8S+8g@mail.gmail.com>
Subject: Fix error mapping in gethostname
To: Cygwin Patches <cygwin-patches@cygwin.com>
Content-Type: text/plain; charset=ISO-8859-1
X-IsSubscribed: yes
X-SW-Source: 2015-q1/txt/msg00046.txt.bz2

The gethostname function has a problem where a small buffer size will
not produce an accurate errno. This is because the Windows error is
not being appropriately mapped. This causes programs such as hostname
from coreutils to fail because they are not informed about the long
name.

Changelog entry:
2015-03-31  Renato Silva  <br.renatosilva@gmail.com>
    * net.cc: Fix buffer size error handling in cygwin_gethostname.

-----

/* Test case */

#include <errno.h>
#include <stdio.h>
#include <windows.h>

int main(int argc, char **argv) {

    if (argc < 2) {
        printf("Please provide a buffer length.\n");
        return 1;
    }
    DWORD HOSTNAME_LENGTH = atoi(argv[1]);
    char hostname[HOSTNAME_LENGTH];
    char error_message[256];
    int return_value;

    printf("gethostname %s\n", gethostname(hostname, HOSTNAME_LENGTH)?
"failed" : "succeeded");
    if (errno) printf("error is %d, %s\n\n", errno, strerror(errno));
          else printf("hostname is %s\n\n", hostname);

    printf("GetComputerNameEx %s\n", (return_value =
GetComputerNameEx(ComputerNameDnsFullyQualified, hostname,
&HOSTNAME_LENGTH))? "succeeded": "failed");
    FormatMessageA(FORMAT_MESSAGE_FROM_SYSTEM, NULL, GetLastError(),
MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), error_message, 256, NULL);
    if (!return_value) printf("error is %d, %s\n", GetLastError(),
error_message);
                  else printf("hostname is %s\n", hostname);
}

-----

From d691d4b2ac75f00a752c5dc86ab63a4ba425beda Mon Sep 17 00:00:00 2001
From: Renato Silva <br.renatosilva@gmail.com>
Date: Mon, 30 Mar 2015 20:20:49 -0300
Subject: [PATCH] Fix buffer size error handling in gethostname.

GetComputerNameEx sets a generic ERROR_MORE_DATA when buffer is too small. This
is now more accurately mapped into ENAMETOOLONG instead of the generic EPERM.
---
 winsup/cygwin/net.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
index f9b317c..02fa142 100644
--- a/winsup/cygwin/net.cc
+++ b/winsup/cygwin/net.cc
@@ -1076,7 +1076,10 @@ cygwin_gethostname (char *name, size_t len)
       if (!GetComputerNameExA (ComputerNameDnsFullyQualified, name,
                    &local_len))
         {
-          set_winsock_errno ();
+          if (GetLastError () == ERROR_MORE_DATA)
+            set_errno (ENAMETOOLONG);
+          else
+            set_winsock_errno ();
           __leave;
         }
     }
-- 
2.3.4
