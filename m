Return-Path: <SRS0=S5Go=Z6=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by sourceware.org (Postfix) with ESMTPS id 1D44D3858D26
	for <cygwin-patches@cygwin.com>; Thu, 17 Jul 2025 18:23:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1D44D3858D26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1D44D3858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::536
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752776629; cv=none;
	b=eO/CFodttZ2U9bo7CzcvQ4NtDNDeWN/tQ0tFZmQuntN8lxibpbhzmcoeOW+dCu6btrfHf9ZpD+TbRw/dZDet/l2VrNeMA/GEBL8ebdhhbqDFEaMQHHwRhFFMy8UbRy8KDnD+QJ8uXzXQob8xCLxs2yAPaiM0gTigzq5pzzt9z5Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752776629; c=relaxed/simple;
	bh=kBL2s8vcdXOxrai6vOHnuKiDXBtB5VfNvXFSN6mv20w=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=Leqh8A9JuRCgQ0b6jamGsCLPr/IlzlMMj7Zz7u6/R5AGpEUzM6gEI7+M2StvK9iA6fiQUFulaVx9/ijm1lh9R8ubXnujJW4lB5qERsCryO74z0Z4akTvzY1+j2EpUiGTz63XCJeeHWTYGEtTZzQ7Y8Ren/WYR9j5uRpNHtY8mOg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1D44D3858D26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=j/T/+URm
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so2485846a12.0
        for <cygwin-patches@cygwin.com>; Thu, 17 Jul 2025 11:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752776626; x=1753381426; darn=cygwin.com;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kBL2s8vcdXOxrai6vOHnuKiDXBtB5VfNvXFSN6mv20w=;
        b=j/T/+URmeJxpxrYWAenSL53wyAeEOjsgPW96qwTSgIaNGPqwzTibxWsgo6i82vY610
         tuTnxRnXdLDCRV7/KDDxJUTFs16kH08FHZA0Op5TvQJpPRp6ZdnNueB5lxg3RPCMz/Lw
         lyOqA91HCufY0xG5iMJ8pdpv1fsfXFr/Iv3aQiEn7tTQLtvv7/6LklRI2oOoNJ+BzdZM
         xDbTsycUTLLR2SQLELSSBVWFsIjgr5GQsxmvLjaQ7LCBMWj0p7hqEmsZeXjvgQPiCn2+
         5YG8stcMoR+NobOYMeYADDvQSELUn52uvA16LTy2Pjq6fbCL6qyqaPZbbHImCYvRRjIL
         MKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752776626; x=1753381426;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBL2s8vcdXOxrai6vOHnuKiDXBtB5VfNvXFSN6mv20w=;
        b=c9BX4ha4gfpk87Am+3SkSYNL5fo6ywFY8Mfc540/vijTl5JjElbmUigzqZ4TA7M2db
         8kdSivpQaUAHN5DshNJOSesZuM/bLzNYj2MX63z4Vp/AaiJgS8uOyAxbtTVpZwTBICpQ
         aGHDxOIf6px8JJe7joEVXygTH3/XVLAz9OHbZN7I0jecWM4smAllcyfIBVb/DGb2xVIf
         +Xzpbu0ThdSHt7k0+LpZDiZ8VvX2BMVcdSolIWkT+obpKH+YD+b1F7KUNWgNFvHQ/oGe
         lCPS7XYSloim0EYOn4rSXkKHyEKajmbxT961IKtFTdmd3ZOPa00eZr8IFhSByRSpkEID
         A09w==
X-Gm-Message-State: AOJu0YyT9QuhKchfu9E+5j2k8mdVtBERnQiSnO8Gyd+njZwKlIlESBvp
	n6debJP5XFNQsWlCJovRH8ncfp5mg1YE0HPfS7QhJx9cF++gY0Y0AqSDg7HFdvbrqQHJ1g9csuq
	UV07OjUc3vFD1JqkDDlZAmueuXP042fApbA==
X-Gm-Gg: ASbGncsd9xOUl/zFu/ottQVm76rcGnKF/p99BzTJ02T22Q1ResxftmwJRRA1Y/+5nCL
	OH9Gvshj/7UUJ0Q8SWeSfKdMOyMG1pMWx3WgRA2uSfF7OpkdDrIhRZVhvvZyvaTLtOjVr2A/2cY
	mSYE3v4e2hNFzXyYycjzEZaSd8JYfGkD6y0lBn4uVlYiqBxGX16S/icQ5pj4Ndx/5kroV4rVM35
	EhWPyXScg==
X-Google-Smtp-Source: AGHT+IGthQ7wOEca50Yds3ujY6dLRegseoE8yrMk7adk6M2OuU4dVA3gEYqX8+Ci0m/k55ImfmX/fygwD/qeiRy5TUg=
X-Received: by 2002:a05:6402:430f:b0:60c:44d6:281f with SMTP id
 4fb4d7f45d1cf-6128590b4c6mr7308365a12.7.1752776625903; Thu, 17 Jul 2025
 11:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250713052913.2011-1-johnhaugabook@gmail.com> <aHivhiWyAm-a6NhG@calimero.vinschen.de>
In-Reply-To: <aHivhiWyAm-a6NhG@calimero.vinschen.de>
From: John Haugabook <johnhaugabook@gmail.com>
Date: Thu, 17 Jul 2025 14:23:08 -0400
X-Gm-Features: Ac12FXxmoIq8Q7u_e_cneiswMWH5UwCEHvm3i7FrizEtxw2EV83eM_Dnm-h4J9o
Message-ID: <CAKrZaUv2AMJ4bJZ5HTt9VCqcDBd+TLh_L+4A5z3XKw2kQqCRkw@mail.gmail.com>
Subject: Re: [PATCH 0/4] cygwin: faq-resources.xml add 3.4 reproduce local site
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

No worries. I'll scratch this patchset then.

Take Care,

John Haugabook
