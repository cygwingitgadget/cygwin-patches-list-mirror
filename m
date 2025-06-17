Return-Path: <SRS0=TcID=ZA=gmail.com=sebastian.n.feld@sourceware.org>
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by sourceware.org (Postfix) with ESMTPS id 900C63851C2B;
	Tue, 17 Jun 2025 07:48:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 900C63851C2B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 900C63851C2B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::530
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750146529; cv=none;
	b=EJPZjO4+9m1uNd0eyN0n+pAGaKZJZ/LXdqfyfG7BPCwQQnKRWGf9in1xgzjQWpxsHtDXjGEopWBzgHHX8qDIVOmwkV2mlkGeB24PoMJESXFs0Krr6qrl5KOYduuBKIPUvJThhCyStYK5vDgKpZeXVxPcjQLiL1VfDgRHGK2xq6I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750146529; c=relaxed/simple;
	bh=h4lxc5+I62xaphiXQwpRR2qTmHjEipKDrkoN4GE1TZ0=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=wlaR6goDES52mAEYI13pqkIgaAw1QIoCk3d01+K7VzJgGk+EJReBEYADcO0WsKXb1PXlBF8YGMRa0Lw8DJyED59WmaDFLyH2aWkzDTBZAzeaO4oKY91S3bdxLO8UNMSuLIRa6fcSsCvaA0W02zFfc3ZdTMJNZOUxg9PQfqLzt40=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 900C63851C2B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=GJauWkfp
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-607c2b96b29so10635693a12.1;
        Tue, 17 Jun 2025 00:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750146527; x=1750751327; darn=cygwin.com;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FoocuGs52eWcomBeKTxtrP1bWIIjuaXtPtDjQtbFkE8=;
        b=GJauWkfp/Q3wdwVv0EHpAPzuo2CVtYukT20of/i8s9odf+fnpZ7VtmYgC1zcrcMKan
         3WoVYfgysOXNjm2eDHHj4ZdiV3JB4R/9mCaZAyfT+DPwz+twlK94j8J3YdIONbPMleKG
         arbXyVMvJyloBMmgOWe4mfO5G7fLBSDx+n0G9XIaCUlM36dufYuD0fttv+RNIhm1XkIF
         DfnixIFu2QiDs0yhNZ/2zhh5WvOnHnr7VJcl9KutqkcnIOYEKcFXjRXYwGkLcWTABtr6
         VKGu2RZ4RouWEiZbHk4ijP9O9CLf8qxx49fCeW77fEJHTkq0hY9y1aubH4lWKsKoH2gD
         fTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750146527; x=1750751327;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FoocuGs52eWcomBeKTxtrP1bWIIjuaXtPtDjQtbFkE8=;
        b=CKumIdmrS6quBDw5u1T1rpY9GHccE1m1Td1ksAdjNY3iwrsH/qI/h+0KxE84rbO0Rv
         pe4uydyViOLNGaXNF04TBjzB05/8HkQi2VX9VFLG/HZs0J1aBtgjkPX8dI+RdB+pOGLJ
         TVRd9soQTryGPoMYJWeOvxWPG5snYYB2g2ltFe+vecEXTHuCoqgCOBu+Q2/ZKj/WU0yV
         NPdPfWewWEtfmI0Nf2J7LIy/9iKyHsa1dAgMGJ1DJlObBWQBcGjs2CDUqqyVqn350iIJ
         C4NzQcfU22EqmDqUxq6ZFnu3o3iaZPmV/Lap2OrRIMKbtFH9Kt+64aDSSls/mGpaf89m
         9OiA==
X-Forwarded-Encrypted: i=1; AJvYcCVyorUyxcmLPEHITEJxnZLBN1VThQRhtQA8PvcBgtcuXkRBVA6O6l8btWzxzfJXW2D3PxutRl8=@cygwin.com
X-Gm-Message-State: AOJu0YwXVhPn1zj7xozaWeZfXikOLjWysQGDkfQg6icr5OJZ0LbTSUjt
	ofsC/6NM+L6BfP6l38yuGpUSjcsnBTkNvGjH1HQhttrrI4FyIo8LDDZYa61FEtohaH0XEYqTDUZ
	ibOb6drvncgPaO5vFS6FAzVEZ3aZ3Sl3sZNCc
X-Gm-Gg: ASbGncuaCymo6bZJSJYRje6iAWAsmIVXe7j1KYtccb9iO/gODMPKfi7zKt9VEqZn/vx
	tfnAs2twTOw164OGskJAhMqPAH1+phkVj120/i0yte9s3Ci4sp1S6CPjGyYMynflG4pDo+vfJEd
	o5hhit1ZYdpKA8Ld8WHNxt6ututbN+tN3iKWDo7r8i2+o=
X-Google-Smtp-Source: AGHT+IF9R7WmfyjSCGTXdIarm1tbe1/DEEgI2bP6Xz9SSPyfvl4KWhXY0B1RdG+nZ2vvJagwdIaOqdjhOMpSv46PKsQ=
X-Received: by 2002:a05:6402:5193:b0:608:176f:9b5c with SMTP id
 4fb4d7f45d1cf-608d09482efmr10787514a12.20.1750146527299; Tue, 17 Jun 2025
 00:48:47 -0700 (PDT)
MIME-Version: 1.0
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Tue, 17 Jun 2025 09:48:10 +0200
X-Gm-Features: AX0GCFsKcYjONhOohmn8djFYbesNuZli2fzf2rQ44xcWVEQkyoGO7586rO4_Ufg
Message-ID: <CAHnbEG+-vkWb3F9HJFNdtMt1wAtm90kz81p8H=0Y7QrGHn50ag@mail.gmail.com>
Subject: [PATCH][API-CONFORMAANCE] Increase SYMLOOP_MAX to 63
To: cygwin-patches@cygwin.com, cygwin@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP,URI_TRY_3LD autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The following patch increases from 10 to 63, per Windows spec
https://learn.microsoft.com/en-us/windows/win32/fileio/reparse-points

Security impact is minor, SYMLOOP_MAX is just an artificial limiter to
prevent endless loops.
But with a value of 10 it is a real world problem, because production
scripts ported from other platforms hit this on a regular basis.
Neither Powershell nor JAVA have such a limit, they all rely on the
Windows object manager to report back if more than 63 reparse points
are traversed.

Thus, the limit should be increased to 63, which is the maximum
supported by the Windows object manager.

---cut---cut---cut---
diff --git a/winsup/cygwin/include/cygwin/limits.h
b/winsup/cygwin/include/cygwin/limits.h
index 204154da9..c61466368 100644
--- a/winsup/cygwin/include/cygwin/limits.h
+++ b/winsup/cygwin/include/cygwin/limits.h
@@ -43,7 +43,13 @@ details. */
#define __SEM_VALUE_MAX 1147483648
#define __SIGQUEUE_MAX 1024
#define __STREAM_MAX 20
-#define __SYMLOOP_MAX 10
+/* __SYMLOOP_MAX
+   https://learn.microsoft.com/en-us/windows/win32/fileio/reparse-points
+   ... There is a limit of 63 reparse points on any given path.
+   NOTE: The limit can be reduced depending on the length of the
+   reparse point. For example, if your reparse point targets a fully
+   qualified path, the limit becomes 31. */
+#define __SYMLOOP_MAX 63
#define __TIMER_MAX 32
#define __TTY_NAME_MAX 32
#define __FILESIZEBITS 64
---cut---cut---cut---

What is the next step to get this patch committed and pushed?

Sebi
-- 
Sebastian Feld - IT security consultant
