Return-Path: <cygwin-patches-return-5958-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32657 invoked by alias); 21 Aug 2006 17:52:22 -0000
Received: (qmail 32646 invoked by uid 22791); 21 Aug 2006 17:52:22 -0000
X-Spam-Check-By: sourceware.org
Received: from nf-out-0910.google.com (HELO nf-out-0910.google.com) (64.233.182.190)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 21 Aug 2006 17:52:13 +0000
Received: by nf-out-0910.google.com with SMTP id d4so430224nfe         for <cygwin-patches@cygwin.com>; Mon, 21 Aug 2006 10:52:06 -0700 (PDT)
Received: by 10.49.29.2 with SMTP id g2mr8033904nfj;         Mon, 21 Aug 2006 10:52:06 -0700 (PDT)
Received: by 10.78.179.13 with HTTP; Mon, 21 Aug 2006 10:52:06 -0700 (PDT)
Message-ID: <a6355d0d0608211052l6f756d9fq16f6ed3f1f7bba3e@mail.gmail.com>
Date: Mon, 21 Aug 2006 17:52:00 -0000
From: "Wang Yiping" <ypwangandy@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] do_mount bug fix
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00053.txt.bz2

When doing managed mount with none exist win32path It can't umount again.
We have to delete the entry from the windows registry by hand.

$ df
Filesystem           1K-blocks      Used Available Use% Mounted on
D:\dev\cygwin\home\ypeang\tmp
                      36862556  32039836   4822720  87% /home/ypwang/tmp
$ umount /home/ypwang/tmp
umount: /home/ypwang/tmp: No such file or directory


2006-08-21  Yiping Wang  <ypwangandy@gmail.com>

        * mount.cc (do_mount): Exit with error msg when using managed mount
        option on none exist win32path.

Index: mount.cc
===================================================================
RCS file: /cvs/src/src/winsup/utils/mount.cc,v
retrieving revision 1.37
diff -u -p -r1.37 mount.cc
--- mount.cc    3 Aug 2005 09:23:39 -0000       1.37
+++ mount.cc    21 Aug 2006 17:41:03 -0000
@@ -122,6 +122,8 @@ do_mount (const char *dev, const char *w
              exit (1);
            }
        }
+      else
+        error (dev);
     }

   if (mount (dev, where, flags))



Best Regards

Andy
