Return-Path: <cygwin-patches-return-7544-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14945 invoked by alias); 7 Nov 2011 20:59:55 -0000
Received: (qmail 14932 invoked by uid 22791); 7 Nov 2011 20:59:54 -0000
X-SWARE-Spam-Status: No, hits=-7.4 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,SPF_HELO_PASS,TW_CP,TW_FD
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 07 Nov 2011 20:59:41 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pA7Kxfqc019539	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Mon, 7 Nov 2011 15:59:41 -0500
Received: from [10.3.113.131] (ovpn-113-131.phx2.redhat.com [10.3.113.131])	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id pA7KxeFa007179	for <cygwin-patches@cygwin.com>; Mon, 7 Nov 2011 15:59:40 -0500
Message-ID: <4EB846BC.9010003@redhat.com>
Date: Mon, 07 Nov 2011 20:59:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110928 Fedora/3.1.15-1.fc14 Lightning/1.0b3pre Mnenhy/0.8.4 Thunderbird/3.1.15
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: ptsname_r
References: <4EB82DF9.7080408@redhat.com> <20111107193521.GA30056@ednor.casa.cgf.cx> <4EB8437B.5090600@redhat.com> <4EB843B4.4030605@redhat.com>
In-Reply-To: <4EB843B4.4030605@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q4/txt/msg00034.txt.bz2

On 11/07/2011 01:46 PM, Eric Blake wrote:
>> Thanks. Also, even with your patches of today, ptsname() is still not
>> thread-safe; should we be sticking that in a thread-local buffer rather
>> than in static storage, similar to how other functions like strerror()
>> are thread-safe?

I didn't tackle that,

>
> Also, should we have an efault handler in syscalls.cc ptsname_r(),
> similar to ttyname_r(), so as to gracefully reject invalid buffers
> rather than faulting?

but I had this additional code in my sandbox right before your commit 
hit CVS; should I add a ChangeLog and make it a formal patch submission?

diff --git a/winsup/cygwin/include/cygwin/stdlib.h 
b/winsup/cygwin/include/cygwin/stdlib.h
index d2dfe4c..20358ef 100644
--- a/winsup/cygwin/include/cygwin/stdlib.h
+++ b/winsup/cygwin/include/cygwin/stdlib.h
@@ -1,6 +1,6 @@
  /* stdlib.h

-   Copyright 2005, 2006, 2007, 2008, 2009 Red Hat Inc.
+   Copyright 2005, 2006, 2007, 2008, 2009, 2011 Red Hat Inc.

  This file is part of Cygwin.

diff --git a/winsup/cygwin/libc/bsdlib.cc b/winsup/cygwin/libc/bsdlib.cc
index 3b6e7e4..c4398d3 100644
--- a/winsup/cygwin/libc/bsdlib.cc
+++ b/winsup/cygwin/libc/bsdlib.cc
@@ -108,7 +108,7 @@ openpty (int *amaster, int *aslave, char *name, 
const struct termios *termp,
      {
        grantpt (master);
        unlockpt (master);
-      strcpy (pts, ptsname (master));
+      ptsname_r (master, pts, sizeof pts);
        revoke (pts);
        if ((slave = open (pts, O_RDWR | O_NOCTTY)) >= 0)
  	{
diff --git a/winsup/cygwin/posix.sgml b/winsup/cygwin/posix.sgml
index ef27fde..5c510ed 100644
--- a/winsup/cygwin/posix.sgml
+++ b/winsup/cygwin/posix.sgml
@@ -1131,6 +1131,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
      pow10f
      ppoll
      pthread_getattr_np
+    ptsname_r
      removexattr
      setxattr
      strchrnul
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 514d458..68dec59 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -2913,16 +2913,24 @@ ptsname (int fd)
  extern "C" int
  ptsname_r (int fd, char *buf, size_t buflen)
  {
-  if (!buf)
+  int ret = 0;
+  myfault efault;
+  if (efault.faulted ())
+    ret = EFAULT;
+  else
      {
-      set_errno (EINVAL);
-      return EINVAL;
+      cygheap_fdget cfd (fd, true);
+      if (cfd < 0)
+	ret = EBADF;
+      else if (!buf)
+        ret = EINVAL;
+      else
+	ret = cfd->ptsname_r (buf, buflen);
      }
-
-  cygheap_fdget cfd (fd);
-  if (cfd < 0)
-    return 0;
-  return cfd->ptsname_r (buf, buflen);
+  if (ret)
+    set_errno (ret);
+  debug_printf ("returning %d pts: %s", ret, ret ? "NULL" : buf);
+  return ret;
  }

  static int __stdcall

-- 
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org
