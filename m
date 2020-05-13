Return-Path: <david.macek.0@gmail.com>
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by sourceware.org (Postfix) with ESMTPS id B4E633851C0D
 for <cygwin-patches@cygwin.com>; Wed, 13 May 2020 15:34:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B4E633851C0D
Received: by mail-wr1-x435.google.com with SMTP id y3so21430873wrt.1
 for <cygwin-patches@cygwin.com>; Wed, 13 May 2020 08:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UyEZdaDlOK09zmN+be30C2a6WOAdFkhHMDG6rvsy8zc=;
 b=YRCaRp/1Y9HBu3x0IrCOPmVxsLKpyFFIaA58ArAr7In/17wSq8MLo5XVSGGLjQB6vH
 cMOGX4VcbkXaWvSPHI9Q7As2w3lZYcRROC0g9cIJdyvTac8cwWYgFwRM/iuPmMVWxHoL
 bbdogNypx0c4078GSldNxcUfmKwqNYggFkro3HGodZsqosSKXFSqdRSUkaFjM94Rs0dE
 p9YMoFStvYx3i0u2q9Eq88ts6q3B21EoTA0PMDI+zEXMaOFTcKTolCf9ZlZ3cAGWTela
 U6ePux3hippU93Pcamtpws0B9nDwoJHMUDRvgiD4vKflKnGkQpx4BXJw2koYWPn+YZyb
 d7wQ==
X-Gm-Message-State: AGi0Pub91EASSuGtIfZCUM8tKGTnIUSZYsMVmOLDinAIEbuoIAVs6LpA
 rz2QWPd1a2io7+FxaCHQ4cbmIxvR
X-Google-Smtp-Source: APiQypKzIvPLqcx92Rn2y94E3Y6sovIu6EC55d0+sB2/DorUWQJNbftBYNHzHpyLjvbdFUrKPqPNFw==
X-Received: by 2002:adf:f102:: with SMTP id r2mr30968369wro.316.1589384050446; 
 Wed, 13 May 2020 08:34:10 -0700 (PDT)
Received: from localhost ([193.165.97.191])
 by smtp.gmail.com with ESMTPSA id 18sm23406973wmj.19.2020.05.13.08.34.09
 for <cygwin-patches@cygwin.com>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 08:34:09 -0700 (PDT)
Date: Wed, 13 May 2020 17:34:06 +0200
From: David Macek <david.macek.0@gmail.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] cygwin: doc: Add keywords for ACE order issues
Message-ID: <20200513173402.00004eda@gmail.com>
In-Reply-To: <3749ce9f7c2eaeee1f600c4e8bede070f332bb69.camel@redhat.com>
References: <3749ce9f7c2eaeee1f600c4e8bede070f332bb69.camel@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_ENVFROM_END_DIGIT,
 FREEMAIL_FROM, GIT_PATCH_0, RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 13 May 2020 15:34:13 -0000

Windows Explorer shows a warning with Cygwin-created DACLs, but putting
the text of the warning into Google doesn't lead to the relevant Cygwin
docs.  Let's copy the warning text into the docs in the hopes of helping
confused users.  Most of the credit for the wording belongs to Yaakov
Selkowitz.

Latest inquiry: <https://cygwin.com/pipermail/cygwin/2020-May/244814.html>

Signed-off-by: David Macek <david.macek.0@gmail.com>
---

I thought about the wording and there was one one advantage of the
clumsy variant -- anyone intending to modify the paragraph would
immediately know why the full message is there (in my opinion it
doesn't add much value for the reader).  In any case, here's the
variant with nicer wording (which I also like better).

 winsup/doc/ntsec.xml | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
index 08a33bdc6c..8644965349 100644
--- a/winsup/doc/ntsec.xml
+++ b/winsup/doc/ntsec.xml
@@ -2159,11 +2159,13 @@ will correctly deal with the ACL regardless of the order of allow and
 deny ACEs.  The second rule is not modified to get the ACEs in the
 preferred order.</para>
 
-<para>Unfortunately the security tab in the file properties dialog of
-the Windows Explorer insists to rearrange the order of the ACEs to
-canonical order before you can read them. Thank God, the sort order
-remains unchanged if one presses the Cancel button.  But don't even
-<emphasis role='bold'>think</emphasis> of pressing OK...</para>
+<para>Unfortunately, the security tab in the file properties dialog of
+the Windows Explorer will pop up a warning stating "The permissions on
+... are incorrectly ordered, which may cause some entries to be
+ineffective."  Pressing the Cancel button of the properties dialog
+fortunately leaves the sort order unchanged, but pressing OK will cause
+Explorer to canonicalize the order of the ACEs, thereby invalidating
+POSIX compatibility.</para>
 
 <para>Canonical ACLs are unable to reflect each possible combination
 of POSIX permissions. Example:</para>
-- 
2.26.2.windows.1

