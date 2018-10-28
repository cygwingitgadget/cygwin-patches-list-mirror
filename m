Return-Path: <cygwin-patches-return-9184-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 113178 invoked by alias); 28 Oct 2018 19:23:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 113166 invoked by uid 89); 28 Oct 2018 19:23:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.2 spammy=pipe, processes, require, cloned
X-HELO: mail-qk1-f194.google.com
Received: from mail-qk1-f194.google.com (HELO mail-qk1-f194.google.com) (209.85.222.194) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 28 Oct 2018 19:23:11 +0000
Received: by mail-qk1-f194.google.com with SMTP id e4so3677217qkh.6        for <cygwin-patches@cygwin.com>; Sun, 28 Oct 2018 12:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=gmail.com; s=20161025;        h=from:to:cc:subject:date:message-id:mime-version         :content-transfer-encoding;        bh=MjY7/zGmTaLLEMGQEBSm7dsVEozDwJZeyin6O4HrM78=;        b=kLhj20X7617jPZbOtFubleeNj6OKwCmPFYJwZ2AuNKnLtexd9YzMq4CEejEVtQ1KuG         jubGykyqSyDO/GBIFqdmZayEkgOmV95NZ9aF80insdL3L4230n3ThQOQqFNboOe47p3A         XCexl1kyItAjtAU+a5QWYWhKroEPXXVLJ27H54hpM3i7DnJuqFvaL2llH8awOPzCCVCP         HZ1TMSplR99TnzLkjXGQzcITjoaNuJDPDUVip1Q1XDSL6zxO/GSsIvSQvPpX+ZDrjpO+         LYtOG0lFQLhL0hclFGCHNy72eqKWF3mu2PlGIqKEfFIIp/h8aCRTEWdxnv8Iv6dwPi7i         V+Xg==
Return-Path: <corngood@gmail.com>
Received: from localhost.localdomain ([134.41.199.109])        by smtp.gmail.com with ESMTPSA id c21-v6sm9485363qtn.82.2018.10.28.12.23.09        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);        Sun, 28 Oct 2018 12:23:09 -0700 (PDT)
From: David McFarland <corngood@gmail.com>
To: cygwin-patches@cygwin.com
Cc: David McFarland <corngood@gmail.com>
Subject: [PATCH 0/1] Fix deadlocks related to child processes
Date: Sun, 28 Oct 2018 19:23:00 -0000
Message-Id: <20181028192244.4750-1-corngood@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SW-Source: 2018-q4/txt/msg00000.txt.bz2

For a long time I've been struggling with intermittent deadlocks and
segfaults in emacs, seemingly related to invoking child processes.  I
recently found a reliable way to reproduce one such deadlock:

- install clean cygwin with: emacs-w32, clang
- install flycheck from elpa
- grab some non trivial C header e.g.:
  $ cp /usr/include/stdio.h test.h
- $ emacs -q test.h
- start flycheck:
  (progn (package-initialize)
         (require 'flycheck)
         (flycheck-mode))
- add a character to the start of the first line
- wait for flygheck to complete
- repeat the last two steps until a deadlock occurs

Breaking in gdb showed the main thread in `cygheap_protect.acquire ()`,
from either _cfree or _cmalloc.  The thread holding the mutex was always
"flasio", and it would either be continually segfaulting or looping in
_cfree.

I added some debug prints to cygheap and determined that it flasio was
double-freeing an atomic_write_buf.  I added some more prints and found
that it was two different fhandler objects freeing the same buffer.

I then found that `fhandler_base_overlapped::copyto` would clear the
buffer pointer after the copy, but none of the derived classes (pipe,
fifo) did.

Attached is a patch which clears the buffer pointers when copying pipes
and fifos.

It would probably be safer to move the buffer clear to a `operator=`,
but I wanted to keep the patch as simple as possible and avoid
refactoring.


David McFarland (1):
  Cygwin: Fix cygheap corruption caused by cloned atomic buffer

 winsup/cygwin/fhandler.h | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.19.1
